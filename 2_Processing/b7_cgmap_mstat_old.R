
setwd("/u/project/pellegrini/rainyliu/Daphnia")

for (i in c("CA", "CC", "CG", "CT")){
  file_path <- paste0("./cgmatrix_old/CGmatrix.old.10x.100.", i, ".txt")
  temp_data <- read.table(file_path, header = TRUE, sep = "\t")
  temp_data$mean <- rowMeans(temp_data[, grep("^D", colnames(temp_data))], na.rm = TRUE)
  temp_data <- temp_data[, c("Site","mean")]
  temp_data$Site_prefix <- sapply(strsplit(as.character(temp_data$Site), ":"), `[`, 1)
  nuclear <- subset(temp_data, Site_prefix != "MH683648.1")
  nuclear$Site_prefix <- NULL
  write.table(nuclear, paste0("./mstat_old/CGmatrix.old.10x.100.", i, ".nuclear.txt"),
              row.names = FALSE, quote = FALSE)
  mito <- subset(temp_data, Site_prefix == "MH683648.1")
  mito$Site_prefix <- NULL
  write.table(mito, paste0("./mstat_old/CGmatrix.old.10x.100.", i, ".mito.txt"), sep = "\t",
              row.names = FALSE, quote = FALSE)
}
