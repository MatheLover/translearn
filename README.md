Installation Guide:

1. Open a new RStudio project 
2. Use remotes::install_github(translearn) for installation 
3. Use git to add two submodules required in the project (Make sure the current directory is the project)
      git submodule add https://github.com/MatheLover/Keras-VGG16-places365.git place_translearn_2
      git submodule add https://github.com/vmarichkav/keras-vggface.git VGG_Face_translearn_2
5. Load translearn by library(translearn)
6. Install py packages by the Install_Py_Packages()
7. Arrange files according to this structure 
![Alt text](Dir_Structure.png "Directory Structure")

Note: 5, 6, and 7 are already included in Test.R.
 
