

make_kmer_network=function(country,month,kmer)
{
  #it will create a network from a distance matrix to a binary matrix to be considered as 
  #adjacency matrix of the kmer_network. The cutoff value is chosen the median of the input values
  library(igraph)
  library(readr)
  library(gdata)
  library(philentropy)
  library(tidyr)
  #library(distances)
  
  if (month!="all")
  {
    mon_seq=which(kmer$Months==month)
    kmer=kmer[mon_seq,]
  }
 
    
  contry_seq=which(kmer$Country==country)
  if (length(contry_seq)>100)
  { contry_seq=sample(contry_seq,size = 100)}
  kmer=kmer[contry_seq,]
  kmerdata=kmer[,1:84]
  kmermeta=kmer[,85:89]
  
  kmer_dist=distance(kmerdata, method = "euclidean",use.row.names = TRUE)
  cut_off=median(kmer_dist,diag=FALSE)
  #cut_off=0.01
  hist(kmer_dist)
  
  t1=which(kmer_dist<cut_off)    #make those 1
  t2=which(kmer_dist>=cut_off)   #make those 0
  
  kmer.binary=kmer_dist #matrix(data = NA,nrow = dim(kmerdata)[1],ncol = dim(kmerdata)[1])
  kmer.binary[t1]=0
  kmer.binary[t2]=1
  warning('similarity value less than cutoff is converted to 1, NOTE this')
  rm(t1,t2)
  
  g1=graph_from_adjacency_matrix(kmer.binary)
  plot(g1)
  write_graph(g1,file=paste0(country,"_",month,"_network.txt"),format = "edgelist")

  return(g1)
  
}