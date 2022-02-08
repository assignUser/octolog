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
      
    Message <rlang_message>
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
      ::notice file=universe.R,line=23,endLine=42,col=3,endCol=27::A notice

---

    Code
      octo_warn("A warning")
    Output
      ::warning file=universe.R,line=23,endLine=42,col=3,endCol=27::A warning

---

    Code
      octo_abort("An error")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::An error
    Error <rlang_error>
      An error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::An error

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
      
    Message <rlang_message>
      [1m[22mA notice

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
      ::notice file=universe.R,line=23,endLine=42,col=3,endCol=27::A notice

---

    Code
      octo_warn("A warning")
    Output
      ::warning file=universe.R,line=23,endLine=42,col=3,endCol=27::A warning

---

    Code
      octo_abort("An error")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::An error
    Error <rlang_error>
      [1m[22mAn error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::An error

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
      
    Message <rlang_message>
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
      ::notice file=universe.R,line=23,endLine=42,col=3,endCol=27::A notice

---

    Code
      octo_warn("A warning")
    Output
      ::warning file=universe.R,line=23,endLine=42,col=3,endCol=27::A warning

---

    Code
      octo_abort("An error")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::An error
    Error <rlang_error>
      An error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::An error

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
      
    Message <rlang_message>
      [1m[22mA notice

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
      ::notice file=universe.R,line=23,endLine=42,col=3,endCol=27::A notice

---

    Code
      octo_warn("A warning")
    Output
      ::warning file=universe.R,line=23,endLine=42,col=3,endCol=27::A warning

---

    Code
      octo_abort("An error")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::An error
    Error <rlang_error>
      [1m[22mAn error

---

    Code
      octo_abort("An error", .fail_fast = FALSE)
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::An error

