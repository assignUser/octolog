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
    Error <rlang_error>
      Group `name` must be length 1!

---

    Group `name` must be length 1!

# group errors [ansi]

    Code
      octo_start_group(c("error", "too much"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::Group `name` must be length 1!
    Error <rlang_error>
      [1m[22mGroup [30m[47m`name`[49m[39m must be length 1!

---

    [1m[22mGroup [30m[47m`name`[49m[39m must be length 1!

# group errors [unicode]

    Code
      octo_start_group(c("error", "too much"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::Group `name` must be length 1!
    Error <rlang_error>
      Group `name` must be length 1!

---

    Group `name` must be length 1!

# group errors [fancy]

    Code
      octo_start_group(c("error", "too much"))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::Group `name` must be length 1!
    Error <rlang_error>
      [1m[22mGroup [30m[47m`name`[49m[39m must be length 1!

---

    [1m[22mGroup [30m[47m`name`[49m[39m must be length 1!

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
    Error <rlang_error>
      You can only mask one value at a time.

---

    You can only mask one envvar at a time.

---

    object 'name' not found

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
    Error <rlang_error>
      [1m[22mYou can only mask one value at a time.

---

    [1m[22mYou can only mask one envvar at a time.

---

    object 'name' not found

---

    [1m[22mYou can only mask one value at a time.

---

    [1m[22mYou can only mask one envvar at a time.

---

    [1m[22mThe envvar [30m[47m`SECRET_VAR`[49m[39m does not exists!

# masking errors [unicode]

    Code
      octo_mask_value(c(1, 2))
    Output
      ::error file=universe.R,line=23,endLine=42,col=3,endCol=27::You can only mask one value at a time.
    Error <rlang_error>
      You can only mask one value at a time.

---

    You can only mask one envvar at a time.

---

    object 'name' not found

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
    Error <rlang_error>
      [1m[22mYou can only mask one value at a time.

---

    [1m[22mYou can only mask one envvar at a time.

---

    object 'name' not found

---

    [1m[22mYou can only mask one value at a time.

---

    [1m[22mYou can only mask one envvar at a time.

---

    [1m[22mThe envvar [30m[47m`SECRET_VAR`[49m[39m does not exists!

