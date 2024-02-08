#' Peform PCA
#'
#' @param cwd Filepath of the project directory
#'
#' @export
#'
#' @examples PCA("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material")
PCA <- function(cwd){
  pd <- reticulate::import("pandas",delay_load = TRUE)
  sklearn_preprocessing <- reticulate::import("sklearn.preprocessing",delay_load = TRUE)
  sklearn_decomp <- reticulate::import("sklearn.decomposition",delay_load = TRUE)
  joblib <- reticulate::import("joblib",delay_load = TRUE)

  # currently used models
  cvmodels <- list("VGG16_fc1","VGG16_places_fc1","VGGFace_fc6")

  for (model in cvmodels){
    # retrieve the filepath for .txt file for each model
    dat_fp <- paste(cwd,"/feature_extraction/","combined_feature/",model,".txt",sep="")

    # check whether .txt file exists; If no, skip
    if(!file.exists(dat_fp)){
      next
    }

    # load feature array and create df
    features_array <- joblib$load(dat_fp)
    x <- pd$DataFrame(features_array)


    # standardizing the features
    x <- sklearn_preprocessing$StandardScaler()$fit_transform(x)

    # 95% of the variance is retained.
    pca <- sklearn_decomp$PCA(0.95)
    # pca.fit(x)
    x_pca <- pca$fit_transform(x)

    # save PCA
    folder_path <- paste(cwd,"/feature_extraction/","feature_PCA/", sep="")
    if(!dir.exists(folder_path)){
      dir.create(folder_path, recursive = TRUE)
    }
    pca_savepath <- paste(folder_path,model,".txt",sep="")
    joblib$dump(x_pca, pca_savepath)

    # save components
    components <- pca$components_
    comp_savepath <- paste(folder_path,model,sep="")
    if(!dir.exists(comp_savepath)){
      dir.create(comp_savepath, recursive=TRUE)
    }
    cts <- pd$DataFrame(components)
    write.table(cts, paste(comp_savepath,"/components.txt",sep=""), sep="\t",row.names = FALSE,col.names = FALSE)

    # save variance explained ratio
    variance <- pca$explained_variance_ratio_
    var_savepath <- paste(folder_path,model,sep="")
    if(!dir.exists(var_savepath)){
      dir.create(var_savepath, recursive = TRUE)
    }
    variance <- pd$DataFrame(variance)
    write.table(variance, paste(var_savepath,"/variance.txt",sep=""), sep="\t", row.names = FALSE, col.names = FALSE)
  }


}
