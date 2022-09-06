# This program can resize images and save them as a specific file type.
# Reference:
# 1. https://www.ben-johnston.co.uk/bulk-resizing-images-with-r/
# 2. https://cran.r-project.org/web/packages/magick/vignettes/intro.html


#' Load, resize images to desirable dimensions, and save them as a specific file type(e.g. jpg)
#'
#' @param img_dimension(character) The dimension(widthxheight) of a resized image. The default is 0 -- unchanged.
#' Note: The image size may be changed permanently if the image is already in the desirable file type.
#        If you want to change img size only temporarily, please modify image size in Extract_Feature method rather than here.
#' @param img_filepath(character) The file path of the project directory
#' @param img_type(character) The desirable image file type(e.g. jpg, jpeg, png, and gif)
#'
#' @return Images will be saved. None will be returned
#' @export
#'
#' @examples process_img("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material", "jpg")
#' @examples process_img("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material", "jpeg" )
Image_Processing <- function(img_filepath, img_type){
  # construct filepath for the image directory
  imgdir_fp <- file.path(img_filepath, "img")

  # list all image files(jpg|jpeg|png|gif) in the directory
  img_list <- list.files(imgdir_fp, pattern = 'jpg|jpeg|png|gif', recursive = TRUE, full.names = TRUE)

  # iterate through the img_list to resize and save to specific file types
  for (i in 1:length(img_list)){
    # read each img
    img <- magick::image_read(img_list[i])

    # file type of original img
    ftype <- substring(img_list[i], nchar(img_list[i])-2, nchar(img_list[i]))

    # if the filetype of orginal image is not .jpg (e.g. jpeg)
    if(ftype != img_type){
      # change file type to desirable img type
      img_d <- magick::image_convert(img,img_type)

    }


    # output img filepath
    fpath_out <- paste(substring(img_list[i], 1, nchar(img_list[1]) - 4), ".",img_type, sep="")

    # save image
    magick::image_write(img_d, path = fpath_out, format=img_type)

  }

}


