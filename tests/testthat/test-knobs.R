
library(testthat)
library(mrgsolve)
library(dplyr)
Sys.setenv(R_TESTS="")
options("mrgsolve_mread_quiet"=TRUE)

context("test-knobs")

mod <- mrgsolve::house(atol=1E-20,rtol=1E-12,digits=8)

out <- knobs::knobs(mod %>% init(GUT=0), CL=c(1,2,3), foo=c(2,3,4),fooo=1, amt=c(100,200), cmt=1)
dfout <- as.data.frame(out)

test_that("knobs() returns object of class knobs", {
  expect_is(out, "knobs")
})

test_that("plotting knobs objects", {
  p <- plot(out)
  expect_is(p,"trellis")
  p <- plot(out, CP~time|CL*amt)
  expect_is(p,"trellis")
})

test_that("Moving knobs are correctly identified", {
  expect_identical(knobs:::moving(out), c("CL", "amt"))
})

test_that("CL knob is correctly captured in output as CL", {
  expect_true(is.element("CL", names(out)))
  expect_identical(unique(dfout$CL),c(1,2,3))
})

test_that("A false knob does not appear in simulated output", {
  expect_false(is.element("foo", names(out)))
})
