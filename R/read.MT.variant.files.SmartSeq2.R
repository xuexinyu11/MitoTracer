#' Title read MT variant files from Smartseq2 data
#'
#' @param path_MTvar is the file path of mtSNP output files
#'
#' @return matrix of all MT variants info
#' @export
#'

read.MT.variant.files.SmartSeq2 <- function(path_MTvar){

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
	tmp.files = list.files(tmp.path)

	list.name = c(list.name,tmp.files)
	for(k in tmp.files ){
	#print(k)
	tmp.data = read.table(k, sep="",blank.lines.skip = TRUE,header=T) #cant't use "\t" to sepreate columns, has NA
	tmp.label = strsplit(k,"[.]")[[1]][1]
	tmp.label = paste(tmp.label,i,sep="_")
	tmp.data = cbind(tmp.data,tmp.label)
	all.files.MT.variants = rbind(all.files.MT.variants,tmp.data)
	}

}

print("Finished reading all MT variants files!")
colnames(all.files.MT.variants)[ncol(all.files.MT.variants)] = "sample"
return(all.files.MT.variants)

}

