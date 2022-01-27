# groups [plain]

    Code
      octo_start_group("testthat")
    Output
      ::group::testthat

---

    Group `name` must be length 1!

---

    Code
      octo_end_group()
    Output
      ::endgroup::

---

    Code
      octo_start_group("testthat")

---

    Group `name` must be length 1!

---

    Code
      octo_end_group()

# groups [ansi]

    Code
      octo_start_group("testthat")
    Output
      ::group::testthat

---

    [1m[22mGroup [30m[47m`name`[49m[39m must be length 1!

---

    Code
      octo_end_group()
    Output
      ::endgroup::

---

    Code
      octo_start_group("testthat")

---

    [1m[22mGroup [30m[47m`name`[49m[39m must be length 1!

---

    Code
      octo_end_group()

# groups [unicode]

    Code
      octo_start_group("testthat")
    Output
      ::group::testthat

---

    Group `name` must be length 1!

---

    Code
      octo_end_group()
    Output
      ::endgroup::

---

    Code
      octo_start_group("testthat")

---

    Group `name` must be length 1!

---

    Code
      octo_end_group()

# groups [fancy]

    Code
      octo_start_group("testthat")
    Output
      ::group::testthat

---

    [1m[22mGroup [30m[47m`name`[49m[39m must be length 1!

---

    Code
      octo_end_group()
    Output
      ::endgroup::

---

    Code
      octo_start_group("testthat")

---

    [1m[22mGroup [30m[47m`name`[49m[39m must be length 1!

---

    Code
      octo_end_group()

# masking [plain]

    You can only mask one value at a time.

---

    could not find function "octo_mask_envar"

---

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

    object 'name' not found

---

    You can only mask one value at a time.

---

    could not find function "octo_mask_envar"

---

    Code
      octo_mask_value("token2123123")

---

    Code
      octo_mask_envvar("SECRET_VAR1")

---

    The envvar `SECRET_VAR` does not exists!

# masking [ansi]

    [1m[22mYou can only mask one value at a time.

---

    could not find function "octo_mask_envar"

---

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

    object 'name' not found

---

    [1m[22mYou can only mask one value at a time.

---

    could not find function "octo_mask_envar"

---

    Code
      octo_mask_value("token2123123")

---

    Code
      octo_mask_envvar("SECRET_VAR1")

---

    [1m[22mThe envvar [30m[47m`SECRET_VAR`[49m[39m does not exists!

# masking [unicode]

    You can only mask one value at a time.

---

    could not find function "octo_mask_envar"

---

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

    object 'name' not found

---

    You can only mask one value at a time.

---

    could not find function "octo_mask_envar"

---

    Code
      octo_mask_value("token2123123")

---

    Code
      octo_mask_envvar("SECRET_VAR1")

---

    The envvar `SECRET_VAR` does not exists!

# masking [fancy]

    [1m[22mYou can only mask one value at a time.

---

    could not find function "octo_mask_envar"

---

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

    object 'name' not found

---

    [1m[22mYou can only mask one value at a time.

---

    could not find function "octo_mask_envar"

---

    Code
      octo_mask_value("token2123123")

---

    Code
      octo_mask_envvar("SECRET_VAR1")

---

    [1m[22mThe envvar [30m[47m`SECRET_VAR`[49m[39m does not exists!
