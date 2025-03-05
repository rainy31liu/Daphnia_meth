
setwd("/u/project/pellegrini/rainyliu/Daphnia")

for(i in 1:2){
  print(i)
  data <- read.table(paste0("./cgmap_new/S", i, ".filt.CGmap.gz"), header = FALSE, 
                     sep = "\t")
  for(j in c("CA", "CC", "CG", "CT")){
    sub_data <- subset(data, V5 == j)
    gz_file <- gzfile(paste0("./cgmap_new_", j, "/S", i, ".filt.CGmap.gz"), "w")
    write.table(sub_data, gz_file, quote = FALSE, col.names = FALSE, row.names = FALSE, sep = "\t")
    close(gz_file)
    rm(sub_data)
  }
}


