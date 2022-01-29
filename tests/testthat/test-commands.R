# rprojroot::find_package_root_file() %>%
#   fs::path_tidy() %>%
#   withr::local_envvar("OCTOLOG_START_DIR" = .)

cli::test_that_cli("groups", {
  withr::local_envvar("GITHUB_ACTIONS" = "true")
  expect_snapshot(octo_start_group("testthat"))
  expect_snapshot(octo_end_group())

  withr::local_envvar("GITHUB_ACTIONS" = "false")
  expect_snapshot(octo_start_group("testthat"))
  expect_snapshot(octo_end_group())
})

cli::test_that_cli("group errors", {
  skip_if_not_installed("rlang", "1.0.0")
  withr::local_envvar("GITHUB_ACTIONS" = "true")
  expect_snapshot(octo_start_group(c("error", "too much")), error = TRUE)

  withr::local_envvar("GITHUB_ACTIONS" = "false")
  expect_snapshot_error(octo_start_group(c("error", "too much")))
})

cli::test_that_cli("masking", {
  withr::local_envvar("GITHUB_ACTIONS" = "true", "SECRET_VAR1" = 42)
  expect_snapshot(octo_mask_value("token2123123"))
  expect_snapshot(octo_mask_envvar("SECRET_VAR1"))

  withr::local_envvar("GITHUB_ACTIONS" = "false", "SECRET_VAR1" = 42)
  expect_snapshot(octo_mask_value("token2123123"))
  expect_snapshot(octo_mask_envvar("SECRET_VAR1"))
})

cli::test_that_cli("masking errors", {
  skip_if_not_installed("rlang", "1.0.0")
  withr::local_envvar("GITHUB_ACTIONS" = "true", "SECRET_VAR1" = 42)
  expect_snapshot(octo_mask_value(c(1, 2)), error = TRUE)
  expect_snapshot_error(octo_mask_envvar(c("VAR1", "VAR2")))
  expect_snapshot_error(octo_mask_envvar("SECRET_VAR"))

  withr::local_envvar("GITHUB_ACTIONS" = "false", "SECRET_VAR1" = 42)
  expect_snapshot_error(octo_mask_value(c(1, 2)))
  expect_snapshot_error(octo_mask_envvar(c("VAR1", "VAR2")))
  expect_snapshot_error(octo_mask_envvar("SECRET_VAR"))
})
