# MitoTracer
MitoTracer facilitates the identification of informative mitochondrial mutations for precise lineage reconstruction
>This is a README file of the R package MitoTracer. In our Paper, MitoTracer facilitates the identification of informative mitochondrial mutations for precise lineage reconstruction, we develop an open-source computational algorithm called “MitoTracer”, which accurately identified clonally informative MT mutations and inferred evolutionary lineage from scRNA-seq or scATAC-seq samples. We benchmarked MitoTracer using the ground-truth experimental lineage sequencing data and demonstrated its superior performance over the existing methods measured by high sensitivity and specificity. MitoTracer is compatible with multiple single cell sequencing platforms.
# Configuration
MitoTracer version 0.1.1 is performed in R ver 4.2.3.
flexmix ver 2.3-19, dirichletprocess ver 0.4.2, lattice ver 0.21-8
# Install MitoTracer package
To install our package, you may simply execute the following codes.
```
library(devtools)
install_github(repo='xuexinyu11/MitoTracer')
```
# Usage
>**This text will use a benchmark example data to illustrate how to use MitoTracer package**
>After the MitoTracer package is successfully installed, load the package.
```
library(MitoTracer)
```
>**Step 1**: Read all files of mitochondrial variants (*.MT_variants.txt) called from MERCI-mtSNP (https://github.com/shyhihihi/MERCI) into R environment. Here we prepared an example bulk ATAC-seq data folder, there are 12 sub-folders. (Users can find the dataset of example files in https://github.com/xuexinyu11/MitoTracer/tree/main/Example_data/TF1_bulkATAC)
>To ensure that all mitochondrial variants are read once, it is necessary to provide the **full path** to the example data folder on your computer.

>The current example data is bulk ATAC-seq, we use function 'read.MT.variant.files.bulkATACseq' to read file. If your data is 10X scRNA-seq or Smart -seq2, please use 'read.MT.variant.files.10XscRNASeq' or 'read.MT.variant.files.SmartSeq2' to read mitochondrial variant files from the folder.
```
path_MTvar="/the_path_in_your_computer/MitoTracer/Example_data/TF1_bulkATAC";
example.data <- read.MT.variant.files.bulkATACseq(path_MTvar);
```
>**Step 2**: Remove sequencing errors and extract the VAF matrix. Just keep "detected" mitochondrial variants for following analysis.
```
example.data.MT_variants = ErrorMutmatrix_detect(example.data)
example.data.MT_variants.detected = example.data.MT_variants[example.data.MT_variants$detection == "detected",];
example.data.MT_variants.detected.matrix = MTmutMatrix_refined(example.data.MT_variants.detected);
```
>**Step 3**: Calculate the distance between top two Gaussian peaks diessected by Dirichlet Process. If the cell count is below 100, we recommend using 2000 iterations; otherwise, 1000 iterations should suffice. The default interation is 2000.

>This process can be time-consuming, especially when dealing with numerous mitochondrial variants. Consider dividing your matrix into smaller sub-matrices and running the code separately to expedite the execution.
```
example.data.MT_variants.detected.distance = MT.feature.distance(example.data.MT_variants.detected.matrix[1:30,], iteration = 2000);
```
>**Step 4**: Select the informative mitochondrial variants. In this step, we should specify some cutoffs to select the informative mitochondrial variants.

>The parameter 'dis_cutoff' filters instances where the top two peaks exhibit a considerable spatial separation, with a default threshold at 0.05. For this example, we're using 30 MT mutations to go through the pipeline. Since the number of MT mutations is limited, we've set the cutoff to zero and applied no filtration to these mutations.

>The parameter 'sample_type' assumes the role of an indicator for specifying cellular lineage information. If the lineages in question originate from disparate cell lines or patient samples, it is incumbent upon the user to designate 'sample_type' as 1. Conversely, in instances where the lineages are generated through sequential culturing, the parameter 'sample_type' should be assigned a value of 2. The default value is 1.

>The parameter 'size' is specify the distance of adjacent mutation sites, we recommend to remove all adjacent mutations within 'size' sites, the default value is 5. 
```
example.data.MT_variants_informative = MT.feature.selection(example.data.MT_variants.detected.distance, example.data.MT_variants.detected.matrix， dis_cutoff = 0, sample_type = 1 , size = 5 )
```




