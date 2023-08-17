#' Check whether the Python packages are installed. If not, installation will be carried out.
#'
#' @param method Installation method
#' @param envname See Install_Virtualenv(envname="my_env", python=NULL) below
#' @param python See Install_Virtualenv(envname="my_env", python=NULL) below
#'
#' @param envname_conda See Install_Conda(envname_conda,pac_c) below
#'
#' @export
#'
#' @examples Install_Py_Packages_v2("default")
#' @examples Install_Py_Packages_v2("virtualenv",envname="my_env")
#' @examples Install_Py_Packages_v2("conda",envname="~/Documents/conda_test")
Install_Py_Packages_v2 <- function(method="default",envname="my_env", python=NULL, envname_conda="my_conda_env"){
  # package vector
  pac_c <- c("joblib","numpy","pandas","scikit-learn","pillow","keras==2.9.0","keras_applications","keras-vggface","tensorflow==2.9.1")

  if(method == "default"){
    Install_Default(pac_c)
  }
  else if(method == "virtualenv"){
    Install_Virtualenv(pac_c, envname=envname, python=NULL)
  }
  else if(method == "conda"){
    Install_Conda(envname_conda=envname_conda,pac_c=pac_c)
  }

}



#' Install Python packages by default(using miniconda)
#'
#'
#' @param pac_c Character vector containing list of packages to be installed
#'
#'
#' @examples Install_Default()
Install_Default <- function(pac_c){

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


#' Install Python packages via virtualenv
#'
#' The parameters are based on reticulate packages. ((https://rstudio.github.io/reticulate/reference/virtualenv-tools.html))
#'
#' @param envname The name of, or path to, a Python virtual environment. If this name contains any slashes, the name will be interpreted as a path; if the name does not contain slashes, it will be treated as a virtual environment within virtualenv_root().
#'                When NULL, the virtual environment as specified by the RETICULATE_PYTHON_ENV environment variable will be used instead. To refer to a virtual environment in the current working directory, you can prefix the path with ./<name>.
#' @param python  The path to a Python interpreter, to be used with the created virtual environment. When NULL, the Python interpreter associated with the current session will be used. ()
#' @param pac_c Character vector containing list of packages to be installed
#'
#'
#' @examples Install_Virtualenv(c("joblib","numpy","pandas","sklearn","pillow","keras","keras_applications","keras-vggface","tensorflow"),envname="my_env", python=NULL)
Install_Virtualenv <- function(pac_c, envname="my_env", python=NULL){
  # create a new virtualenv
  # reticulate::virtualenv_create(envname = envname, python=python)

  # install packages
  reticulate::virtualenv_install(envname = envname,packages = pac_c)
}



#' Install Python packages via Conda
#'
#' The parameter is based on reticulate package.(https://rstudio.github.io/reticulate/reference/conda-tools.html)
#'
#' @param envname_conda The name of, or path to, a conda environment
#' @param pac_c Character vector containing list of packages to be installed
#'
#'
#' @examples Install_Conda("my_conda_env",c("joblib","numpy","pandas","sklearn","pillow","keras","keras_applications","keras-vggface","tensorflow"))
Install_Conda <- function(envname_conda,pac_c){
  # create a new conda environment
  # reticulate::conda_create(envname = envname_conda )

  # install packages
  reticulate::conda_install(envname = envname_conda,packages = pac_c, pip=TRUE)

}




