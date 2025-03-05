
library(dplyr)
library(data.table)
setwd("/u/project/pellegrini/rainyliu/Daphnia")

### before running mtr code
gtf <- read.table("./bed/Daphnia_annotation_rainyliu.gtf.txt",  sep = "\t")
gtf <- subset(gtf, V3 == "exon")
gtf$V4 <- ifelse(gtf$V7 == "-", -gtf$V4, gtf$V4)

gtf_exon <- gtf %>%
  group_by(V10) %>%
  slice_min(V4, n = 1) %>%
  ungroup()
gtf <- anti_join(gtf, gtf_exon, by = c("V1", "V4", "V5", "V10"))

gtf_exon <- gtf %>%
  group_by(V10) %>%
  slice_min(V4, n = 1) %>%
  ungroup()
gtf_exon$V4 <- ifelse(gtf_exon$V7 == "-", -gtf_exon$V4, gtf_exon$V4)
gtf_exon <- gtf_exon[,c("V1","V4","V5")]

contig <- read.csv("./contig_filter/contigs.csv")
contig <- contig$Contig
gtf_exon <- subset(gtf_exon, V1 %in% contig)
gtf_exon <- gtf_exon[order(gtf_exon$V1, gtf_exon$V4),]
gtf_exon <- unique(gtf_exon)
write.table(gtf_exon, "./mfg_exon_2/exon_2.bed.txt", row.names = FALSE, col.names = FALSE, 
            sep = "\t", quote = FALSE)

# cgmap <- read.table("./cgmap_new_CG/S2.filt.CGmap.gz")
# cgmap <- cgmap[order(cgmap$V1, cgmap$V3),]
# write.table(cgmap, gzfile("./cgmap_new_CG/S2.filt.sort.CGmap.gz"), sep = "\t", 
#             row.names = FALSE, col.names = FALSE, quote = FALSE)

### after running mtr code

mtr <- read.table("./mfg_exon_2/exon_2.S1.mtr.txt")
mtr$V6 <- ifelse(is.na(mtr$V6), 0, mtr$V6)
mtr <- mtr[,c("V1","V2","V3","V6")]

gtf <- read.table("./bed/Daphnia_annotation_rainyliu.gtf.txt",  sep = "\t")
gtf <- subset(gtf, V3 == "exon")
gtf <- gtf[, c("V1","V4","V5","V7")]
gtf <- unique(gtf)
mtr <- merge(gtf, mtr, by.x = c("V1","V4","V5"), by.y = c("V1","V2","V3"), all.y = TRUE)

mtr <- mtr %>%
  mutate(
    temp = V4,
    V4 = ifelse(V7 == "-", V5, V4),
    V5 = ifelse(V7 == "-", temp, V5)
  ) %>%
  select(-temp)
mtr <- mtr[order(mtr$V6, decreasing = TRUE),]

n <- 10
mtr.TSS <- mtr
mtr.TSS$V5 <- mtr.TSS$V4
mtr.TSS$V6 <- NULL
mtr.TSS <- split(mtr.TSS, cut(seq(nrow(mtr.TSS)), n, labels = FALSE))
for (j in seq_along(mtr.TSS)) {
  write.table(mtr.TSS[[j]], paste0("./mfg_exon_2/tss_bed/S1.exon2.mtr.", j, ".txt"),
              row.names = FALSE, col.names = FALSE, sep = "\t", quote = FALSE)
}





