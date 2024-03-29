#' Detect if R is running within a GitHub Action.
#'
#' @return `TRUE` if on GitHub. `FALSE` otherwise.
#' @details Uses `GITHUB_ACTIONS` envvar`.
#' @examples
#' on_github()
#' @export
on_github <- function() {
  tolower(Sys.getenv("GITHUB_ACTIONS")) == "true"
}


#' "cat" a string if on GitHub
#'
#' Prints a `string` if on GitHub, detected via env var `GITHUB_ACTIONS ==
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

#' Prepare a String for GitHub
#'
#' This will format the string with [cli::format_message()] and encode it to be
#' in one line for GitHub Action output.
#' @inheritParams encode_string
#' @noRd
prepare_string <- function(string, .envir = parent.frame()) {
  encode_string(
    cli::format_message(string, .envir = .envir)
  )
}

#' Encode String for GitHub Actions
#'
#' Encodes a multiline string into one line for GitHub Action output.
#'
#' This will only encode '%', '\\n', '\\r' as these will be automatically
#' decoded by GitHub when using the output via `${{
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
  string <- gsub("%", "%25", string)
  string <- gsub("\n", "%0A", string)
  encoded <- gsub("\r", "%0D", string)

  if (join) {
    encoded <- paste0(encoded, collapse = "%0A")
  }

  encoded
}


#' Enable/disable Colors on GitHub Actions
#'
#' This will set the envvar `R_CLI_NUM_COLORS` to `n_colors` within the scope of
#' `.local_envir`.  To avoid side effects through overriding
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
#' @return A string formated for use in GitHub Action workflow commands.
#' @importFrom rlang `%|%`
#' @noRd
get_location_string <- function(trace) {
  if (is.null(trace)) {
    return("")
  }

  src <- integer(0)

  # This would work with $call via partial matching but better
  # to be explicit
  if (utils::packageVersion("rlang") >= "1.0.0") {
    calls <- trace$call
  } else {
    calls <- trace$calls
  }

  for (call in calls) {
    if (!is.null(attributes(call))) {
      src <- attr(call, "srcref")
      break
    }
  }

  if (length(src) == 0) {
    return("")
  }

  path <- utils::getSrcFilename(src, full.names = TRUE)

  if (!is_absolute_path(path)) {
    path <- file.path(getwd(), path)
  } else {
    path <- path.expand(path)
  }

  # For annotations to work the path has to be relative
  # to the repository root
  base_path <- (
    Sys.getenv("OCTOLOG_REPO_DIR", unset = NA_character_) %|% getwd()
  )
  path <- path.expand(path)
  path <- sub(glue("{base_path}/"), "", path)

  glue::glue(
    paste0(
      "file={path},",
      "line={src[[1]]},endLine={src[[3]]},",
      "col={src[[5]]},endCol={src[[6]]}"
    )
  )
}

on_windows <- function() {
  tolower(Sys.info()[["sysname"]]) == "windows"
}
