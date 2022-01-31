#' Grouping log lines
#'
#' These functions make it possible to group lines in the Github Actions log.
#' Groups can not be nested at this point, see this [issue](https://github.com/actions/runner/issues/802).
#' @param name Name of the group, single line.
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "TRUE")
#' octo_start_group("Print stuff")
#' print("Log other output")
#' octo_end_group()
#' @export
#' @seealso [Github Docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#grouping-log-lines)
octo_start_group <- function(name) {
  if (length(name) != 1) {
    octo_abort("Group {.arg name} must be length 1!")
  }

  glue("::group::{name}") %>% octocat()
}

#' @rdname octo_start_group
#' @export
octo_end_group <- function() {
  octocat("::endgroup::")
}

#' Masking a value or envvar in the GHA log.
#'
#' This will mask either a `value` or an envvar and prevent them (or their
#'  content) from showing up in the Github Actions log.
#' \cr ***ATTENTION***: Currently the masking of envvar values will only take
#' effect in the ***NEXT*** step of the workflow. Values that are masked
#' directly are masked immediately. This is not very clear in the Github Docs
#' but very important.
#' @details The masking is not restricted to R output, rather it will work for
#' any logged output. For a practical demonstration please see the
#' [{octolog} example workflow](https://github.com/assignUser/octolog/actions/workflows/test-octolog.yaml)
#'
#' Additionally some values and envvars will be masked automatically by github,
#' though this behaviour is poorly documented. It looks like anything with
#' "TOKEN" will be masked. Related Issues
#' [here](https://github.com/actions/runner/issues/643#issuecomment-823537871)
#' and
#' [here](https://github.com/actions/runner/issues/475#issuecomment-742271143).
#' @param value A single value to mask, coercible to string.
#' @param name Name of the envvar to mask.
#' @seealso [Github Docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#masking-a-value-in-log)
#' @examples
#' octo_mask_value("secret_token123")
#' # The mask takes effect in the NEXT step
#' print("Current token: secret_token123")
#' # Will log as
#' # "Current token:***"
#'
#' Sys.setenv("SECRET_TOKEN" = "007")
#' octo_mask_envvar("SECRET_TOKEN")
#' # The mask takes effect in the NEXT step
#' print(Sys.getenv("SECRET_TOKEN"))
#' # Will log as
#' # "***"
#' @export
octo_mask_value <- function(value) {
  if (length(value) != 1) {
    octo_abort(c("You can only mask one value at a time."))
  }

  glue("::add-mask::{value}") %>% octocat()
}

#' @rdname  octo_mask_value
#' @export
octo_mask_envvar <- function(name) {
  if (length(name) != 1) {
    octo_abort(c("You can only mask one envvar at a time."))
  }
  if (is.na(Sys.getenv(name, NA_character_))) {
    octo_abort("The envvar {.envvar {name}} does not exists!")
  }

  glue("::add-mask::${name}") %>% octocat()
}

#' Set an output parameter
#'
#' Set an actions output parameter. These can be accessed in later steps.
#' @param name A character vector length 1.
#' @param value A single line string (or coercible to character). Use
#'   [encode_string()] to encode a numeric
#'   or multiline string.
#' @seealso [Github Docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-an-output-parameter)
#' @examples
#' Sys.setenv(GITHUB_ACTION = "true")
#' string <- "A multi-line \n String."
#' value <- encode_string(string)
#' octo_set_output("important-value", value)
#' @export
octo_set_output <- function(value, name) {
  if (length(name) != 1) {
    octo_abort(c("The output {.arg name} must be length 1."))
  }
  if (length(value) != 1) {
    octo_abort(c("The output {.arg value} must be length 1."))
  }

  glue("::set-output name={name}::{value}") %>% octocat()
}

#' Stop workflow commands
#'
#' This will stop github from processing any workflow commands until
#' [octo_start_commands()] is called with the correct `token`. This can be used
#' if untrusted output (e.g. issue titles, bodies or commit messages) needs to
#' be logged this can be used to stop this output from running possibly
#' malicious workflow commands.
#' @param token A unique token used to restart workflow command parsing.
#' @return The `token` needed to reactivate the workflow command parsing.
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "true")
#' tk <- octo_stop_commands()
#' # Commands will not be parsed by Github Actions
#' octo_start_commands(tk)
#' @seealso The [example workflow](https://github.com/assignUser/octolog/actions/workflows/test-octolog.yaml)
#' and the [Github Blog](https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/)
#' @export
octo_stop_commands <- function() {
  token <- openssl::rand_bytes(12) %>% paste0(collapse = "")
  glue("::stop-commands::{token}") %>% octocat()

  token
}

