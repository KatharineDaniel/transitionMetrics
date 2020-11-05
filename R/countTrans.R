#' Counts transitions between raw time series data
#'
#'
#'
#' @param x A binary time series (0,1)
#' @param y A binary time series (0,1)
#' @return The number of times \code{y} is observed immediately after observing \code{x}
#' @examples
#'  x <- c(1,1,1,1,1)
#'  y <- c(0,0,1,0,1)
#'  countTrans(x, y)
#' @export

countTrans <- function(x, y){
  tCount <- 0
  for(i in 1:(length(x)-1)){
    if(x[i]==1 & y[i+1]==1){
      tCount <- tCount + 1
    }
  }
  return(tCount)
}

#Copyright (c) 2020, Katharine Daniel
