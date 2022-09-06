#' Generates .txt file containing image file paths from their folder(s).
#'
#' @param cwd Filepath of the project directory containing img file
#'
#' @export
#'
#' @examples Generate_txt("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material")
Generate_txt <- function(cwd){
  # img directory path
  img_dir_path <- file.path(cwd, "img")
  # image filepaths(absolute)
  img_filepath <- list.files(img_dir_path, recursive = TRUE,
                             pattern = "\\.(jpg|jpeg|png|gif)$",full.names = TRUE)
  img_df <- as.data.frame(img_filepath)

  # The directory path containing img.txt
  txt_dir <- file.path(cwd, "img_txt")

  # create txt_dir if not existed
  if(!dir.exists(txt_dir)){
    dir.create(txt_dir)
  }

  # txt filepath
  txt_fp <- file.path(txt_dir,"img.txt")

  # randomly permutate rows
  # make sure the result is replicated
  set.seed(721)
  rand <- sample(nrow(img_df))
  img_df <- img_df[rand,]

  # write to img.txt file
  write.table(img_df, txt_fp, sep = "\t",row.names = FALSE, col.names = FALSE)
}

