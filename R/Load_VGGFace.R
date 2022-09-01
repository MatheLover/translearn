# Load VGGFace model and print out model summary(e.g. output shapes and Param #)

# import keras.models and keras_vggface
keras_models <- reticulate::import("keras.models")

# python lib path within the R package
py_path <- file.path(getwd(),"VGG_Face_translearn_2")
keras_vggface <- reticulate::import_from_path("keras_vggface", path = py_path, convert = TRUE, delay_load = FALSE)

#' Load VGGFace model and print out model summary(e.g. output shapes and Param #)
#'
#' @return a VGGFace model
#' @export
#'
#' @examples Load_VGGFace()
Load_VGGFace <- function(){
  # load pre-trained weights from the base model
  vggface <- keras_vggface$vggface$VGGFace(model='vgg16')

  # load pre-trained base model to a new deep learning model
  vggface_input <- vggface$input
  vggface_layer_output <- vggface$get_layer('fc6')$output
  feature_model <- keras_models$Model(vggface_input, vggface_layer_output)
  feature_model$summary()

  return (feature_model)
}


