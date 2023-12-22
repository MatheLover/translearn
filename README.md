# translearn

## Description

A R package using transfer learning to cluster images. This is, up to our knowledge, the first R package dedicated to image clustering. We hope this package can provide assistance to researchers in social science as well as other fields.

## Table of Contents
- [Installation](#installation)
- [Citation](#citation)

## Installation
1. Arrange files according to this structure 
![Alt text](Dir_Structure.png "Directory Structure")
2. In RStudio,create a new R project(Enter into a new project, then create. a Git project)
3. If remotes and reticulate packages are not installed, please install them. Otherwise, move to next step. 
4. Load remotes with `library(remotes)` and Use `remotes::install_github(MatheLover/translearn)` for installation 
5. Use git commands to add two submodules required in the project (Make sure the current directory is the project)
   - `git submodule add https://github.com/MatheLover/Places365.git place_translearn_2`
   - `git submodule add https://github.com/MatheLover/VGGFace_tf2_keras_2.git VGG_Face_translearn_2`
6. Load translearn and reticulate package using `library(translearn)` and `library(reticulate)`
7. Specify your python path through `reticulate::use_python('/Users/benchiang88888888/.pyenv/versions/3.9.7/bin/python')`. Please change the path to your own version by typing `which python` on your terminal. Otherwise, just use `reticulate::install_python(version = "3.11.0")` to let reticulate install python for you. 
8. Create a working directory and virtual environment and use it, e.g. `workingdir = /Users/han/Codes/transfer_image_test/`, then `reticulate::virtualenv_create(workingdir)`, and `reticulate::use_virtualenv(workingdir)`. Reminder: please don't use string folder names for the `reticulate::virtualenv_create('/Users/han/Codes/transfer_image_test/')`.
9. Install necessary python packages using `Install_Py_Packages_v2(envname=workingdir)`
11.Generates .txt file containing image file paths from their folder(s) by `Generate_txt('/Users/han/Codes/transfer_image_test/')`. Reminder: the img/ has to be inside the directory folder, and the folder name has to be "img").
12. Load three models `model16 <- Load_VGG16()`, `modelface <- Load_VGGFace()`, and `model365 <- Load_Place365()`
13. Select a sample of images for the project by `Subset_txt('/Users/han/Codes/transfer_image_test/',10)` where 10 indicates the sample size. 
14. Extract image features using different models. `Extract_Feature_v2(model16,"VGG16_fc1","/Users/han/Codes/transfer_image_test/",c(224,224),sampled=TRUE)`,
`Extract_Feature_v2(model365,"VGG16_places_fc1","/Users/han/Codes/transfer_image_test",c(224,224),sampled=TRUE)`,
`Extract_Feature_v2(modelface,"VGGFace_fc6","/Users/han/Codes/transfer_image_test",c(224,224),sampled=TRUE)`,
15. Combine Image features. `Combine_Feature_v2("/Users/han/Codes/transfer_image_test")`.
16. Perform PCA to reduce dimensions. `PCA("/Users/han/Codes/transfer_image_test")`
17. Use K-Means clustering to categorize images `K_Means_Clustering_v2("/Users/han/Codes/transfer_image_test", K=6)`
18. Duplicate images. `Duplicate_Image_Kmeans("/Users/han/Codes/transfer_image_test")`
19. Save images into grid. `Save_Img("/Users/han/Codes/transfer_image_test",300,60,60)`.




Note: 5 and 6 are already included in Test.R.

## References
[Related GitHub Repository](https://github.com/yilangpeng/image-clustering)

[Related Paper](https://hanzhang.xyz/files/Image%20Clustering%20An%20Unsupervised%20Approach%20to%20Categorize%20Visual%20Data%20in%20Social%20Science%20Research.pdf)

## Citation
If you find this repository helpful, please consider citing:

  @article{zhang_image_2022,
 abstract = {Automated image analysis has received increasing attention in social scientific research, yet existing scholarship has focused on the application of supervised machine learning to classify images into predefined categories. This study focuses on the task of unsupervised image clustering, which automatically finds categories from image data. First, we review the steps to perform image clustering, and then we focus on the key challenge of performing unsupervised image clustering---finding low-dimensional representations of images. We present several methods of extracting low-dimensional representations of images, including the traditional bag-of-visual-words model, self-supervised learning, and transfer learning. We compare these methods using two datasets containing images related to protests in China (from Sina Weibo, Chinese Twitter) and to climate change(from Instagram). Results show that transfer learning significantly outperforms other methods. The dataset used in the pretrained model critically determines what categories algorithms can discover.},
 author = {Zhang, Han and Peng, Yilang},
 doi = {10.1177/00491241221082603},
 journal = {Sociological Methods and Research},
 title = {Image Clustering: An Unsupervised Approach to Categorize Visual Data in Social Science Research},
 url = {https://osf.io/preprints/socarxiv/mw57x/},
 year = {2022}
}









 
