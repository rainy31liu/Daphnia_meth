
library(Biostrings)
setwd("/u/project/pellegrini/rainyliu/Daphnia")

## count total number of cytosine dinucleotides in the genome file

fasta_file <- readDNAStringSet("./fasta/Daphnia_magna_3.0.fasta")
count_c <- sum(letterFrequency(fasta_file, "C")) + sum(letterFrequency(reverseComplement(fasta_file), "C"))
print(count_c)

count_cc_forward = sum(vcountPattern("CA", fasta_file)) + sum(vcountPattern("CC", fasta_file)) + 
  sum(vcountPattern("CG", fasta_file)) + sum(vcountPattern("CT", fasta_file))

count_cc_reverse = sum(vcountPattern("CA", reverseComplement(fasta_file))) + sum(vcountPattern("CC", reverseComplement(fasta_file))) +
  sum(vcountPattern("CG", reverseComplement(fasta_file))) + sum(vcountPattern("CT", reverseComplement(fasta_file)))

count_cc_forward + count_cc_reverse

## in the cgmap file after methylation calling
sum <- c()
for(i in c(1:6,8:16)){
  print(i)
  file_path <- paste0("./cgmap_old/D", i, ".filt.CGmap.gz")
  gz_file <- gzfile(file_path, "rt")
  data <- read.table(gz_file, header = FALSE, sep = "\t")
  close(gz_file)
  sum <- c(sum, nrow(data))
}
