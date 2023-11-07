#' Title remove all adjacent MT variants
#'
#' @param x the character vector of MT variants
#' @param size you will remove all adjacent mutations smaller than "size"
#'
#' @return the list of MT variants after removing the adjacent MT variants
#' @export
#'
remove_adjacent_MT_variants <- function(x,size = 5){
	tmp.loc = c()
	for(i in 1:length(x)){
	tmp.data = x[i]
	tmp.re = strsplit(tmp.data,"_")[[1]][2]
	tmp.loc = c(tmp.loc, as.numeric(tmp.re))
	}
	names(tmp.loc) = x
	tmp.loc = tmp.loc[order(tmp.loc)]
	tmp.1 = tmp.loc[2:length(tmp.loc)]
	tmp.2 = tmp.loc[1:(length(tmp.loc)-1)]
	tmp.dis = abs(tmp.1-tmp.2)

	tmp.remove.loc.1 = which(tmp.dis<size)
	tmp.remove.loc.2 = tmp.remove.loc.1-1

	tmp.remove.loc.final = unique(c(tmp.remove.loc.1,tmp.remove.loc.2))
	tmp.remove.variant = names(tmp.dis[tmp.remove.loc.final])

	tmp.return.re = setdiff(x,tmp.remove.variant)
	return(tmp.return.re)

}

