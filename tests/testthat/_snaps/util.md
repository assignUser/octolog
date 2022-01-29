# octocat

    Code
      octocat(test_string)
    Output
      This is a message for Github!

---

    Code
      octocat(test_string)

# encode_string

    Code
      encode_string(chrs)
    Output
      [1] "100%25 This is some output with %0A" "a new line"                         

---

    Code
      encode_string(md, TRUE)
    Output
      [1] "# Important PR Comment%0A %0AThis commit is great!"

# enable_github_colors [plain]

    Code
      enable_github_colors(.local_envir = env)
    Message <cliMessage>
      v Enabled colors!

---

    Code
      enable_github_colors(.local_envir = env)
    Message <cliMessage>
      i `R_CLI_NUM_COLORS` already set.

# enable_github_colors [ansi]

    Code
      enable_github_colors(.local_envir = env)
    Message <cliMessage>
      [32mv[39m Enabled colors!

---

    Code
      enable_github_colors(.local_envir = env)
    Message <cliMessage>
      [36mi[39m [30m[47m[30m[47m`R_CLI_NUM_COLORS`[47m[30m[49m[39m already set.

# enable_github_colors [unicode]

    Code
      enable_github_colors(.local_envir = env)
    Message <cliMessage>
      ✔ Enabled colors!

---

    Code
      enable_github_colors(.local_envir = env)
    Message <cliMessage>
      ℹ `R_CLI_NUM_COLORS` already set.

# enable_github_colors [fancy]

    Code
      enable_github_colors(.local_envir = env)
    Message <cliMessage>
      [32m✔[39m Enabled colors!

---

    Code
      enable_github_colors(.local_envir = env)
    Message <cliMessage>
      [36mℹ[39m [30m[47m[30m[47m`R_CLI_NUM_COLORS`[47m[30m[49m[39m already set.

