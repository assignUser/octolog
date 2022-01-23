on_github <- function() {
    tolower(Sys.getenv("GITHUB_ACTIONS")) == "true"
}


#' "cat" a string if on Github
#'
#' Prints a `string` if on Github, detected via env var `GITHUB_ACTIONS ==
#' 'true'`.
#'
#' @param string A character vector of length 1. This string will be terminated
#'   with `last` and printed with [base::cat()].
#' @param last Element to terminate string. Default is `\n`.
#' @return `string` invisibly
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "true")
#' octocat("::error ::Something is wrong")
#' Sys.unsetenv("GITHUB_ACTIONS")
#' octocat("::error ::Something is wrong")
#'
#' @export
octocat <- function(string, last = "\n") {
    if (on_github()) {
        stopifnot(is.character(string))
        stopifnot(length(string) == 1)
        cat(string, last)
    }

    invisible(string)
}

#' Prepare a String for Github
#'
#' This will format the string with [cli::format_message()] and encode it to be
#' in one line for Github Action output.
#' @inheritParams encode_string
#' @noRd
prepare_string <- function(string) {
    string %>%
        cli::format_message() %>%
        encode_string()
}

#' Encode String for Github Actions
#'
#' Encodes a multiline string into one line for Github Action output.
#' @param string A character vector.
#' @return A character vector.
#' @examples
#' chrs <- c("100% This is some output with \n", "a new line")
#' encode_string(chrs)
#' @export
encode_string <- function(string) {
    . <- NULL
    # utils::globalVariables(".", package = "octolog")
    string %>%
        gsub("%", "%25", .) %>%
        gsub("\n", "%0A", .) %>%
        gsub("\r", "%0D", .)
}

#' Enable Colors on Github Actions
#'
#' This will set the option `cli.num_colors` to `color`
#' @param n_colors An integer giving the number of colors. Default 24bit.
#' @return `TRUE` if the option was set, `FALSE` otherwise.
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "true")
#' enable_github_colors()
#' @export
enable_github_colors <- function(n_colors = as.integer(256^3)) {
    if (on_github()) {
        ct <- Sys.getenv("R_CLI_NUM_COLORS", unset = NA_character_)
        if (is.na(ct)) {
            Sys.setenv("R_CLI_NUM_COLORS" = n_colors)
            Sys.setenv("R_COLORS_UNSET" = "true")
            cli::cli_alert_success("Enabled colors!")
        } else {
            cli::cli_alert_info("{.envvar R_CLI_NUM_COLORS} already set.")
        }
        return(TRUE)
    }

    FALSE
}

#' Extract file path and position from trace_back.
#'
#' @param trace An [rlang::trace_back()] object.
#' @return A string formated for use in Github Action workflow commands.
#' @noRd
get_location_string <- function(trace) {
    stopifnot(inherits(trace, "rlang_trace"))
    src <- integer(0)
    for (call in trace$calls) {
        if (!is.null(attributes(call))) {
            src <- attr(call, "srcref")
            break
        }
    }

    if (length(src) == 0) {
        return("")
    }

    paste0(
        "file={fs::path(getSrcDirectory(src), getSrcFilename(src))},",
        "line={src[[1]]},endLine={src[[3]]},",
        "col={src[[5]]},endCol={src[[6]]}"
    ) %>%
        glue::glue()
}