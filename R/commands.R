#' Grouping log lines
#'
#' These functions make it possible to group lines in the Github Actions log.
#' Groups can not be nested at this point, see this [isssue](https://github.com/actions/runner/issues/802).
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
#' @details The maskign is not restricted to R output, rather it will work for
#' any logged output. For a practical demonstration please see the
#' [{octolog} example workflow](https://github.com/assignUser/octolog/actions/workflows/test-octolog.yaml)
#'
#' Additionally some values and envvars will be masked autmatically by github,
#' though this behaviour is pporly documented. It looks like anything with
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
#' [octo_start_commands()] is called with the correct `token`. This can be used if untrusted output (e.g. issue titles, bodies or commit messages) needs to be logged this can be used to stop this output from running possibly malicous workflow commands.
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
    token <- tempfile("") %>% basename()
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

# #' @export
# octo_save_state <- function(name, value) {

# }

#' Set environment variables
#'
#' This will set an envrionment variable in a way that makes it available to the
#' following steps, compared to using [Sys.setenv()], which would only make an
#' envvar available in the current step.
#' @param value Value of the envvar, coercible to string. Can be a multiline
#'   string or character vector of `length > 1`, each element will be
#'   interpreted as one line.
#' @param name Name of the envvar.
#' @param set Should the envvar also be set in this step?
#' @param delim Delimter used for multiline strings. No need to change this
#'   unless your string contains 'EOF'.
#' @export
#' @seealso [octo_mask_envvar()]
#' and the [Github docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-an-environment-variable)
octo_set_envvar <- function(value, name, set = TRUE, delim = "EOF") {
    `:=` <- NULL
    if (set) {
        rlang::exec(Sys.setenv, "{name}" := "{ paste(value, sep ='\n') }")
    }

    if (on_github()) {
        head <- glue("echo '{name}<<{delim}' >> $GITHUB_ENV")
        body <- glue("echo '{value}' >> $GITHUB_ENV")
        footer <- glue("echo '{delim}' >> $GITHUB_ENV")
        system(command = paste0(c(head, body, footer), collapse = ";"))
    }
}
