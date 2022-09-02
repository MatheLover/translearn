pacman::p_load(
  devtools,
  usethis,
  roxygen2,
  testthat,
  knitr,
  rmarkdown
)
load_all()
# Save_Img(cwd="/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",300,60,60)

model_365 <- Load_Place365()
Extract_Feature_v2(model_365,"VGG16_places_fc1","/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",c(224,224))
