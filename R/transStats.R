#' Calculate stability, spread, and symmetry metrics for all transition matrices within a transition array
#'
#'
#'
#' @param x An object of class "transArray"
#' @return A data frame with the following columns:
#' * \code{subjectID}: participant ID
#' * \code{matObs}: transition matrix observation
#' * \code{stability}: stability value
#' * \code{spread}: spread value
#' * \code{symmetry}: symmetry value
#' @examples
#' #load in example data
#' data(exampleTransitionData)
#'
#' #calculate transition array for example data with a window size of 5
#' myArray <- buildTransArray(exampleTransitionData, W=5)
#'
#' #get transition metrics
#' results <- transStats(myArray)
#'
#' @export


transStats <- function(x){
  if (class(x)!="transArray"){
    stop("x must be of class transArray. See buildTransArray().")
  }
  res <- data.frame(matrix(NA, ncol=5, nrow=dim(x)[1]*dim(x)[4]))
  k <- 1
  for (i in 1:dim(x)[1]){
    for (j in 1:length(na.omit(x[i,1,1,]))){
      res[k,1] <- dimnames(x)[[1]][i]
      res[k,2] <- j
      res[k,3] <- ifelse(sum(x[i,,,j])==0, "noUse", sum(diag(x[i,,,j])) / sum(x[i,,,j]))
      res[k,4] <- nnzero(x[i,,,j]) / (dim(x)[2]*dim(x)[3])
      Asym <- (x[i,,,j] + t(x[i,,,j])) * .5
      Aasym <- (x[i,,,j] - t(x[i,,,j])) * .5
      res[k,5] <- ifelse(sum(x[i,,,j])==0, "noUse", (norm(Asym,type="2") - norm(Aasym,type="2"))/(norm(Asym,type="2") + norm(Aasym,type="2")))
      k <- k+1
    }
  }
  res <- na.omit(res)
  colnames(res) <- c("subjectID", "matObs", "stability", "spread", "symmetry")
  attributes(res)$na.action <- NULL
  return(res)
}

#Copyright (c) 2020, Katharine Daniel
