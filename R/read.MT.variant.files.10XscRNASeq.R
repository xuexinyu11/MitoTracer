#' Title read MT variant files from 10X scRNA-seq data
#'
#' @param path_MTvar is the file path of mtSNP output files
#'
#' @return matrix of all MT variants info
#' @export
#'


read.MT.variant.files.10XscRNASeq <- function(path_MTvar){

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

	tmp.data = read.table("possorted_genome_bam.MT_variants.txt", sep="",blank.lines.skip = TRUE,header=T) #cant't use "\t" to sepreate columns, has NA
	tmp.label = paste(i,tmp.data$ID,sep="-")
	tmp.data = cbind(tmp.data,tmp.label)
	tmp.data = cbind(tmp.data,i)
	all.files.MT.variants = rbind(all.files.MT.variants,tmp.data)


}

print("Finished reading all MT variants files!")
colnames(all.files.MT.variants)[ncol(all.files.MT.variants)-1] = "sample"
colnames(all.files.MT.variants)[ncol(all.files.MT.variants)] = "label"
return(all.files.MT.variants)

}

