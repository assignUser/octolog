mockery::stub(
  octolog:::signal_github_condition,
  "get_location_string",
  "file=universe.R,line=23,endLine=42,col=3,endCol=27",
  2
)


cli::test_that_cli("groups", {
  withr::local_envvar("GITHUB_ACTIONS" = "true")
  expect_snapshot(octo_start_group("testthat"))
  expect_snapshot(octo_end_group())

  withr::local_envvar("GITHUB_ACTIONS" = "false")
  expect_snapshot(octo_start_group("testthat"))
  expect_snapshot(octo_end_group())
})

cli::test_that_cli("group errors", {
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
  withr::local_envvar("GITHUB_ACTIONS" = "true", "SECRET_VAR1" = 42)
  expect_snapshot(octo_mask_value(c(1, 2)), error = TRUE)
  expect_snapshot(octo_mask_envvar(c("VAR1", "VAR2")), error = TRUE)
  expect_snapshot(octo_mask_envvar("SECRET_VAR"), error = TRUE)

  withr::local_envvar("GITHUB_ACTIONS" = "false", "SECRET_VAR1" = 42)
  expect_snapshot_error(octo_mask_value(c(1, 2)))
  expect_snapshot_error(octo_mask_envvar(c("VAR1", "VAR2")))
  expect_snapshot_error(octo_mask_envvar("SECRET_VAR"))
})

cli::test_that_cli("set_output", {
  withr::local_envvar("GITHUB_ACTIONS" = "true")
  expect_snapshot(octo_set_output(5, c("some", "output")), error = TRUE)
  expect_snapshot(octo_set_output(c(2, 3), "output"), error = TRUE)
  expect_snapshot(octo_set_output("Some Important text to pass on", "pkg-info"))

  withr::local_envvar("GITHUB_ACTIONS" = "false")
  expect_snapshot_error(octo_set_output(5, c("some", "output")))
  expect_snapshot_error(octo_set_output(c(2, 3), "output"))
  expect_snapshot(octo_set_output("Some Important text to pass on", "pkg-info"))
})

cli::test_that_cli("stop_commands", {
  mockery::stub(octo_stop_commands, "openssl::rand_bytes", "token123")
  withr::local_envvar("GITHUB_ACTIONS" = "true")
  expect_snapshot(octo_stop_commands())
  expect_snapshot(octo_start_commands("token123"))

  mockery::stub(octo_stop_commands, "rlang::is_installed", FALSE)
  expect_error(octo_stop_commands(), "must be installed")

  mockery::stub(octo_stop_commands, "tempfile", "token123")
  withr::local_envvar("GITHUB_ACTIONS" = "false")
  expect_snapshot(octo_stop_commands())
  expect_snapshot(octo_start_commands("token123"))
})

test_that("set_envvar", {
  file1 <- tempdir() %>%
    fs::path("gh_env1") %>%
    fs::file_create()
  file2 <- tempdir() %>%
    fs::path("gh_env2") %>%
    fs::file_create()

  withr::defer(unlink(c(file1, file2)))
  withr::local_envvar("GITHUB_ACTIONS" = "false")

  octo_set_envvar(123, "OCTO_VAR1")
  expect_equal(Sys.getenv("OCTO_VAR1", NA_character_), "123")
  Sys.unsetenv("OCTO_VAR1")
  octo_set_envvar(c("line1", "line2"), "OCTO_VAR2")
  expect_equal(Sys.getenv("OCTO_VAR2", NA_character_), "line1\nline2")
  Sys.unsetenv("OCTO_VAR2")
  expect_error(octo_set_envvar(2, c("a", "b")), "length 1")

  withr::local_envvar("GITHUB_ACTIONS" = "true")
  # This has to be set "normally" to make the envvar available to the "echo"
  # system command
  Sys.setenv("GITHUB_ENV" = file1)
  octo_set_envvar(123, "OCTO_VAR1")
  expect_snapshot_file(file1)

  Sys.setenv("GITHUB_ENV" = file2)
  octo_set_envvar(c("line1", "line2"), "OCTO_VAR2")
  expect_snapshot_file(file2)

  Sys.unsetenv("OCTO_VAR1")
  Sys.unsetenv("OCTO_VAR2")
  Sys.unsetenv("GITHUB_ENV")
})

test_that("add_path", {
  file1 <- tempdir() %>%
    fs::path("gh_path1") %>%
    fs::file_create()

  withr::defer(unlink(file1))
  withr::local_envvar("GITHUB_ACTIONS" = "false")

  expect_error(octo_add_path(c("a", "b")), "length 1")
  expect_error(octo_add_path("some dir", check = TRUE), "not be found")

  withr::local_envvar("GITHUB_ACTIONS" = "true")
  # This has to be set "normally" to make the envvar available to the "echo"
  # system command
  Sys.setenv("GITHUB_PATH" = file1)
  mockery::stub(octo_add_path, "getwd", "/absolute/wd")
  octo_add_path("relative/path", check = FALSE)
  octo_add_path("/absolute/path", check = FALSE)
  expect_snapshot_file(file1)
  Sys.unsetenv("GITHUB_PATH")
})
