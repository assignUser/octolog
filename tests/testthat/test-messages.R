cli::test_that_cli("messages work", {
  withr::local_envvar(GITHUB_ACTIONS = "false")

  withr::with_options(list(octolog.debug = TRUE), {
    expect_snapshot(octo_debug("Tracking the error"))
  })
  expect_snapshot(octo_debug("Tracking the error"))
  withr::with_envvar(list(R_CLI_NUM_COLORS = 256^3),
  expect_snapshot(octo_inform("A notice"))
  )
  
  expect_snapshot_warning(octo_warn("A warning"))
  expect_snapshot_error(octo_abort("An error"))

withr::local_envvar(GITHUB_ACTIONS = "true")
  expect_snapshot(octo_debug("Tracking the error"))
  expect_snapshot(octo_inform("A notice"))
  expect_snapshot(octo_warn("A warning"))
  expect_snapshot_error(octo_abort("An error"))
  expect_snapshot(octo_abort("An error", .fail_fast = FALSE))

})
