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
    stopifnot(length(name) == 1)
    glue("::group::{name}") %>% octocat()
}

#' @rdname octo_start_group
#' @export
octo_end_group <- function() {
    octocat("::endgroup::")
}

#' Masking a value in the GHA log.
#'
#' This will set an envvar `OCTOLOG_MASK*` containing the value and masks it.
#' @param value A single value to mask, coercible to string.
#' @seealso [Github Docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#masking-a-value-in-log)
#' @export
octo_mask_value <- function(value) {
    stopifnot(length(value) == 1)
    var <- tempfile("OCTOLOG_MASK") %>%
        basename() %>%
        toupper()
    args <- list()
    args[var] <- value
    do.call(Sys.setenv, args)
    glue("::add-mask::${var}") %>% octocat()
}

#' Set an output parameter
#'
#' Set an actions output parameter. These can be accessed in later steps.
#' @param name A character vector length 1.
#' @param value A single line string. Use [encode_string()] to encode a numeric
#'   or multiline string.
#' @seealso [Github Docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-an-output-parameter)
#' @examples
#' Sys.setenv(GITHUB_ACTION = "true")
#' string <- "A multi-line \n String."
#' value <- encode_string(string)
#' octo_set_output("importan-value", value)
#' @export
octo_set_output <- function(name, value) {
    stopifnot(length(value) == 1)
    stopifnot(length(name) == 1)
    stopifnot(is.character(value))
    glue("::set-output name={name}::{value}") %>% octocat()
}

#' Stop workflow commands
#'
#' This will stop github from processing any workflow commands until
#' [octo_start_commands()] is called with the correct `token`.
#' @param token A unique token used to restart workflow command parsing.
#' @return The `token` needed to reactivate the workflow command parsing.
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "true")
#' tk <- octo_stop_commands()
#' # Commands will not be parsed by Github Actions
#' octo_start_commands(tk)
#' @export
octo_stop_commands <- function() {
    token <- tempfile("octotoken") %>% basename()
    glue("::stop-commands::{token}") %>% octocat()

    token
}

#' @rdname octo_stop_commands
#' @export
octo_start_commands <- function(token) {
    glue("::{token}::") %>% octocat()
}

# #' @export
# #' @seealso [Github Docs](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#echoing-command-outputs)
# octo_echo_on <- function() {

# }

# #' @rdname octo_echo_on
# octo_echo_off <- function() {

# }

# #' @export
# octo_save_state <- function(name, value) {

# }

# #' @export
# octo_set_envvar <- function(name, value) {

# }
