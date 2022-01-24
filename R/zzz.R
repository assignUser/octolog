# nocov start
.onLoad <- function(libname, pkgname) { # nolint
    if (is.null(getOption("cli.num_colors"))) {
        enable_github_colors()
    }
}

.onUnload <- function(libname, pkgname) { # nolint
    if (!is.na(Sys.getenv("R_COLORS_UNSET", NA_character_))) {
        Sys.unsetenv("R_COLORS_UNSET")
        Sys.unsetenv("R_CLI_NUM_COLORS")
    }
}
# nocov end