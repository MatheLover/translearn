#' Extract image features and save them as .dat files
#'
#' @param model character Loaded learning model
#' @param base_model_name Name of base model
#' @param cwd Filepath of project directory
#' @param img_dimension Column vector specifying width and height of resized images, e.g. c(224,224)
#'
#' @export
#'
#' @examples Extract_Feature_v2(model16, "VGG16_fc1", "/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material", c(224,224))
Extract_Feature_v2 <- function(model, base_model_name, cwd, img_dimension){
  # import
  joblib <- reticulate::import("joblib",delay_load = TRUE)

  # construct img.txt filepath
  fpath_txt <- file.path(cwd,"img_txt/img.txt")

  # read .txt file cataloguing all img files
  imgfile_catalog <- readr::read_delim(fpath_txt, delim='\t', col_names=FALSE)
  colnames(imgfile_catalog) <- c("img_filepath")

  # iterate each img from imgfile_catalog
  # nrow(imgfile_catalog)
  # print number of all images
  print(paste("The number of all images is ",nrow(imgfile_catalog),sep=""))

  for(i in 1:nrow(imgfile_catalog)){
    # keep track of image being extracted
    print(paste("Extracting image No. ",i,sep=""))

    # retrieve original filepath for each img
    img_path <- imgfile_catalog[i,"img_filepath"]

    # convert to char
    fpath_char <- as.character(img_path)

    # load image
    img <- keras::image_load(fpath_char, target_size = img_dimension)

    # convert img to array
    img_array <- keras::image_to_array(img)

    # create a batch of images, you need an additional dimension: (samples, size1,size2,channels)
    img_expand <- keras::array_reshape(img_array, c(1,dim(img_array)))

    # adjust image to the format the model requires
    x_train = keras::imagenet_preprocess_input(img_expand)

    # extract features
    feature <- model %>% predict(x_train)

    # construct folder and filepath for saving features
    folder_path <- file.path(cwd, "feature_extraction",base_model_name,basename(dirname(fpath_char)))
    fsave_path <- paste(folder_path,"/",basename(fpath_char),".dat",sep="")


    # create new dir on the computer
    if(!dir.exists(folder_path)){
      dir.create(folder_path, recursive = TRUE)
    }


    # save feature(array) into .dat file
    # write.table(feature,fsave_path, row.names = FALSE, sep='\t')
    joblib$dump(feature[1,], fsave_path)


  }

}








