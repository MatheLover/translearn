#'
#'
#' @param cwd Filepath of project directory
#'
#' @return Save combined features. None is returned
#' @export
#'
#' @examples
Combine_Feature_v2 <- function(cwd){
  joblib <- reticulate::import("joblib")
  numpy <- reticulate::import("numpy")

  # create model list
  cvmodels <- list("VGG16_fc1","VGG16_places_fc1","VGGFace_fc6")

  # iterate each model
  for (model in cvmodels){
    # model path
    model_path <- file.path(cwd, "feature_extraction",model)

    # check whether model folder exists. If no, skip
    if(!dir.exists(model_path)){
      next
    }

    # initialize feature list for each model
    feature_array <- list()

    # construct file path for .txt file
    fpath_txt <- file.path(cwd, "img_txt/img.txt")

    # read .txt file
    imgfile_catalog <- read_delim(fpath_txt, delim='\t', col_names=FALSE)

    # change col name to "img_filepath"
    colnames(imgfile_catalog) <- c("img_filepath")

    imgfile_catalog <- imgfile_catalog[1:100,]

    for (i in 1:nrow(imgfile_catalog)){
      # convert to char
      fpath_char <- as.character(imgfile_catalog[1,"img_filepath"])

      # construct feature filename and folder and path
      feature_fname <- paste(basename(fpath_char),".dat",sep="")
      feature_folder <- basename(dirname(fpath_char))
      feature_path <- file.path(cwd, "feature_extraction",model, feature_folder,feature_fname)
      if(!file.exists(feature_path)){
        next
      }

      # read feature
      img_features = joblib$load(feature_path)


      # convert multidimensional feature array into 1D array
      img_feature <- numpy$array(img_features)
      flatten_features <- numpy$ndarray$flatten(img_feature)

      # append to the feature array for each model
      feature_array <- append(feature_array,list(flatten_features))
    }


    # convert r list to python list
    py_feature_array <- r_to_py(feature_array)


    # initialize feature array as numpy array in python
    py_feature_array <- numpy$array(py_feature_array)


    # save combined feature folder path for each model
    cfpath <- paste(cwd,"/feature_extraction/","combined_feature/",sep="")

    # create path if not existed
    if(!dir.exists(cfpath)){
      dir.create(cfpath, recursive = TRUE)
    }

    # construct combine feature filepath
    cfname <- paste(cwd,"/feature_extraction/","combined_feature/",model,".dat",sep="")

    # save combined feature
    joblib$dump(py_feature_array,cfname)
    # write.table(py_feature_array, cfname, row.names = FALSE, sep='\t')

  }
}







