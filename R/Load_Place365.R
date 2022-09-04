# Load VGG16_Place_365 model and print out model summary(e.g. output shapes and Param #)



#' Load VGG16_Place_365 model and print out model summary(e.g. output shapes and Param #)
#'
#' @return a VGG16_Place_365 model
#' @export
#'
#' @examples Load_Place365()
Load_Place365 <- function(){
  # import keras.models and vgg16_place_365
  keras_models <- reticulate::import("keras.models")
  # local python lib within R package
  py_path_place <- file.path(getwd(),"place_translearn_2")
  vgg16_place365 <- reticulate::import_from_path("vgg16_places_365", path = py_path_place, convert = TRUE, delay_load = FALSE)

  # load pre-trained weights from the base model
  shape <- tuple(as.integer(224),as.integer(224),as.integer(3),convert=TRUE)
  base_model <- vgg16_place365$VGG16_Places365(weights='places', include_top=TRUE,input_shape = shape)

  # load pre-trained base model to a new deep learning model
  input <- base_model$input
  base_model_layer_output <- base_model$get_layer('fc1')$output
  feature_model <- keras_models$Model(input, base_model_layer_output)
  feature_model$summary()

  return (feature_model)
}


