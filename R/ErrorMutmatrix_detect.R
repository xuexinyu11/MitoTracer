#' Title find and remove the mutations that likely belong to sequencing error and construct the new matrix
#'
#' @param mut a data frame, row is the variant, cloum is the ID,position, s_reads,ave_BQ, t_reads, AF, sample info.
#' @param e is sequencing error rate, the default value is 0.001/3
#' @param FPR is false-positive rate (FPR), the default value is 0.0000005
#'
#' @return matrix of all MT variants with "detected" or "Error" label
#' @export

ErrorMutmatrix_detect <- function(MT_matrix, FPR=0.0000005)
{
	t_matrix <- MT_matrix ;
	t_matrix$detection <- apply(t_matrix, 1, function(x )ErrorMut_detect(x, FPR=FPR) )
	return(t_matrix) ;
}

