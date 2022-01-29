          octo_start_group("Conditions")

          octo_echo_on()
          octo_debug("Tracking the error")
          octo_inform(c("A notice", i = "And some information"))
          octo_warn("A warning")
          octo_warn(c("A warning", v = "Without a trace"), trace = NULL)
          octo_abort(c("An error that does not kill R", i = "And how to fix it."), .fail_fast = FALSE)
          octo_echo_off()
          
          octo_end_group()