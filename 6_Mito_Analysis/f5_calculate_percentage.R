
setwd("/u/project/pellegrini/rainyliu/Daphnia/mito_reads")

file <- read.table("S2.mito.normalized_as_scores.txt", header = FALSE)
unmapped <- read.table("S2.mito.unmapped_reads.txt", header = FALSE)

sum(file$V4 >= 0.9) / (nrow(file) + nrow(unmapped))
