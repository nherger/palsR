barNest<-function(formula=NULL,data=NULL,FUN=c("mean","sd"),
 ylim=NULL,main="",xlab="",ylab="",shrink=0.1,errbars=FALSE,
 col=NA,labelcex=1,lineht=NA,showall=TRUE,barlabels=NULL,
 showlabels=TRUE,mar=NULL,arrow.cap=NA,trueval=NA) {

 x<-brkdnNest(formula=formula,data=data,FUN=FUN,trueval=trueval)
 getBreakListNames<-function(x) {
  blnames<-list(names(x[[1]][[1]]))
  for(level in 2:length(x[[1]]))
   blnames[[level]]<-dimnames(x[[1]][[level]])[[level-1]]
  return(blnames)
 }
 if(is.null(barlabels)) barlabels<-getBreakListNames(x)
 nbn<-length(as.character(attr(terms(formula),"variables")[-1]))
 # don't use overall value to calculate ylim when counts are displayed
 # or when the "sum" function is used to combine pre-calculated values
 if(FUN[1]=="valid.n" || FUN[1]=="sumbrk" || FUN[1]=="sum") {
 if(is.null(ylim)) ylim<-c(0,1.04*max(unlist(x[[1]][[2]]),na.rm=TRUE))
  if(FUN[1]=="valid.n" || FUN[1]=="sum") barlabels[[1]]<-""
 }
 else {
  lenx<-length(x)
  if(errbars) {
   errbars<-length(x)
   if(lenx == 3) {
    # x[[2]] is the higher dispersion limit, x[[3]] is the lower
    if(is.null(ylim))
     ylim<-c(min(unlist(x[[3]]),na.rm=TRUE),
     max(unlist(x[[2]]),na.rm=TRUE))
   }
   else {
    # x[[2]] is a symmetric dispersion interval, get the limits
    x[[3]]<-x[[2]]
    if(is.null(ylim))
     ylim<-c(min(unlist(x[[1]])-unlist(x[[3]]),na.rm=TRUE),
     max(unlist(x[[1]])+unlist(x[[2]]),na.rm=TRUE))
    # bottom of plot must be at zero
    if(ylim[1] < 0) ylim[1]<-0
   }
   if(is.na(arrow.cap)) arrow.cap<-0.25/length(unlist(x[[1]]))
  }
  else {
   # funname<-names(x[[1]][[1]])[2]
   if(is.null(ylim)) ylim<-range(unlist(x[[1]]),na.rm=TRUE)
  }
  # add the bit of space at the top
  ylim<-ylim+c(ifelse(ylim[1]<0,-0.04,0),0.04)*diff(ylim)
  # don't display negative values
  if(ylim[1] > 0) ylim[1]<-0
 }
 if(!is.null(mar)) oldmar<-par(mar=mar)
 # display the blank plot
 plot(0,xlim=c(0,1),ylim=ylim,main=main,xlab=xlab,
  ylab=ylab,xaxt="n",yaxs="i",type="n")
 # get the plot limits
 parusr<-par("usr")
 # if no line height specified for the labels, calculate it
 if(is.na(lineht))
  lineht<-1.05*labelcex*diff(parusr[3:4])*
   (par("mai")[1]/par("pin")[2])/par("mar")[1]
 # number of levels to plot
 nlevels=length(x[[1]])
 drawNestedBars(x,start=0,end=1,shrink=shrink,errbars=errbars,
  col=col,labelcex=labelcex,lineht=lineht,showall=showall,
  barlabels=barlabels,showlabels=showlabels,arrow.cap=arrow.cap)
 # is this needed?
 abline(h=0)
 if(FUN[1]=="valid.n") box()
 # if the margins were changed, reset them
 if(!is.null(mar)) par(mar=oldmar)
 invisible(x)
}
