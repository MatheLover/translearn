
#' Save images with same label. Called within Save_Img
#'
#' @param cwd Filepath of project directory
#' @param jpg_list_df Information(filepath and label) for images
#' @param k_val K in k-means
#' @param model Model name
#' @param w_sq Width/height of image (300)
#' @param w_clusterid Width of text for cluster id (60)
#' @param h_imgid Height of gap (60)
#'
#'
#'
Save_Image <- function(cwd, jpg_list_df, k_val, model, w_sq,w_clusterid,h_imgid){
  pil <- reticulate::import("PIL",delay_load = TRUE)

  # loads a font object from the given file, and creates a font object with font size 60
  # if mac
  if(Sys.info()['sysname'] == "Darwin" | Sys.info()['sysname'] == "Linux"){
    fntcluster <- pil$ImageFont$truetype('/Library/Fonts/Arial.ttf', as.integer(60))
  }
  else if(Sys.info()['sysname'] == "Windows"){
    fntcluster <- pil$ImageFont$truetype('C:\\WINDOWS\\Fonts\\Arial.ttf', as.integer(60))
  }


  # number of images to show in each row
  ncol <- 20
  nrow <- 1

  # total number of image in each cluster to show
  nimg <- ncol * nrow

  # total width of the entire image
  large_w <- w_sq*ncol + w_clusterid

  # total height of the entire image
  large_h <- (w_sq + h_imgid) * nrow * k_val

  # create a python tuple specifying img size
  c <- reticulate::tuple(as.integer(large_w), as.integer(large_h))

  # create the final image in white
  large <-  pil$Image$new('RGB',c,'white')


  # k_val
  for(i in 1:k_val){

    # get a drawing context
    d <- pil$ImageDraw$Draw(large)

    # label y-coordinate
    y_coord <- (i-1) * nrow * (w_sq + h_imgid) + 15

    # coord tuple
    coord_tuple <- reticulate::tuple(as.integer(0),as.integer(y_coord))

    # color tuple
    color_tuple <- reticulate::tuple(as.integer(0),as.integer(0),as.integer(0))

    # print out the label for each cluster
    d$text(coord_tuple,as.character(i),font=fntcluster,fill=color_tuple)

    # select img with label i
    img_label_i <- jpg_list_df[jpg_list_df['label'] == i,]

    # iterate img_label_i
    for (m in 1:nrow(img_label_i)){

      # open image
      img <- pil$Image$open(img_label_i[m,"jpg_list"])

      # size tuple
      size_tuple <- reticulate::tuple(as.integer(w_sq),as.integer(w_sq))
      img$thumbnail(size_tuple,pil$Image$LANCZOS)

      # calculate the position of img in the row; note python starts indexing from 0
      row_pos <- (m-1) %% ncol

      # x-coordinate of image
      img_x <- row_pos*w_sq + w_clusterid

      # y_coordinate of image
      # note
      img_y <- h_imgid + (as.numeric(img_label_i[m,"label"]) - 1) * (w_sq + h_imgid)

      # x,y tuple
      xy_tuple <- reticulate::tuple(as.integer(img_x), as.integer(img_y))

      #
      large$paste(img, xy_tuple)

    }

    # save path
    save_path <- file.path(cwd, "cluster","grid")
    if(!dir.exists(save_path)){
      dir.create(save_path)
    }
    # img savepath
    img_path <- paste(save_path,"/",model,".png",sep="")

    large$save(img_path)

  }
}



#' Save clustered images in grid directory as png files
#' Within this function, we call Save_Image.
#'
#' @param cwd Filepath of project directory
#' @param w_sq Width/height of image (300)
#' @param w_clusterid Width of text for cluster id (60)
#' @param h_imgid Height of gap (60)
#'
#' @export
#'
#' @examples Save_Img("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",300,60,60)
Save_Img <- function(cwd,w_sq,w_clusterid,h_imgid){
  cvmodels <- list("VGG16_fc1","VGG16_places_fc1","VGGFace_fc6")

  # cluster path
  cluster_path <- file.path(cwd, "cluster")

  # list dir under cluster
  dir_vector <- list.dirs(cluster_path, recursive = FALSE)

  # exclude grid directory
  dir_vector <- (dir_vector[basename(dir_vector) != "grid"])


  # for each dir : 6_Means...
  for (dir in dir_vector){
    # for each model
    for(model in cvmodels){
      # construct path .../cluster/6_Means/model
      fpath <- file.path(dir,model)

      # skip if path not existed
      if(!dir.exists(fpath)){
        next
      }

      # list of all img filepaths and convert to df
      jpg_list <- list.files(fpath,pattern="\\.jpg$",full.names = TRUE, recursive = TRUE)
      jpg_list_df <- as.data.frame(jpg_list)


      # extract label for each img
      jpg_list_df$label <- basename(dirname(jpg_list_df$jpg_list))


      # extract k in k-means
      k_val <- max(as.numeric(jpg_list_df$label))

      # save image
      Save_Image(cwd, jpg_list_df, k_val, model,w_sq,w_clusterid,h_imgid)
    }
  }
}












