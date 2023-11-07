#
#' Title: read MT variants files of bulk ATACseq data
#'
#' @param path_MTvar is the file full path of mtSNP output files
#'
#' @return matrix of all MT variants info
#' @export
#'


read.MT.variant.files.bulkATACseq <- function(path_MTvar){

	all.filefolders = list.files(path=path_MTvar)
	print("Read all MT variant files!")
	setwd(path_MTvar)
	list.name = c()
	all.files.MT.variants = c()

for(i in all.filefolders){
	t.text = paste("read in MTvariants of sample",i, sep=" ")
	print(t.text)
	tmp.path = paste(path_MTvar,i,sep="/")
	setwd(tmp.path)
	list.name = c(list.name,i)
	t.file = paste(i,".MT_variants.txt",sep="")
	tmp.data = read.table(file=t.file, sep="",blank.lines.skip = TRUE,header=T) #cant't use "\t" to sepreate columns, has NA
	tmp.data = cbind(tmp.data,i)
	all.files.MT.variants = rbind(all.files.MT.variants,tmp.data)
}

print("Finished reading all MT variants files!")
colnames(all.files.MT.variants)[ncol(all.files.MT.variants)] = "sample"
return(all.files.MT.variants)



}
