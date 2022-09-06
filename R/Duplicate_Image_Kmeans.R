#' Duplicate images for all images clustered by K-means methods.
#' Within this function, we call Call Duplicate_Image() to save images with specific label.
#'
#' @param cwd File path of project directory
#'
#' @export
#'
#' @examples Duplicate_Image_Kmeans("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material")
Duplicate_Image_Kmeans <- function(cwd){
  # model list
  cvmodels <- list("VGG16_fc1","VGG16_places_fc1","VGGFace_fc6")

  # iterate model
  for(model in cvmodels){
    # construct img_cluster path
    cluster_path <- file.path(cwd, "cluster")

    # list out all dir relating to different ks being applied
    dir_vec <- dir(path=cluster_path,full.names=FALSE,recursive=FALSE)

    # iterate dir
    for(i in 1:length(dir_vec)){
      # construct file path for label.txt -- namely cwd/img_cluster/K_Means/model/label.txt
      ftxt_path <- file.path(cluster_path,dir_vec[i],model,"label.txt")

      # label.txt not exists, skip
      if(!file.exists(ftxt_path)){
        next
      }

      # read label.txt
      label_df <- readr::read_csv(ftxt_path)

      # extract k value
      k_val <- substring(dir_vec[i],1,1)

      # iterate each label defined in k-means
      for (j in 1:k_val){
        # select img corresponding to each label
        label <- label_df[label_df['label'] == j & !is.na(label_df['label']), ]

        # select at most 20 images
        if(nrow(label) > 20){
          label_20 <- label[1:20,]
        }else{
          label_20 <- label[1:nrow(label),]
        }
        # call Duplicate_Image() for each k to copy images
        Duplicate_Image(label_20, model, dir_vec[i], cwd)
      }


    }







  }


}


#' Duplicate images with specific label
#'
#' @param label_20 Dataframe containing images with specific label
#' @param model Model name
#' @param dir Directory name(e.g. 6_Means)
#' @param cwd Filepath of project directory
#'
#' @export
#'
Duplicate_Image <- function(label_20, model, dir, cwd){
  # construct read_img path
  label_20["read_img_path"] <- label_20$X1
  # file.path(cwd,"img",label_20$user,label_20$imgname)

  # construct save_img folder and path
  label_20["save_img_folder"] <- file.path(cwd, "cluster",dir,model,label_20$label)
  label_20["save_img_path"] <- file.path(cwd, "cluster",dir,model,label_20$label,basename(label_20$X1))

  # read ans save image
  for (l in 1:nrow(label_20)){
    # convert list to char
    read_fpath <- as.character(label_20[l, "read_img_path"])

    # read img
    img <- magick::image_read(read_fpath)

    # convert list to char
    save_folder <- as.character(label_20[l, "save_img_folder"])
    if(!dir.exists(save_folder)){
      dir.create(save_folder)
    }
    save_fpath <- as.character(label_20[l, "save_img_path"])

    # save img
    magick::image_write(img,save_fpath, format = "jpg")
  }
}






