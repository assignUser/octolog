.onLoad <- function(libname, pkgname) {
    if (is.null(getOption("cli.num_colors"))) {
        enable_github_color()
    }
}
