
Sys.setenv("R_TESTS" = "")
library(mrgsolve)
library(testthat)
test_check("knobs", reporter="summary")


