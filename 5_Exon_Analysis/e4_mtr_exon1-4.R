
library(dplyr)
library(data.table)
setwd("/u/project/pellegrini/rainyliu/Daphnia")

### before running mtr code

gtf <- read.table("./bed/Daphnia_annotation_rainyliu.gtf.txt",  sep = "\t")
gtf_transcript <- subset(gtf, V3 == "transcript")
gtf <- subset(gtf, V3 == "exon")
gtf <- gtf %>%
  group_by(V10) %>%
  filter(n() >= 5) %>%
  ungroup()
gtf_exon <- unique(gtf)
gtf_exon$V4 <- ifelse(gtf_exon$V7 == "-", -gtf_exon$V4, gtf_exon$V4)


# Get Exon 1
gtf_exon_1 <- gtf_exon %>%
  group_by(V10) %>%
  slice_min(V4, n = 1) %>%
  ungroup()
gtf_exon_remaining <- anti_join(gtf_exon, gtf_exon_1, by = c("V1", "V4", "V5", "V10"))
gtf_exon_1$V4 <- ifelse(gtf_exon_1$V7 == "-", -gtf_exon_1$V4, gtf_exon_1$V4)

# Get Exon 2
gtf_exon_2 <- gtf_exon_remaining %>%
  group_by(V10) %>%
  slice_min(V4, n = 1) %>%
  ungroup()
gtf_exon_remaining <- anti_join(gtf_exon_remaining, gtf_exon_2, by = c("V1", "V4", "V5", "V10"))
gtf_exon_2$V4 <- ifelse(gtf_exon_2$V7 == "-", -gtf_exon_2$V4, gtf_exon_2$V4)

# Get Exon 3 and Exon 4 in a similar way
gtf_exon_3 <- gtf_exon_remaining %>%
  group_by(V10) %>%
  slice_min(V4, n = 1) %>%
  ungroup()
gtf_exon_remaining <- anti_join(gtf_exon_remaining, gtf_exon_3, by = c("V1", "V4", "V5", "V10"))
gtf_exon_3$V4 <- ifelse(gtf_exon_3$V7 == "-", -gtf_exon_3$V4, gtf_exon_3$V4)

gtf_exon_4 <- gtf_exon_remaining %>%
  group_by(V10) %>%
  slice_min(V4, n = 1) %>%
  ungroup()
gtf_exon_4$V4 <- ifelse(gtf_exon_4$V7 == "-", -gtf_exon_4$V4, gtf_exon_4$V4)

contig <- read.csv("./contig_filter/contigs.csv")
contig <- contig$Contig
gtf_exon_1 <- subset(gtf_exon_1, V1 %in% contig)
gtf_exon_2 <- subset(gtf_exon_2, V1 %in% contig)
gtf_exon_3 <- subset(gtf_exon_3, V1 %in% contig)
gtf_exon_4 <- subset(gtf_exon_4, V1 %in% contig)
gtf_exon_1 <- gtf_exon_1[,c("V1","V4","V5","V7")]
gtf_exon_2 <- gtf_exon_2[,c("V1","V4","V5","V7")]
gtf_exon_3 <- gtf_exon_3[,c("V1","V4","V5","V7")]
gtf_exon_4 <- gtf_exon_4[,c("V1","V4","V5","V7")]

write.table(gtf_exon_1, "./mfg_exon/bed/exon_1.txt", row.names = FALSE, col.names = FALSE, 
            sep = "\t", quote = FALSE)
write.table(gtf_exon_2, "./mfg_exon/bed/exon_2.txt", row.names = FALSE, col.names = FALSE, 
            sep = "\t", quote = FALSE)
write.table(gtf_exon_3, "./mfg_exon/bed/exon_3.txt", row.names = FALSE, col.names = FALSE, 
            sep = "\t", quote = FALSE)
write.table(gtf_exon_4, "./mfg_exon/bed/exon_4.txt", row.names = FALSE, col.names = FALSE, 
            sep = "\t", quote = FALSE)

