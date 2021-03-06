\name{color.scale}
\alias{color.scale}
\title{Turn values into colors.}
\description{Transform numeric values into colors using RGB, HSV or HCL}
\usage{
 color.scale(x,cs1=c(0,1),cs2=c(0,1),cs3=c(0,1),alpha=1,
  extremes=NA,na.color=NA,xrange=NULL,color.spec="rgb")
}
\arguments{
 \item{x}{a numeric vector, matrix or data frame}
 \item{cs1,cs2,cs3}{color parameters for scaling \samp{x}}
 \item{alpha}{Value for transparency in colors.}
 \item{extremes}{The colors for the extreme values of \samp{x} (RGB only).}
 \item{na.color}{The color to use for NA values of \samp{x}.}
 \item{xrange}{An explicit range to use in the transformation.}
 \item{color.spec}{The color specification to use in the transformation.
  Anything other than "rgb", "hsv" or "hcl" will almost certainly fail.}
}
\details{
 \samp{color.scale} calculates a sequence of colors by a linear
  transformation of the numeric values supplied into the ranges 
  for the three color parameters. If only one number is supplied for a
  color range, that color remains constant for all values of \samp{x}.
  If more than two values are supplied, the \samp{x} values will be
  split into equal ranges (one less than the number of colors) and 
  the transformation carried out on each range. Values for a color
  range must be between 0 and 1 for the RGB or HSV specifications, and 
  between 0 and 360 (cs1) and 0 to 100 (cs2 and cs3) for the HCL 
  specifications.

  IMPORTANT: If \samp{x} has fewer values than the number of values
  in the color parameters, it will usually return incorrect
  colors. This is usually only a problem when using \samp{color.legend}
  with a small number of rectangles in the legend as \samp{color.legend}
  calls \samp{color.scale} to calculate the color rectangles.
  
  If \samp{extremes} is not NA, the ranges will be calculated from
  its values using \samp{col2rgb}, even if ranges are also supplied.
  \samp{extremes} allows the user to just pass the extreme color values
  in any format that \samp{col2rgb} will accept. Note that this forces
  the color specification to RGB.

  If the user wants to specify a range of values with \samp{xrange},
  it must at least include the range of x values. This can be useful
  when there is a notional range like 0-100% that the values do not
  cover, or when several series of values with different ranges are
  to be assigned the same color scale.

  The user may not want the color scheme to be continuous across some
  critical point, often zero. In this case, color scale can be called
  separately for the values below and above zero. I may get around to
  adding an argument to do this in one shot. Until then, see the second
  example for \samp{color2D.matplot} and also the \samp{diverge.hcl} and
  \samp{diverge.hsv} functions in the \samp{colorspace} package.
}
\note{
 The function is useful for highlighting a numeric dimension or adding
 an extra "dimension" to a plot.

 There are quite a few R functions that transform numeric values into
 colors or produce colors that can be used to represent values. Two
 packages that might be of interest are \pkg{RColorBrewer} and 
 \pkg{colourschemes}.
}
\value{A vector or matrix of hexadecimal color values.}
\author{Jim Lemon}
\seealso{\link{rescale}, \link{col2rgb}, \link{smoothColors}}
\examples{
 # go from green through yellow to red with no blue
 x<-rnorm(20)
 y<-rnorm(20)
 # use y for the color scale
 plot(x,y,col=color.scale(y,c(0,1,1),c(1,1,0),0),main="Color scale plot",
  pch=16,cex=2)
 plot(1:10,rep(1:3,length.out=10),axes=FALSE,type="n",xlim=c(0,11),ylim=c(0,4),
  main="Test of RGB, HSV and HCL",xlab="",ylab="Color specification")
 axis(2,at=1:3,labels=c("HCL","HSV","RGB"))
 points(1:10,rep(1,10),pch=19,cex=8,col=color.scale(1:10,c(0,300),35,85,
  color.spec="hcl"))
 points(1:10,rep(2,10),pch=19,cex=8,col=color.scale(1:10,c(0,1),
  0.8,1,color.spec="hsv"))
 points(1:10,rep(3,10),pch=19,cex=8,col=color.scale(1:10,c(1,0.5,0),
  c(0,0.5,0),c(0,0,1),color.spec="rgb"))
}
\keyword{misc}
