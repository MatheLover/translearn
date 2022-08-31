
#' Performs K-Means clustering and save assigned label for each image as csv.
#'
#' @param cwd File path of project directory
#' @param num_cluster Number of clusters
#' @param fpath_txt File path of .txt containing image information
#'
#' @return Save assigned label for each image as csv.
#' @export
#'
#' @examples
K_Means_Clustering <- function(cwd, num_cluster, fpath_txt){
  # create model list
  cvmodels <- list("VGG16_fc1","VGG16_places_fc1","VGGFace_fc6")

  for (model in cvmodels){
    # construct feature path (after pca)
    fpca_path <- paste(cwd, "/feature_extraction/feature_PCA/",model,".dat",sep="")

    # read in saved feature
    feature <- joblib$load(fpca_path)

    # create df
    feature_df <- as.data.frame(feature)

    # limit number of columns (at most 200) -- TODO
    if(ncol(feature_df) > 200){
      feature_df <- feature_df[,c(1:200)]
    }
    else{
      feature_df <- feature_df[,c(1:ncol(feature_df))]
    }

    # perform k-means clustering
    k_result <- kmeans(feature_df, centers=num_cluster, nstart=25)

    # extract label from k_result
    label_result <- as.data.frame(k_result["cluster"])

    # read all image file txt
    img_catalogue <- read_delim(fpath_txt, delim= "\t", col_names = TRUE)

    # add a new column label to img_catalogue
    for(i in 1:nrow(label_result)){
      img_catalogue[i, "label"] <- label_result[i, "cluster"]
    }

    # construct folder path
    folder_fp <- paste(cwd, "/cluster/",num_cluster,"_Means/",model, sep="")
    if(!dir.exists(folder_fp)){
      dir.create(folder_fp, recursive=TRUE)
    }

    # construct filepath for label.txt
    label_fp <- paste(folder_fp,"/label.txt",sep="")

    # write to txt file
    write.csv(img_catalogue, label_fp,row.names = FALSE)


  }
}

