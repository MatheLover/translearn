#' Combine Image features
#'
#' @param cwd Filepath of project directory
#' @param fpath_txt Filepath of .txt containing image information
#'
#' @return Save combined features. None is returned
#' @export
#'
#' @examples
Combine_Feature <- function(cwd,fpath_txt){
  joblib <- reticulate::import("joblib",delay_load = TRUE)
  numpy <- reticulate::import("numpy",delay_load = TRUE)

  # create model list
  cvmodels <- list("VGG16_fc1","VGG16_places_fc1","VGGFace_fc6")

  # iterate each model
  for (model in cvmodels){
    # initialize feature list for each model
    feature_array <- list()

    # read .txt file cataloguing all img files
    imgfile_catalog <- read_delim(fpath_txt, delim='\t', col_names=TRUE)


    imgfile_catalog <- imgfile_catalog[1:100,]

    for (i in 1:nrow(imgfile_catalog)){
      # construct feature file path
      feature_path <- paste(cwd,"/feature_extraction/",model,"/",imgfile_catalog[i, "user"],
                            "/",imgfile_catalog[i, "imgname"],".dat",sep="")


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
