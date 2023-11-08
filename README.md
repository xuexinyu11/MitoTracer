# MitoTracer
MitoTracer facilitates the identification of informative mitochondrial mutations for precise lineage reconstruction
>This is a README file of the R package MitoTracer. In our Paper, MitoTracer facilitates the identification of informative mitochondrial mutations for precise lineage reconstruction, we develop an open-source computational algorithm called “MitoTracer”, which accurately identified clonally informative MT mutations and inferred evolutionary lineage from scRNA-seq or scATAC-seq samples. We benchmarked MitoTracer using the ground-truth experimental lineage sequencing data and demonstrated its superior performance over the existing methods measured by high sensitivity and specificity. MitoTracer is compatible with multiple single cell sequencing platforms.
# Configuration
MitoTracer version 0.1.0 is performed in R ver 4.2.3.
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
>Step 1: Read all files of mitochondrial variants (*.MT_variants.txt) called from MERCI-mtSNP into R environment. Here we prepared an example bulk ATAC-seq data folder, there are 12 sub-folders. (Users can find the dataset of example files in )

