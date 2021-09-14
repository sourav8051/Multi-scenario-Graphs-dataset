

folder_names=c("1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003")

extract_abs=function(folder_names)
{ 
  setwd("/KDDCup_dataset")  #go to the dataset directory
  library(udpipe)
  tagger <- udpipe_download_model("english")
  abstracts=list()
  for (i in 1:length(folder_names))
  { 
    cur_dir=getwd()
    path=paste0("abstracts/",folder_names[i])
    files=list.files(path=path,pattern = ".abs")
    setwd(path)
    tmp=list()
    for (j in 1:length(files))
    {
      raw_txt=(read.delim(files[j]))
      delimeter=which(raw_txt=="\\\\")  #get the abstract part only as per file structure
      print(paste0(folder_names[i],":",j))
      if (length(delimeter)==3)
      {
        abs=toString(raw_txt[[1]][(delimeter[2]+1):(delimeter[3]-1)])
        keys=keywrd_extraction(abs,tagger)
        tmp[[j]]=list(files[j],abs,keys)
        
      } else
      {
        tmp[[j]]=list(files[j],abs,NA)
        print(cbind(i,j,"NA"))
        next
      }
    }
    abstracts[[i]]=tmp
    setwd(cur_dir)
    saveRDS(tmp,file = paste0(folder_names[i],".RDS"))
  }
  return(abstracts)
}

keywrd_extraction=function(raw_txt,tagger)
{
  tagger <- udpipe_load_model(tagger$file_model)
  txtdata <- udpipe_annotate(tagger, raw_txt)
  txtdata <- as.data.frame(txtdata)
  
  txtdata=txtdata[, c("sentence_id", "lemma", "upos")]
  
  terminology <- subset(txtdata, upos %in% c("NOUN"))
  terminology <- terminology[, c("sentence_id", "lemma")]
  head(terminology)
  
  return(terminology$lemma)
}

