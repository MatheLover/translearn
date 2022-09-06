#' Check whether the Python packages are installed. If not, installation will be carried out.
#'
#' @export
#'
#' @examples Install_Py_Packages()
Install_Py_Packages <- function(){
  # package vector
  pac_c <- c("joblib","numpy","pandas","sklearn","pillow","keras","keras_applications","keras-vggface")

  # currently installed Py packages
  py_df <- reticulate::py_list_packages()

  # iterate pac vector
  for (pac in pac_c){
    # if not installed
    if(!pac%in% py_df$package){
      reticulate::py_install(pac,pip = TRUE)
    }
  }
}


