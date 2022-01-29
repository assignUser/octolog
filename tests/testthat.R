
options(keep.source = TRUE)
library(testthat)
library(octolog)

enable_github_colors()

# if (
#     is.na(
#         Sys.getenv("OCTOLOG_START_DIR", unset = NA_character_)
#     )) {
#     rprojroot::find_package_root_file() %>%
#         fs::path_tidy() %>%
#        withr::local_envvar("OCTOLOG_START_DIR" = .)
# }
test_check("octolog")
