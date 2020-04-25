
##' S4 class for mrgsolve simulation output
##'
##' @slot request character vector of compartments requested in simulated
##' output
##' @slot outnames character vector of column names in simulated output
##' coming from table step
##' @slot data data.frame of simulated data
##' @slot mod the mrgmod model object
##' @keywords internal
setClass("mrgsims",
         slots=c(
           request="character",
           outnames="character",
           data="data.frame",
           mod="mrgmod"
         )
)

setClass("batch_mrgsims",contains="mrgsims",
         slots=c(
           knobs="character",
           batch="data.frame",
           request="character",
           moving="character",
           input="list"
         )
)


