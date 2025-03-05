
setwd("/u/project/pellegrini/rainyliu/Daphnia")

## Old Sample
data <- read.table(paste0("./cgmap_old/D", i, ".filt.CGmap.gz"), header = FALSE)
data_mito <- subset(data, V1 == "MH683648.1")

summary(data_mito[, "V6"])

for (x in c("CA", "CC", "CG", "CT")){
  data_mito_temp <- subset(data_mito, V5 == x)
  write.table(data_mito_temp, paste0("./cgmap_mito/", x, "/D", i, ".CGmap.tsv"), col.names = FALSE, row.names = FALSE,
              sep = "\t", quote = FALSE)
}

## New Sample
data <- read.table(paste0("./cgmap_new/S", i, ".filt.CGmap.gz"), header = FALSE)
data_mito <- subset(data, V1 == "MH683648.1")

summary(data_mito[, "V6"])

for (x in c("CA", "CC", "CG", "CT")){
  data_mito_temp <- subset(data_mito, V5 == x)
  write.table(data_mito_temp, paste0("./cgmap_mito/", x, "/S", i, ".CGmap.tsv"), col.names = FALSE, row.names = FALSE, 
              sep = "\t", quote = FALSE)
}
