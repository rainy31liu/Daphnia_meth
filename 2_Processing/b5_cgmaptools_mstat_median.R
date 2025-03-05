
setwd("/u/project/pellegrini/rainyliu/Daphnia")
library(dplyr)

########## new

contigs <- read.table("./contig_filter/contigs.csv", header = TRUE)
contigs <- contigs$Contig

mstat_new <- data.frame(contigs = contigs)
Cp <- c("CG", "CA", "CC", "CT")
for(i in 1:2){
  for(j in Cp){
    mstat_temp <- read.table(paste0("./cgmap_new_", j, "/S", i, ".filt.CGmap.gz"), header = FALSE,
                             sep = "\t")
    summary_table <- mstat_temp %>%
      group_by(V1) %>%
      summarize(Median_Methylation = median(V6, na.rm = TRUE))
    colnames(summary_table) <- c("contigs", paste0("S", i, "_", j))
    mstat_new <- merge(x = mstat_new, y = summary_table, by = "contigs")
  }
}

mstat_new$mean_CG <- rowMeans(cbind(mstat_new$S1_CG, mstat_new$S2_CG), na.rm = TRUE)
mstat_new$mean_CA <- rowMeans(cbind(mstat_new$S1_CA, mstat_new$S2_CA), na.rm = TRUE)
mstat_new$mean_CC <- rowMeans(cbind(mstat_new$S1_CC, mstat_new$S2_CC), na.rm = TRUE)
mstat_new$mean_CT <- rowMeans(cbind(mstat_new$S1_CT, mstat_new$S2_CT), na.rm = TRUE)

write.table(mstat_new, "./mstat_new/filt.mstat.median.txt", col.names = TRUE, row.names = FALSE, sep = "\t", quote = FALSE)

