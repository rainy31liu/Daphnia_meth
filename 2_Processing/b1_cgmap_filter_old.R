library(utils)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1) {
  stop("Please provide one argument.")
}

i <- args[1]
print(i)

setwd("/u/project/pellegrini/rainyliu/Daphnia")
best_contigs <- read.table("./contig_filter/contigs.csv", header = TRUE)
best_contigs <- as.vector(best_contigs$Contig)

file_path <- paste0("./cgmap_old/D", i, ".CGmap.gz")
gz_file <- gzfile(file_path, "rt")
data <- read.table(gz_file, header = FALSE, sep = "\t")
data_filtered <- data[data$V1 %in% best_contigs, ]
close(gz_file)
  
file_path <- paste0("./cgmap_old/D", i, ".filt.CGmap.gz")
gz_file <- gzfile(file_path, "wt")
write.table(data_filtered, gz_file, sep = "\t", row.names = FALSE, 
              col.names = FALSE, quote = FALSE)
close(gz_file)
