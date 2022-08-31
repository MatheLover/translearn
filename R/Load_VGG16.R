# Load VGG16 model and print out model summary(e.g. output shapes and Param #)
# Reference:
# 1. https://github.com/yilangpeng/image-clustering/blob/main/study2A/A1%20feature%20extraction%20VGG16.py
# 2. https://keras.io/api/applications/


#' Load VGG16 model and print out model summary(e.g. output shapes and Param #)
#'
#' @return a VGG16 model
#' @export
#'
#' @examples Load_VGG16()
Load_VGG16 <- function(){
  # load pre-trained weights based on ImageNet
  base_model <- application_vgg16(weights = 'imagenet', include_top = TRUE)

  # load the pre-trained model to a deep learning model
  model <- keras_model(inputs = base_model$input,
                       outputs = get_layer(base_model, 'fc1')$output)

  # check model
  summary(model)


  return (model)
}


