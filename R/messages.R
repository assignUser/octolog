#' @describeIn octo_abort A debug message which is only visible if the secret `ACTIONS_STEP_DEBUG` is set. For local use set option `octolog.debug = TRUE`.
#' @export
octo_debug <- function(message) {
    if (on_github()) {
        signal_github_condition("::debug", message)
    } else if (getOption("octolog.debug", FALSE)) {
        cli::cli_bullets(c("!" = "This is a debug message", message))
    }

    invisible(message)
}

#' @rdname octo_abort
#' @export
octo_inform <- function(message,
                        ...,
                        trace = rlang::trace_back(),
                        title = NULL,
                        .envir = parent.frame()) {
    if (on_github()) {
        signal_github_condition("::notice ", message, trace, title)
    } else {
        cli::cli_inform(message, ..., .envir = .envir)
    }

    invisible(message)
}

#' @rdname octo_abort
#' @export
octo_warn <- function(message,
                      ...,
                      trace = rlang::trace_back(),
                      title = NULL,
                      .envir = parent.frame()) {
    if (on_github()) {
        signal_github_condition("::warning ", message, trace, title)
    } else {
        cli::cli_warn(message, ..., .envir = .envir)
    }

    invisible(message)
}



#' Signal conditions that create Github annotations.
#'
#' These functions are a drop-in replacements for [cli::cli_warn()] and friends.
#' If used while R is running within a Github Action, the conditions will be
#' signaled in such a way that they will create annotations on the files
#' affected. Even if [enable_github_colors()] was used the conditions will not
#' have colors in the log as the color codes break the annotation.
#' 
#' Annotations will only have file and line references if the option
#' `keep.source = TRUE` is set. It defaults to `FALSE` when in non-interactive
#' use. The file path for the annotations will be relative to the envvar
#' `GITHUB_WORKSPACE`, if you want to change that set the envvar
#' `OCTOLOG_START_DIR` to the dir the path should be relative to.
#' @inheritParams cli::cli_abort
#' @param title A custom title for the Github annotation.
#' @param trace An [rlang::trace_back()] will only be passed to [rlang::abort()]
#'   if not [missing()].
#' @param .fail_fast An error on Github will not kill the R process if this is
#'   set to `FALSE`. Use the option `octolog.fail_fast` to set the value
#'   globally.`
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "")
#' octo_warn(c("A warning message", i = "Try something else!"),
#'     title = "Custom Title"
#' )
#' Sys.setenv(GITHUB_ACTIONS = "TRUE")
#' octo_warn(c("A warning message", i = "Try something else!"),
#'     title = "Custom Title"
#' )
#' @seealso [cli::cli_abort()]
#' @export
octo_abort <- function(message,
                       ...,
                       trace = rlang::trace_back(),
                       title = NULL,
                       .envir = parent.frame(),
                       .fail_fast = getOption("octolog.fail_fast") %||% TRUE) {
    if (on_github()) {
        signal_github_condition("::error ", message, trace, title)
    }

    if (!on_github() || .fail_fast) {
        if (missing(trace)) trace <- NULL
        cli::cli_abort(message, ..., trace = trace, .envir = .envir)
    }

    invisible(message)
}

#' Print a github condition
#'
#' @param prefix The condition prefix.
#' @param message The message string which was [preapre_string()]'ed.
#' @param trace An [rlang::trace_back()].
#' @param title An optional title for the conditon.
#' @noRd
signal_github_condition <- function(prefix = c(
                                        "::error ",
                                        "::warning ",
                                        "::notice ",
                                        "::debug"
                                    ),
                                    message,
                                    trace = NULL,
                                    title = NULL) {
    if (is.null(title)) {
        title <- ""
    } else {
        title <- glue(",title={title}")
    }

    loc_str <- get_location_string(trace)

    # Colors work in the log but break the annotations
    disable_github_colors(quiet = TRUE)
    message <- prepare_string(message)
    glue("{prefix}{loc_str}{title}::{message}") %>% octocat()
}
