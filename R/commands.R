#' @export
octo_begin_group <- function(title) {
    stopifnot(length(title) == 1)
    glue("::group::{title}") %>% octocat()
}

#' @export
octo_end_group <- function() {
    octocat("::endgroup::")
}

#' @export
octo_mask_value <- function(value) {

}

#' @export
octo_set_output <- function(name, value){

}

#' @export
octo_stop_commands <- function(token){

}

#' @export
octo_start_commands <- function(token){

}

#' @export
octo_echo_on <- function(){

} 

#' @export
octo_echo_off <- function(){

} 

#' @export
octo_save_state <- function(name, value){

} 

#' @export
octo_set_envvar <- function(name, value){

} 

