
#' Title calculating the distance for each MT variant by Dirichlet process Gaussian mixture
#'
#' @param x the VAF vector of one MT variant
#'
#' @return the mean values of all peaks for one MT variants
#' @export

DP.MT.variant <- function(x, iteration = 2000) {
  library(dirichletprocess)
  tmp.var.1 = x
  tmp.var.2 = scale(tmp.var.1)
  tmp.dp = DirichletProcessGaussian(tmp.var.2)
  tmp.dp = Fit(tmp.dp, iteration, progressBar = FALSE)
  tmp.weights = tmp.dp$weights
  tmp.clusters = c(1:tmp.dp$numberClusters)
  names(tmp.weights) = tmp.clusters
  tmp.weights = sort(tmp.weights, decreasing = TRUE)
  tmp.labels = tmp.dp$clusterLabels
  tmp.points = tmp.dp$pointsPerCluster

  tmp.re = c()
  for(i in 1:length(tmp.clusters)){

    tmp.cluster = names(tmp.weights)[i]
    tmp.cluster.data = tmp.var.1[which(tmp.labels == tmp.cluster)]
    tmp.mean = mean(tmp.cluster.data)
    tmp.re = c(tmp.re,tmp.mean)
  }
  names(tmp.re)  = tmp.points
  return(tmp.re)

}

