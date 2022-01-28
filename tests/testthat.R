library(testthat)
library(octolog)
options(keep.source = TRUE)

#enable_github_colors()
options(cli.num_colors = 256^3)
test_check("octolog")
