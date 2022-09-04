pacman::p_load(
  devtools,
  usethis,
  roxygen2,
  testthat,
  knitr,
  rmarkdown
)
load_all()
devtools::document()


Install_Py_Packages()

Generate_txt("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material")
model_16 <- Load_VGG16()
Extract_Feature_v2(model_16,"VGG16_fc1","/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",c(224,224))

model_365 <- Load_Place365()
Extract_Feature_v2(model_365,"VGG16_places_fc1","/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",c(224,224))

model_face <- Load_VGGFace()
Extract_Feature_v2(model_face,"VGGFace_fc6","/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",c(224,224))

Combine_Feature_v2("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material")

PCA("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material")

K_Means_Clustering_v2("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",6)

Duplicate_Image_Kmeans("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material")

Save_Img("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",300,60,60)


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



