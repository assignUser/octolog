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
      [1] "# Important PR Comment" " "                      "This commit is great!" 

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
    Output
      [1] FALSE

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
    Output
      [1] FALSE

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
    Output
      [1] FALSE

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
    Output
      [1] FALSE

