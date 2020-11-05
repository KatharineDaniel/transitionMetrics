#' Builds a transition array between raw time series data
#'
#'
#'
#' @param x A data set of binary time series to be included in a transition matrix.
#' @param W A hyperparameter denoting the number of observations to include in a single transition matrix.
#' @return An object of class "transArray". An array of transition matrices with the following dimensions:
#' * dimension 1: participant
#' * dimension 2: first time series
#' * dimension 3: second time series
#' * dimension 4: transition matrix
#' @examples
#' #load in example data
#' x <- data(exampleTransitionData)
#'
#' #calculate transition array for example data with a window size of 5
#' myArray <- buildTransArray(x, W=5)
#'
#' @export

buildTransArray <- function(x,W=5){
  myDataMatrix <- x[,-1]
  N <- length(unique(x[,1]))
  IDs <- unique(x[,1])
  numVars<- ncol(myDataMatrix)
  numObs <- nrow(myDataMatrix)/N
  vars <- paste("x_",1:numVars,sep="")
  myDataArray <- array(NA, dim=c(N, numObs,numVars), dimnames=list(IDs, paste("Obs", 1:numObs, sep=""),vars))
  myTransArray <- array(NA, dim=c(N, numVars, numVars, (numObs-W+1)),
                        dimnames=list(IDs, paste("to", vars, sep = "_"), paste("from", vars, sep = "_"),
                                      paste("Window", 1:(numObs-W+1), sep="")))
  for(i in 1:N){
    myDataArray[i,,] <- myDataMatrix[which(x[,1]==IDs[i]),]
    for(j in 1:numVars){
      for(k in 1:numVars){
        for(l in 1:(numObs-W+1)){
          myTransArray[i,j,k,l] <- countTrans(myDataArray[i,l:(l+W-1),k], myDataArray[i,l:(l+W-1),j])
        }
      }
    }
  }
  class(myTransArray) <- "transArray"
  return(myTransArray)
}

#Copyright (c) 2020, Katharine Daniel
