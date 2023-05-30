# groups [plain]

    Code
      octo_start_group("testthat")
    Output
      ::group::testthat

---

    Code
      octo_end_group()
    Output
      ::endgroup::

---

    Code
      octo_start_group("testthat")

---

    Code
      octo_end_group()

# groups [ansi]

    Code
      octo_start_group("testthat")
    Output
      ::group::testthat

---

    Code
      octo_end_group()
    Output
      ::endgroup::

---

    Code
      octo_start_group("testthat")

---

    Code
      octo_end_group()

# groups [unicode]

    Code
      octo_start_group("testthat")
    Output
      ::group::testthat

---

    Code
      octo_end_group()
    Output
      ::endgroup::

---

    Code
      octo_start_group("testthat")

---

    Code
      octo_end_group()

# groups [fancy]

    Code
      octo_start_group("testthat")
    Output
      ::group::testthat

---

    Code
      octo_end_group()
    Output
      ::endgroup::

---

    Code
      octo_start_group("testthat")

---

    Code
      octo_end_group()

# group errors [plain]

    Code
      octo_start_group(c("error", "too much"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::Group `name` must be length 1!
    Condition
      Error in `octo_start_group()`:
      ! Group `name` must be length 1!

---

    Group `name` must be length 1!

# group errors [ansi]

    Code
      octo_start_group(c("error", "too much"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::Group `name` must be length 1!
    Condition
      [1m[33mError[39m in `octo_start_group()`:[22m
      [1m[22m[33m![39m Group `name` must be length 1!

---

    [1m[22mGroup `name` must be length 1!

# group errors [unicode]

    Code
      octo_start_group(c("error", "too much"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::Group `name` must be length 1!
    Condition
      Error in `octo_start_group()`:
      ! Group `name` must be length 1!

---

    Group `name` must be length 1!

# group errors [fancy]

    Code
      octo_start_group(c("error", "too much"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::Group `name` must be length 1!
    Condition
      [1m[33mError[39m in `octo_start_group()`:[22m
      [1m[22m[33m![39m Group `name` must be length 1!

---

    [1m[22mGroup `name` must be length 1!

# masking [plain]

    Code
      octo_mask_value("token2123123")
    Output
      ::add-mask::token2123123

---

    Code
      octo_mask_envvar("SECRET_VAR1")
    Output
      ::add-mask::$SECRET_VAR1

---

    Code
      octo_mask_value("token2123123")

---

    Code
      octo_mask_envvar("SECRET_VAR1")

# masking [ansi]

    Code
      octo_mask_value("token2123123")
    Output
      ::add-mask::token2123123

---

    Code
      octo_mask_envvar("SECRET_VAR1")
    Output
      ::add-mask::$SECRET_VAR1

---

    Code
      octo_mask_value("token2123123")

---

    Code
      octo_mask_envvar("SECRET_VAR1")

# masking [unicode]

    Code
      octo_mask_value("token2123123")
    Output
      ::add-mask::token2123123

---

    Code
      octo_mask_envvar("SECRET_VAR1")
    Output
      ::add-mask::$SECRET_VAR1

---

    Code
      octo_mask_value("token2123123")

---

    Code
      octo_mask_envvar("SECRET_VAR1")

# masking [fancy]

    Code
      octo_mask_value("token2123123")
    Output
      ::add-mask::token2123123

---

    Code
      octo_mask_envvar("SECRET_VAR1")
    Output
      ::add-mask::$SECRET_VAR1

---

    Code
      octo_mask_value("token2123123")

---

    Code
      octo_mask_envvar("SECRET_VAR1")

# masking errors [plain]

    Code
      octo_mask_value(c(1, 2))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one value at a time.
    Condition
      Error in `octo_mask_value()`:
      ! You can only mask one value at a time.

---

    Code
      octo_mask_envvar(c("VAR1", "VAR2"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one envvar at a time.
    Condition
      Error in `octo_mask_envvar()`:
      ! You can only mask one envvar at a time.

---

    Code
      octo_mask_envvar("SECRET_VAR")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The envvar `SECRET_VAR` does not exists!
    Condition
      Error in `octo_mask_envvar()`:
      ! The envvar `SECRET_VAR` does not exists!

---

    You can only mask one value at a time.

---

    You can only mask one envvar at a time.

---

    The envvar `SECRET_VAR` does not exists!

# masking errors [ansi]

    Code
      octo_mask_value(c(1, 2))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one value at a time.
    Condition
      [1m[33mError[39m in `octo_mask_value()`:[22m
      [1m[22m[33m![39m You can only mask one value at a time.

---

    Code
      octo_mask_envvar(c("VAR1", "VAR2"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one envvar at a time.
    Condition
      [1m[33mError[39m in `octo_mask_envvar()`:[22m
      [1m[22m[33m![39m You can only mask one envvar at a time.

---

    Code
      octo_mask_envvar("SECRET_VAR")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The envvar `SECRET_VAR` does not exists!
    Condition
      [1m[33mError[39m in `octo_mask_envvar()`:[22m
      [1m[22m[33m![39m The envvar `SECRET_VAR` does not exists!

---

    [1m[22mYou can only mask one value at a time.

---

    [1m[22mYou can only mask one envvar at a time.

---

    [1m[22mThe envvar `SECRET_VAR` does not exists!

# masking errors [unicode]

    Code
      octo_mask_value(c(1, 2))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one value at a time.
    Condition
      Error in `octo_mask_value()`:
      ! You can only mask one value at a time.

---

    Code
      octo_mask_envvar(c("VAR1", "VAR2"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one envvar at a time.
    Condition
      Error in `octo_mask_envvar()`:
      ! You can only mask one envvar at a time.

---

    Code
      octo_mask_envvar("SECRET_VAR")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The envvar `SECRET_VAR` does not exists!
    Condition
      Error in `octo_mask_envvar()`:
      ! The envvar `SECRET_VAR` does not exists!

---

    You can only mask one value at a time.

---

    You can only mask one envvar at a time.

---

    The envvar `SECRET_VAR` does not exists!

# masking errors [fancy]

    Code
      octo_mask_value(c(1, 2))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one value at a time.
    Condition
      [1m[33mError[39m in `octo_mask_value()`:[22m
      [1m[22m[33m![39m You can only mask one value at a time.

---

    Code
      octo_mask_envvar(c("VAR1", "VAR2"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one envvar at a time.
    Condition
      [1m[33mError[39m in `octo_mask_envvar()`:[22m
      [1m[22m[33m![39m You can only mask one envvar at a time.

---

    Code
      octo_mask_envvar("SECRET_VAR")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The envvar `SECRET_VAR` does not exists!
    Condition
      [1m[33mError[39m in `octo_mask_envvar()`:[22m
      [1m[22m[33m![39m The envvar `SECRET_VAR` does not exists!

---

    [1m[22mYou can only mask one value at a time.

---

    [1m[22mYou can only mask one envvar at a time.

---

    [1m[22mThe envvar `SECRET_VAR` does not exists!

# set_output [plain]

    Code
      octo_set_output(5, c("some", "output"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The output `name` must be length 1.
    Condition
      Error in `octo_set_output()`:
      ! The output `name` must be length 1.

---

    Code
      octo_set_output(c(2, 3), "output")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The output `value` must be length 1.
    Condition
      Error in `octo_set_output()`:
      ! The output `value` must be length 1.

---

    Code
      octo_set_output("Some Important text to pass on", "pkg-info")
    Output
      ::set-output name=pkg-info::Some Important text to pass on

---

    The output `name` must be length 1.

---

    The output `value` must be length 1.

---

    Code
      octo_set_output("Some Important text to pass on", "pkg-info")

# set_output [ansi]

    Code
      octo_set_output(5, c("some", "output"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The output `name` must be length 1.
    Condition
      [1m[33mError[39m in `octo_set_output()`:[22m
      [1m[22m[33m![39m The output `name` must be length 1.

---

    Code
      octo_set_output(c(2, 3), "output")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The output `value` must be length 1.
    Condition
      [1m[33mError[39m in `octo_set_output()`:[22m
      [1m[22m[33m![39m The output `value` must be length 1.

---

    Code
      octo_set_output("Some Important text to pass on", "pkg-info")
    Output
      ::set-output name=pkg-info::Some Important text to pass on

---

    [1m[22mThe output `name` must be length 1.

---

    [1m[22mThe output `value` must be length 1.

---

    Code
      octo_set_output("Some Important text to pass on", "pkg-info")

# set_output [unicode]

    Code
      octo_set_output(5, c("some", "output"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The output `name` must be length 1.
    Condition
      Error in `octo_set_output()`:
      ! The output `name` must be length 1.

---

    Code
      octo_set_output(c(2, 3), "output")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The output `value` must be length 1.
    Condition
      Error in `octo_set_output()`:
      ! The output `value` must be length 1.

---

    Code
      octo_set_output("Some Important text to pass on", "pkg-info")
    Output
      ::set-output name=pkg-info::Some Important text to pass on

---

    The output `name` must be length 1.

---

    The output `value` must be length 1.

---

    Code
      octo_set_output("Some Important text to pass on", "pkg-info")

# set_output [fancy]

    Code
      octo_set_output(5, c("some", "output"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The output `name` must be length 1.
    Condition
      [1m[33mError[39m in `octo_set_output()`:[22m
      [1m[22m[33m![39m The output `name` must be length 1.

---

    Code
      octo_set_output(c(2, 3), "output")
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::The output `value` must be length 1.
    Condition
      [1m[33mError[39m in `octo_set_output()`:[22m
      [1m[22m[33m![39m The output `value` must be length 1.

---

    Code
      octo_set_output("Some Important text to pass on", "pkg-info")
    Output
      ::set-output name=pkg-info::Some Important text to pass on

---

    [1m[22mThe output `name` must be length 1.

---

    [1m[22mThe output `value` must be length 1.

---

    Code
      octo_set_output("Some Important text to pass on", "pkg-info")

# stop_commands [plain]

    Code
      octo_stop_commands()
    Output
      ::stop-commands::token123
      [1] "token123"

---

    Code
      octo_start_commands("token123")
    Output
      ::token123::

---

    Code
      octo_stop_commands()
    Output
      [1] "token123"

---

    Code
      octo_start_commands("token123")

# stop_commands [ansi]

    Code
      octo_stop_commands()
    Output
      ::stop-commands::token123
      [1] "token123"

---

    Code
      octo_start_commands("token123")
    Output
      ::token123::

---

    Code
      octo_stop_commands()
    Output
      [1] "token123"

---

    Code
      octo_start_commands("token123")

# stop_commands [unicode]

    Code
      octo_stop_commands()
    Output
      ::stop-commands::token123
      [1] "token123"

---

    Code
      octo_start_commands("token123")
    Output
      ::token123::

---

    Code
      octo_stop_commands()
    Output
      [1] "token123"

---

    Code
      octo_start_commands("token123")

# stop_commands [fancy]

    Code
      octo_stop_commands()
    Output
      ::stop-commands::token123
      [1] "token123"

---

    Code
      octo_start_commands("token123")
    Output
      ::token123::

---

    Code
      octo_stop_commands()
    Output
      [1] "token123"

---

    Code
      octo_start_commands("token123")

