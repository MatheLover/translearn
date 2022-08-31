pacman::p_load(
  devtools,
  usethis,
  roxygen2,
  testthat,
  knitr,
  rmarkdown
)
load_all()
keras_models <- reticulate::import("keras.models")
