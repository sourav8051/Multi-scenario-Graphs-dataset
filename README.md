# Multi-scenario-Graphs-dataset
contains two preprocessed datasets. The COVID-19 data and KDD Cup 2003
files descriptions: 
KDD_main.R: this is the main file which preprocesses the generated keywords and calculates the pairwise Jaccard similarity matrix of all papers. It builds the networks as per the similarity index and calculates the GDDA(Graphlet Degree Distribution Agreement).
hep-th-citations.xls: Citation network in the KDDCup 2003 dataset
KDD_Cup complete dataset link: https://www.cs.cornell.edu/projects/kddcup/datasets.html 
preprocessing_KDD.R: This extracts the abstracts of the KDD 2003 dataset and the generate the keywords from the abstracts.

seqdata.csv: All the  viral samples with accession numbers used in the study
Country-wise_accession_numbers.pdf: samples with their corresponding country names
Make_kmer_network.R: creates k-mer network for a set of genome data
FASTA sequence data download link: https://www.ncbi.nlm.nih.gov/labs/virus/vssi/#/virus?SeqType_s=Nucleotide&VirusLineage_ss=Wuhan%20seafood%20market%20pneumonia%20virus,%20taxid:2697049 
