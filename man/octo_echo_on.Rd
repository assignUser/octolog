% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/commands.R
\name{octo_echo_on}
\alias{octo_echo_on}
\alias{octo_echo_off}
\title{Echo workflow commands}
\usage{
octo_echo_on()

octo_echo_off()
}
\description{
Enable or disable echoing of workflow commands in the log. This can be useful
for debugging. Some commands are always echoed and will not be effected by
these functions, this includes \code{\link[=octo_debug]{octo_debug()}} (if debugging is turned on),
\code{\link[=octo_warn]{octo_warn()}} and \code{\link[=octo_abort]{octo_abort()}}.
}
\examples{
Sys.setenv(GITHUB_ACTIONS = "true")
octo_echo_on()
# workflow commands will be printed in their unparsed state in addition to
# their normal effects
octo_echo_off()
}
\seealso{
\href{https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#echoing-command-outputs}{GitHub Docs}
}
