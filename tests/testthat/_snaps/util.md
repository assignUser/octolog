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
      enable_github_colors()
    Message <cliMessage>
      v Enabled colors!
    Output
      [1] TRUE

---

    Code
      enable_github_colors()
    Message <cliMessage>
      i `R_CLI_NUM_COLORS` already set.
    Output
      [1] TRUE

# enable_github_colors [ansi]

    Code
      enable_github_colors()
    Message <cliMessage>
      [32mv[39m Enabled colors!
    Output
      [1] TRUE

---

    Code
      enable_github_colors()
    Message <cliMessage>
      [36mi[39m [38;2;32;32;32m[48;2;232;232;232m[30m[47m`R_CLI_NUM_COLORS`[48;2;232;232;232m[38;2;32;32;32m[49m[39m already set.
    Output
      [1] TRUE

# enable_github_colors [unicode]

    Code
      enable_github_colors()
    Message <cliMessage>
      ✔ Enabled colors!
    Output
      [1] TRUE

---

    Code
      enable_github_colors()
    Message <cliMessage>
      ℹ `R_CLI_NUM_COLORS` already set.
    Output
      [1] TRUE

# enable_github_colors [fancy]

    Code
      enable_github_colors()
    Message <cliMessage>
      [32m✔[39m Enabled colors!
    Output
      [1] TRUE

---

    Code
      enable_github_colors()
    Message <cliMessage>
      [36mℹ[39m [38;2;32;32;32m[48;2;232;232;232m[30m[47m`R_CLI_NUM_COLORS`[48;2;232;232;232m[38;2;32;32;32m[49m[39m already set.
    Output
      [1] TRUE

