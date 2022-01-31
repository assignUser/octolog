#' Detect if R is running within a Github Action.
#'
#' @return `TRUE` if on Github. `FALSE` otherwise.
#' @details Uses `GITHUB_ACTIONS` envvar`.
#' @examples
#' on_github()
#' @export
on_github <- function() {
  tolower(Sys.getenv("GITHUB_ACTIONS")) == "true"
}


#' "cat" a string if on Github
#'
#' Prints a `string` if on Github, detected via env var `GITHUB_ACTIONS ==
#' 'true'`.
#'
#' @param string A character vector of length 1. This string will be terminated
#'   with `last` and printed with a new line.
#' @return `string` invisibly
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "true")
#' octocat("::error ::Something is wrong")
#' Sys.unsetenv("GITHUB_ACTIONS")
#' octocat("::error ::Something is wrong")
#'
#' @export
octocat <- function(string) {
  if (on_github()) {
    stopifnot(is.character(string))
    stopifnot(length(string) == 1)
    cat(string, "\n", sep = "")
  }

  invisible(string)
}

#' Prepare a String for Github
#'
#' This will format the string with [cli::format_message()] and encode it to be
#' in one line for Github Action output.
#' @inheritParams encode_string
#' @noRd
prepare_string <- function(string, .envir = parent.frame()) {
  string %>%
    cli::format_message(.envir = .envir) %>%
    encode_string()
}

#' Encode String for Github Actions
#'
#' Encodes a multiline string into one line for Github Action output.
#'
#' This will only encode '%', '\\n', '\\r' as these will be automatically
#' decoded by Github when using the output via `${{
#' steps.<step_id>.outputs.<name> }}`. You can use [utils::URLencode()] instead
#' of this function to also escape everything else problematic like (double)
#' quotes etc. but you will have to manually use [utils::URLdecode()] to revert
#' this.
#' @param string A character vector.
#' @param join Join vector into single string using encoded newline.
#' @return A character vector (of length 1 if `join`).
#' @examples
#' chrs <- c("100% This is some output with \n", "a new line")
#' encode_string(chrs)
#'
#' # encode some md (e.g. to post as comment)
#' md <- c("# Important PR Comment", " ", "This commit is great!")
#' encode_string(md, TRUE)
#' @export
encode_string <- function(string, join = FALSE) {
  encoded <- string %>%
    gsub("%", "%25", .) %>%
    gsub("\n", "%0A", .) %>%
    gsub("\r", "%0D", .)

  if (join) {
    encoded <- paste0(encoded, collapse = "%0A")
  }

  encoded
}
utils::globalVariables(".", "octolog")

#' Enable/disable Colors on Github Actions
#'
#' This will set the envvar `R_CLI_NUM_COLORS` to `n_colors` within the scope of
#' `.local_envir`.  To avoid sideeffects through overriding
#' [crayon::has_color()], this function only works [on_github()].
#' @param n_colors An integer giving the number of colors. Default 24bit.
#' @param quiet Should messages be printed?
#' @inheritParams withr::local_envvar
#' @return Invisibly returns `TRUE` if enabling/disabling was successful,
#'   `FALSE` otherwise.
#' @examples
#' Sys.setenv(GITHUB_ACTIONS = "true")
#' enable_github_colors()
#' Sys.setenv(GITHUB_ACTIONS = "false")
#' enable_github_colors()
#' @export
enable_github_colors <- function(n_colors = as.integer(256^3),
                                 .local_envir = parent.frame(), quiet = FALSE) {
  if (on_github()) {
    ct <- Sys.getenv("R_CLI_NUM_COLORS", unset = NA_character_)
    if (is.na(ct)) {
      withr::local_envvar(
        "R_CLI_NUM_COLORS" = n_colors,
        .local_envir = .local_envir
      )

      if (!quiet) cli::cli_alert_success("Enabled colors!")
    } else {
      if (!quiet) cli::cli_alert_info("{.envvar R_CLI_NUM_COLORS} already set.")
    }
    return(invisible(TRUE))
  }

  invisible(FALSE)
}

#' @rdname enable_github_colors
#' @export
disable_github_colors <- function(.local_envir = parent.frame(),
                                  quiet = FALSE) {
  if (on_github()) {
    withr::local_options(cli.num_colors = 1, .local_envir = .local_envir)
    if (!quiet) {
      cli::cli_alert_danger("Disabeled colors!")
    }

    return(invisible(TRUE))
  }

  invisible(FALSE)
}

#' Extract file path and position from trace_back.
#'
#' @param trace An [rlang::trace_back()] object.
#' @return A string formated for use in Github Action workflow commands.
#' @importFrom rlang `%|%`
#' @noRd
get_location_string <- function(trace) {
  if (is.null(trace)) {
    return("")
  }

  src <- integer(0)

  for (call in trace$call) {
    if (!is.null(attributes(call))) {
      src <- attr(call, "srcref")
      break
    }
  }

  if (length(src) == 0) {
    return("")
  }

  path <- utils::getSrcFilename(src, full.names = TRUE) %>% fs::path_tidy()

  if (!fs::is_absolute_path(path)) {
    path <- fs::path(getwd(), path)
  }

  start_dir <- (Sys.getenv("OCTOLOG_START_DIR", unset = NA_character_) %|%
    ".") %>%
    fs::path_tidy()

  path <- path %>% fs::path_rel(start_dir)


  paste0(
    "file={path},",
    "line={src[[1]]},endLine={src[[3]]},",
    "col={src[[5]]},endCol={src[[6]]}"
  ) %>%
    glue::glue()
}

on_windows <- function() {
  os <- Sys.info()[["sysname"]] %>% tolower()
  os == "windows"
}
