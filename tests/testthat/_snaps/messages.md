# messages work [plain]

    Code
      octo_debug("Tracking the error")
    Message <cliMessage>
      ! This is a debug message
      Tracking the error

---

    Code
      octo_debug("Tracking the error")

---

    Code
      octo_inform("A notice")
    Warning <warning>
      A notice

---

    A warning

---

    An error

---

    Code
      octo_debug("Tracking the error")
    Output
      ::debug::Tracking the error 

---

    Code
      octo_inform("A notice")
    Output
      ::notice ::A notice 

---

    Code
      octo_warn("A warning")
    Output
      ::warning ::A warning 

---

    An error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error ::An error 

# messages work [ansi]

    Code
      octo_debug("Tracking the error")
    Message <cliMessage>
      [33m![39m This is a debug message
      Tracking the error

---

    Code
      octo_debug("Tracking the error")

---

    Code
      octo_inform("A notice")
    Warning <warning>
      [1m[22mA notice

---

    [1m[22mA warning

---

    [1m[22mAn error

---

    Code
      octo_debug("Tracking the error")
    Output
      ::debug::[1m[22mTracking the error 

---

    Code
      octo_inform("A notice")
    Output
      ::notice ::[1m[22mA notice 

---

    Code
      octo_warn("A warning")
    Output
      ::warning ::[1m[22mA warning 

---

    [1m[22mAn error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error ::[1m[22mAn error 

# messages work [unicode]

    Code
      octo_debug("Tracking the error")
    Message <cliMessage>
      ! This is a debug message
      Tracking the error

---

    Code
      octo_debug("Tracking the error")

---

    Code
      octo_inform("A notice")
    Warning <warning>
      A notice

---

    A warning

---

    An error

---

    Code
      octo_debug("Tracking the error")
    Output
      ::debug::Tracking the error 

---

    Code
      octo_inform("A notice")
    Output
      ::notice ::A notice 

---

    Code
      octo_warn("A warning")
    Output
      ::warning ::A warning 

---

    An error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error ::An error 

# messages work [fancy]

    Code
      octo_debug("Tracking the error")
    Message <cliMessage>
      [33m![39m This is a debug message
      Tracking the error

---

    Code
      octo_debug("Tracking the error")

---

    Code
      octo_inform("A notice")
    Warning <warning>
      [1m[22mA notice

---

    [1m[22mA warning

---

    [1m[22mAn error

---

    Code
      octo_debug("Tracking the error")
    Output
      ::debug::[1m[22mTracking the error 

---

    Code
      octo_inform("A notice")
    Output
      ::notice ::[1m[22mA notice 

---

    Code
      octo_warn("A warning")
    Output
      ::warning ::[1m[22mA warning 

---

    [1m[22mAn error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error ::[1m[22mAn error 

