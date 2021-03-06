\name{pie.labels}
\alias{pie.labels}
\title{ Place labels on a pie chart }
\description{
 Places labels on a pie chart
}
\usage{
 pie.labels(x,y,angles,labels,radius=1,bg="white",border=TRUE,minangle=NA,...)
}
\arguments{
 \item{x,y}{x and y position of the center of the pie chart}
 \item{angles}{A numeric vector representing angles in radians. This is
  the return value of \samp{floating.pie}.}
 \item{labels}{Text strings to label each sector.}
 \item{radius}{The radius at which to place the labels in user units. The
  default is 1.}
 \item{bg}{The color of the rectangles on which the labels are displayed.}
 \item{border}{Whether to draw borders around the rectangles.}
 \item{minangle}{Minimum angle between labels.}
 \item{...}{Arguments passed to \samp{boxed.labels}.}
}
\value{nil}
\details{
 Labels may be placed within the pie (radius less than the pie radius),
 on the edge or outside as in the examples below. If some labels overlap,
 passing a value in radians for \samp{minangle} may be used to spread them out.
}
\note{
 Remember that \samp{x} and \samp{y} specify the center of the pie chart and
 that the label positions are specified by angles and radii from that 
 center.
}
\author{Jim Lemon}
\seealso{\link{floating.pie}, \link{boxed.labels}, \link{spreadout}}
\examples{
 pieval<-c(2,1,3,94)
 plot(1:5,type="n",axes=FALSE,xlab="",ylab="")
 box()
 bisect.angles<-floating.pie(3,3,pieval)
 pie.labels(3,3,bisect.angles,c("two","one","three","ninety\nfour"))
 pie.labels(3,3,bisect.angles,radius=1.5,
  c("First\nvalue","Second\nvalue","Third\nvalue","Fourth\nvalue"),
  minangle=0.2)
}
\keyword{misc}
