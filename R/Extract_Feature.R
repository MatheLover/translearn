joblib <- reticulate::import("joblib", delay_load = TRUE)


#' Extract image features
#'
#' @param model character Loaded learning model
#' @param base_model_name Name of base model
#' @param cwd Filepath of project directory
#' @param fpath_txt Filepath of .txt containing image information
#' @param delim Delimiter of .txt file
#' @param header Whether .txt file has header
#'
#' @return extracted features are saved in .dat files. None is returned
#'
#'
#' @examples Extract_Feature(model16, "VGG16_fc1", "/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material","/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material/img filename study2A.txt",delim='\t', header=TRUE)
Extract_Feature <- function(model, base_model_name, cwd, fpath_txt,delim, header){
  # read .txt file cataloguing all img files
  imgfile_catalog <- read_delim(fpath_txt, delim=delim, col_names=header)

  # iterate each img from imgfile_catalog
  # nrow(imgfile_catalog)
  for(i in 1:100){
    # retrieve original filepath for each img
    img_path <- file.path(cwd,"img",imgfile_catalog[i, "user"],imgfile_catalog[i,"imgname"])

    # load image
    img <- image_load(img_path, target_size = c(224,224))

    # convert img to array
    img_array <- image_to_array(img)

    # create a batch of images, you need an additional dimension: (samples, size1,size2,channels)
    img_expand <- array_reshape(img_array, c(1,dim(img_array)))

    # adjust image to the format the model requires
    x_train = imagenet_preprocess_input(img_expand)

    # extract features
    feature <- model %>% predict(x_train)

    # construct folder and filepath for saving features
    folder_path <- paste(cwd, "/feature_extraction/", base_model_name, "/",imgfile_catalog[i, "user"],sep="")
    fsave_path <- paste(folder_path,"/",imgfile_catalog[i, "imgname"],".dat",sep="")

    # create new dir on the computer
    if(!dir.exists(folder_path)){
      dir.create(folder_path, recursive = TRUE)
    }


    # save feature(array) into .dat file
    # write.table(feature,fsave_path, row.names = FALSE, sep='\t')
    joblib$dump(feature[1,], fsave_path)


  }




}