#' @rdname octo_stop_commands
#' @export
octo_start_commands <- function(token) {
  glue("::{token}::") %>% octocat()
}

#' Echo workflow commands
#'
#' Enable or disable echoing of workflow commands in the log. This can be useful
#' for debugging. Some commands are always echoed and will not be effected by
#' these functions, this includes [octo_debug()] (if debugging is turned on),
#' [octo_warn()] and [octo_abort()].
#' @export
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "true")
#' octo_echo_on()
#' # workflow commands will be printed in their unparsed state in addition to
#' # their normal effects
#' octo_echo_off()
#' @seealso [Github Docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#echoing-command-outputs)
octo_echo_on <- function() {
  octocat("::echo::on")
}

#' @rdname octo_echo_on
#' @export
octo_echo_off <- function() {
  octocat("::echo::off")
}


#' Set environment variables
#'
#' This will set an environment variable in a way that makes it available to the
#' following steps, compared to using [Sys.setenv()], which would only make an
#' envvar available in the current step.
#' @param value Value of the envvar, coercible to string. Can be a multiline
#'   string or character vector of `length > 1`, each element will be
#'   interpreted as one line.
#' @param name Name of the envvar.
#' @param set Should the envvar also be set in this step?
#' @param delim Delimiter used for multiline strings. No need to change this
#'   unless your string contains 'EOF'.
#' @return `name` invisibly.
#' @examples
#' \dontrun{
#' val <- c("Some content", "that spans", "multiple lines")
#' octo_set_envvar(val, "multi")
#' octo_set_envvar(2342, "pid")
#' }
#' @export
#' @seealso [octo_mask_envvar()]and the
#' [Github docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-an-environment-variable)
octo_set_envvar <- function(value, name, set = TRUE, delim = "EOF") {
  if (length(name) != 1) {
    octo_abort("{.arg name} must be length 1.")
  }

  if (set) {
    rlang::exec(Sys.setenv, "{name}" := glue("{ paste0(value, collapse ='\n') }") %>% as.character())
  }

  if (on_github()) {
    if (on_windows()) {
      cmd <- "| Add-Content -Path $env:GITHUB_ENV"
    } else {
      cmd <- ">> $GITHUB_ENV"
    }
    head <- glue("echo '{name}<<{delim}' {cmd}")
    body <- glue("echo '{value}' {cmd}")
    footer <- glue("echo '{delim}' {cmd}")
    cmd <- paste0(c(head, body, footer), collapse = ";")
    system(command = cmd)
  }

  invisible(name)
}
utils::globalVariables(":=", "octolog")

#' Add a system path
#'
#' Prepends a directory so the runners `PATH` envvar in a way that make it
#' available in the following steps of the action. The `PATH` will not update
#' during this step.
#'
#' @param dir A directory. If relative will turned absolute using
#'   [base::getwd()].
#' @param check Should be checked that `dir` is an existing dir.
#' @return `dir` invisibly.
#' @seealso The [{octolog} example workflow](https://github.com/assignUser/octolog/actions/workflows/test-octolog.yaml)
#' and the [Github Docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#adding-a-system-path).
#' @examples
#' \dontrun{
#' octo_addpath("/.local/bin")
#' }
#' @export
octo_add_path <- function(dir, check = TRUE) {
  if (length(dir) != 1) {
    octo_abort("{.arg dir} must be length 1.")
  }

  if (!fs::is_dir(dir) && check) {
    octo_abort(
      c("The path {.path {dir}} could not be found.")
    )
  }

  if (!fs::is_absolute_path(dir)) {
    dir <- fs::path(getwd(), dir)
  }

  if (on_github()) {
    if (on_windows()) {
      cmd <- "| Add-Content -Path $env:GITHUB_PATH"
    } else {
      cmd <- ">> $GITHUB_PATH"
    }
    glue('echo "{dir}" {cmd}') %>% system()
  }

  invisible(dir)
}
