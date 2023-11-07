#' Title calculating distance of all MT variants by Dirichlet process Gaussian mixture
#' @param data a VAF matrix for all MT variants, row is VAF, col is Cell
#' @return a list of distance for each MT variant
#' @export


MT.feature.distance <- function(data, iteration = 2000){

  tmp.MT.variants.name = rownames(data)
  n.row = nrow(data)
  n.col = ncol(data)
  print(paste("The number of all features:",n.row))
  print(paste("The number of all cells:",n.col))

  tmp.re = c()

  tmp.re = apply(data,1,DP.MT.variant,iteration = iteration)

  names(tmp.re) = tmp.MT.variants.name

  tmp.re.dis = c()
  for(i in 1:length(tmp.re)){
    print(i)
    tmp.data1 = tmp.re[[i]][1]
    tmp.data2 = tmp.re[[i]][2]
    tmp.dis = abs(tmp.data1-tmp.data2)
    tmp.re.dis = c(tmp.re.dis,tmp.dis)
  }
  names(tmp.re.dis) = names(tmp.re)

  return(tmp.re.dis)
  print("Finished!")
}



