pacman::p_load(
  devtools,
  usethis,
  roxygen2,
  testthat,
  knitr,
  rmarkdown
)
load_all()
# usethis::use_package("cluster")
# usethis::use_package("keras")
# usethis::use_package("magick")
# usethis::use_package("reticulate")
# usethis::use_package("readr")
# usethis::use_package("magrittr")
# usethis::use_import_from("magrittr","%>%")
devtools::document()


# load remotes package and install translearn
library(remotes)
remotes::install_github("MatheLover/translearn")

library(translearn)

# check whether python pacakges installed
Install_Py_Packages_v2()

# generate img txt file
Generate_txt("/Users/benchiang/Documents/ComputationalSocialScience/Test")
Subset_txt("/Users/benchiang/Documents/ComputationalSocialScience/Test",10)

model_16 <- Load_VGG16()
Extract_Feature_v2(model_16,"VGG16_fc1","/Users/benchiang/Documents/ComputationalSocialScience/Test",c(224,224),TRUE)

model_365 <- Load_Place365()
Extract_Feature_v2(model_365,"VGG16_places_fc1","/Users/benchiang/Documents/ComputationalSocialScience/Test",c(224,224))

model_face <- Load_VGGFace()
Extract_Feature_v2(model_face,"VGGFace_fc6","/Users/benchiang/Documents/ComputationalSocialScience/Test",c(224,224))

Combine_Feature_v2("/Users/benchiang/Documents/ComputationalSocialScience/Test")

PCA("/Users/benchiang/Documents/ComputationalSocialScience/Test")

K_Means_Clustering_v2("/Users/benchiang/Documents/ComputationalSocialScience/Test",6)

Duplicate_Image_Kmeans("/Users/benchiang/Documents/ComputationalSocialScience/Test")

Save_Img("/Users/benchiang/Documents/ComputationalSocialScience/Test",300,60,60)

Subset_txt("/Users/benchiang/Documents/ComputationalSocialScience/Test",100)


# load VGG16
# model16 <- Load_VGG16()
# Extract_Feature(model16, "VGG16_fc1", "/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material","/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material/img filename study2A.txt",delim='\t', header=TRUE)
#
# # load Place365
# model_365 <- Load_Place365()
# Extract_Feature(model_365, "VGG16_places_fc1", "/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material","/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material/img filename study2A.txt",delim='\t', header=TRUE)
#
# # load VGGFace
# model_face <- Load_VGGFace()
# Extract_Feature(model_face, "VGGFace_fc6", "/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material","/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material/img filename study2A.txt",delim='\t', header=TRUE)
#
# # combine feature
# Combine_Feature("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",
#                 "/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material/img filename study2A.txt")
#
# # pca
# PCA("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material")

