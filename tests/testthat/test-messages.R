cli::test_that_cli("messages work", {
  mockery::stub(
    octolog:::signal_github_condition,
    "get_location_string",
    "file=universe.R,line=23,endLine=42,col=3,endCol=27",
    2
  )

  skip_if_not_installed("rlang", "1.0.0")
  withr::local_envvar(GITHUB_ACTIONS = "false")

  withr::with_options(list(octolog.debug = TRUE), {
    expect_snapshot(octo_debug("Tracking the error"))
  })
  withr::with_options(list(octolog.debug = FALSE), {
    expect_snapshot(octo_debug("Tracking the error"))
  })

  expect_snapshot(octo_inform("A notice"))
  expect_snapshot_warning(octo_warn("A warning"))
  expect_snapshot_error(octo_abort("An error"))


  withr::local_envvar(GITHUB_ACTIONS = "true")
  expect_snapshot(octo_debug("Tracking the error"))
  expect_snapshot(octo_inform("A notice"))
  expect_snapshot(octo_warn("A warning"))
  expect_snapshot(octo_abort("An error"), error = TRUE)
  expect_snapshot(octo_abort("An error", .fail_fast = FALSE))
})
