% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Save_Img.R
\name{Save_Img}
\alias{Save_Img}
\title{Save clustered images in grid directory as png files
Within this function, we call Save_Image.}
\usage{
Save_Img(cwd, w_sq, w_clusterid, h_imgid)
}
\arguments{
\item{cwd}{Filepath of project directory}

\item{w_sq}{Width/height of image (300)}

\item{w_clusterid}{Width of text for cluster id (60)}

\item{h_imgid}{Height of gap (60)}
}
\description{
Save clustered images in grid directory as png files
Within this function, we call Save_Image.
}
\examples{
Save_Img("/Users/benchiang/Documents/ComputationalSocialScience/R_Package_Material",300,60,60)
}
