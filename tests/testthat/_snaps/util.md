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
    Message
      v Enabled colors!

---

    Code
      enable_github_colors(.local_envir = env)
    Message
      i `R_CLI_NUM_COLORS` already set.

---

    Code
      disable_github_colors()
    Message
      x Disabeled colors!

# enable_github_colors [ansi]

    Code
      enable_github_colors(.local_envir = env)
    Message
      [32mv[39m Enabled colors!

---

    Code
      enable_github_colors(.local_envir = env)
    Message
      [36mi[39m `R_CLI_NUM_COLORS` already set.

---

    Code
      disable_github_colors()
    Message
      x Disabeled colors!

# get_location_string

    Code
      get_location_string(trc)
    Output
      file=test-util.R,line=61,endLine=61,col=3,endCol=19

