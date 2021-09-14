library(philentropy)
library(igraph)
library(NetworkSim)

gen_keywrds=function(abs_data)
{
  #given extracted keywords it will create a network year-wise
  keywrds={""}
  null_count={}
  for (i in 1:length(abs_data))
  {
    if ((is.na(abs_data[[i]][[3]])) || (length(abs_data[[i]][[3]])==0))
    {
      null_count=cbind(null_count,i)
    #  print(i)
    } else
    {
      for (j in 1:length(abs_data[[i]][[3]]))
      {
        keywrds=c(keywrds,abs_data[[i]][[3]][j])
      }
    }
  }
  keywrds=keywrds[-1]
  keywrds=unique(keywrds)
  return(keywrds)
}

gen_network=function(abs_data)
{
  keywrds=gen_keywrds(abs_data)
  sim_mat=matrix(data = 0,nrow = length(abs_data),ncol = length(keywrds))
  ### get the rownames for abstract data
  rname={}
  for (i in 1:length(abs_data))
  {
    tmp=which(keywrds %in% abs_data[[i]][[3]])
    sim_mat[i,tmp]=1
    rname=c(rname,abs_data[[i]][[1]])
  }
  rownames(sim_mat)=rname
  net1=1-distance(sim_mat,method = "jaccard")
  rownames(net1)=rname
  colnames(net1)=rname
  warning('1-distance used, hence its a similarity matrix, max sim=1')
  #cut_off=sort(net1, decreasing = TRUE)[round(length(abs_data)/10)]
  cut_off=quantile(net1)[4]
  #net1[which(net1>=cut_off)]=0
  net1[which(net1<cut_off)]=0
  
  return(net1)
  #g1=graph_from_adjacency_matrix(net1)
  #return(g1)
}

find_GDD=function(net1,net2)
{
  #return (10)
  library(NetworkSim)
  return(netGDD(net1, net2, mean = "arithmetic"))
}

main=function(abstracts)
{
  yrs=c("1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003")
  all_networks={}
  for (i in 1:length(abstracts))
  {
    #all_networks[[i]][1]=yrs[i]
    all_networks[[i]]=gen_network(abstracts[[i]])
    print(i)
  }
  return(all_networks)
}

find_gdd_mat=function(all_networks)
{
  gdd_mat=foreach(i=1:12, .combine = 'rbind') %dopar% {
    find_GDD(all_networks[[1]],all_networks[[i]])
  }
}
