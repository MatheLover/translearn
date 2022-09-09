#' Subset the .txt generated from Generate_txt function
#'
#' @param cwd Filepath of the project directory containing img file
#' @param num_obs Number of observations used for testing. Note that
#'
#' @export
#'
#' @examples Subset_txt("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material", 100)
Subset_txt <- function(cwd, num_obs){
  # Filepath of img.txt
  fpath_txt <- file.path(cwd, "img_txt/img.txt")

  # read .txt file cataloguing all img files
  imgfile_catalog <- readr::read_delim(fpath_txt, delim='\t', col_names=FALSE)

  # subset
  # ensure that the sample size does not exceed the number of images
  if(num_obs > nrow(imgfile_catalog)){
    num_obs <- nrow(imgfile_catalog)
  }
  img_sample <- imgfile_catalog[1:num_obs,]

  # create new dir path for saving sample
  save_dir <- file.path(cwd, "img_txt_sample")
  if(!dir.exists(save_dir)){
    dir.create(save_dir)
  }

  # filepath for .txt
  save_txt <- file.path(save_dir,"img_txt_sample.txt")

  # save
  write.table(img_sample, save_txt, sep = "\t",row.names = FALSE, col.names = FALSE)
}
