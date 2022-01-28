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
    Message <cliMessage>
      [K
    Message <rlang_message>
      A notice
    Message <cliMessage>
      [K

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
    Message <cliMessage>
      [K
    Message <rlang_message>
      [1m[22mA notice
    Message <cliMessage>
      [K

---

    [1m[22mA warning

---

    [1m[22mAn error

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

    [1m[22mAn error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error ::An error

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
    Message <cliMessage>
      [K
    Message <rlang_message>
      A notice
    Message <cliMessage>
      [K

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
    Message <cliMessage>
      [K
    Message <rlang_message>
      [1m[22mA notice
    Message <cliMessage>
      [K

---

    [1m[22mA warning

---

    [1m[22mAn error

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

    [1m[22mAn error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error ::An error

