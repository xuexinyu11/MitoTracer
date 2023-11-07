#' Title check the sequencing error for each MT variant, and labeled each MT variant with "detected" or "Error"
#'
#' @param mut a vector with ID,position, s_reads,ave_BQ, t_reads, AF, sample info.
#' @param e is sequencing error rate, the default value is 0.001/3
#' @param FPR is false-positive rate (FPR), the default value is 0.0000005
#'
#' @return a vector of one MT variant with "detected" or "Error" label
#' @export
#'


ErrorMut_detect <- function(mut, e=0.001/3, FPR=0.0000005)
{
	n = as.numeric(mut[5]) ; #t_reads
	s = as.numeric(mut[3]) ; #s_reads
	P = 1 - sum(dbinom(0:(s-1), n, e));
	if(P < FPR)
	{ return("detected") } else{
	  return("Error")
	}
}
