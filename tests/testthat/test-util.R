test_that("on_github", {
  withr::local_envvar(GITHUB_ACTIONS = "false")
  expect_false(on_github())
  withr::local_envvar(GITHUB_ACTIONS = "true")
  expect_true(on_github())

  # Githubn sets the var to "true"
  withr::local_envvar(GITHUB_ACTIONS = "false")
  expect_false(on_github())
  withr::local_envvar(GITHUB_ACTIONS = "true")
  expect_true(on_github())
})

test_that("octocat", {
  test_string <- "This is a message for Github!"
  withr::local_envvar(GITHUB_ACTIONS = "true")
  expect_snapshot(octocat(test_string))
  withr::local_envvar(GITHUB_ACTIONS = "false")
  expect_snapshot(octocat(test_string))
  expect_equal(octocat(test_string), test_string)
})

test_that("encode_string", {
  chrs <- c("100% This is some output with \n", "a new line")
  md <- c("# Important PR Comment", " ", "This commit is great!")

  expect_snapshot(encode_string(chrs))
  expect_snapshot(encode_string(md, TRUE))
})

cli::test_that_cli("enable_github_colors", {
  env <- environment()
  withr::local_envvar(GITHUB_ACTIONS = "false", , R_CLI_NUM_COLORS = NULL)
  expect_false(enable_github_colors(.local_envir = env))
  expect_false(disable_github_colors())

  withr::local_envvar(
    GITHUB_ACTIONS = "true", R_CLI_NUM_COLORS = NULL, .local_envir = env
    )
  expect_snapshot(enable_github_colors(.local_envir = env))
  withr::local_envvar(GITHUB_ACTIONS = "true", R_CLI_NUM_COLORS = 256^3)
  expect_snapshot(enable_github_colors(.local_envir = env))
  expect_snapshot(disable_github_colors())
  expect_true(disable_github_colors(quiet = TRUE, .local_envir = env))
})

test_that("get_location_string", {
  withr::local_options(keep.source = TRUE)
  old_wd <- getwd()
  withr::defer(setwd(old_wd))
  wd <- tempfile("octo_test")
  dir.create(wd)
  setwd(wd)
  writeLines(
    c(
      "trace_dummy <- function(a = rlang::trace_back()) a",
      "trc <- trace_dummy()"
    ),
    "dummy.R"
  )

  withr::defer(unlink("dummy.R"))

  source("dummy.R")

  expect_equal(get_location_string(NULL), "")
  expect_snapshot(get_location_string(trc))
})
