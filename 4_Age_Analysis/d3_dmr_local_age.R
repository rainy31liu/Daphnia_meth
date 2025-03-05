
library(tidyr)
library(dplyr)
library(GenomicRanges)
setwd("/u/project/pellegrini/rainyliu/Daphnia")

cgmatrix <- read.table("./dmr_age/CGmatrix.age.filt.10x.1_sample.xD7.txt", header = TRUE, sep = "\t")

mature.young <- cgmatrix[,c(1,4:10,15:18)]
mature.young <- mature.young[rowSums(is.na(mature.young[2:12])) == 0,]
mature.young <- mature.young %>%
  separate(Site, into = c("chr", "pos"), sep = ":")
colnames(mature.young)[3:13] <- c(paste("young", 1:4, sep = "_"), paste("mature", 1:7, sep = "_"))
write.table(mature.young, "./dmr_age/mature.young.txt", row.names = FALSE, quote = FALSE, sep = "\t")

old.young <- cgmatrix[,c(1,4:7,11:14)]
old.young <- old.young[rowSums(is.na(old.young[2:8])) == 0,]
old.young <- old.young %>%
  separate(Site, into = c("chr", "pos"), sep = ":")
colnames(old.young)[3:10] <- c(paste("young", 1:4, sep = "_"), paste("old", 1:4, sep = "_"))
write.table(old.young, "./dmr_age/old.young.txt", row.names = FALSE, quote = FALSE, sep = "\t")

old.mature <- cgmatrix[,c(1,8:10,15:18, 11:14)]
old.mature <- old.mature[rowSums(is.na(old.mature[2:12])) == 0,]
old.mature <- old.mature %>%
  separate(Site, into = c("chr", "pos"), sep = ":")
colnames(old.mature)[3:13] <- c(paste("mature", 1:7, sep = "_"), paste("old", 1:4, sep = "_"))
write.table(old.mature, "./dmr_age/old.mature.txt", row.names = FALSE, quote = FALSE, sep = "\t")

#######################

mature.young <- read.table("./dmr_age/mature.young.result.txt", header = TRUE, sep = "\t")
mature.young <- mature.young[order(mature.young$p..MWU.),]
mature.young <- subset(mature.young, p..MWU. < 0.05 & CpGs >= 10)
mature.young$source <- "mature.young"
mature.young$loc <- paste0(mature.young$chr, ":", mature.young$start, "-", mature.young$stop)

old.mature <- read.table("./dmr_age/old.mature.result.txt", header = TRUE, sep = "\t")
old.mature <- old.mature[order(old.mature$p..MWU.),]
old.mature <- subset(old.mature, p..MWU. < 0.05 & CpGs >= 10)
old.mature$source <- "old.mature"
old.mature$loc <- paste0(old.mature$chr, ":", old.mature$start, "-", old.mature$stop)

old.young <- read.table("./dmr_age/old.young.result.txt", header = TRUE, sep = "\t")
old.young <- old.young[order(old.young$p..MWU.),]
old.young <- subset(old.young, p..MWU. < 0.05 & CpGs >= 10)
old.young$loc <- paste0(old.young$chr, ":", old.young$start, "-", old.young$stop)

#######################

gtf <- read.table("./bed/Daphnia_annotation_rainyliu.gtf.txt",  sep = "\t")
gtf <- subset(gtf, V3 == "transcript")
gtf <- gtf[, c(1,4,5,7,10)]
gtf <- unique(gtf)

results_gene <- merge(x = results_df, y = gtf, by = "geneID", all.x = TRUE)

match_human <- read.csv("./gaa/proteins.job10129379.genesym.defs.HUMAN.csv", header = FALSE)
results_gene <- merge(x = results_gene, y = match_human, by.x = "V10", by.y = "V1", all.x = TRUE)
write.table(results_gene, "./mfg_age/dap_results_gene.txt", sep = "\t", row.names = FALSE)

#######################

gr1 <- GRanges(
  seqnames = mature.young$chr,
  ranges = IRanges(start = mature.young$start, end = mature.young$stop),
  mean_diff = mature.young$mean_diff,
  CpGs = mature.young$CpGs,
  p.MWU = mature.young$p..MWU.
)
gr2 <- GRanges(
  seqnames = old.mature$chr,
  ranges = IRanges(start = old.mature$start, end = old.mature$stop),
  mean_diff = old.mature$mean_diff,
  CpGs = old.mature$CpGs,
  p.MWU = old.mature$p..MWU.
)
overlaps <- findOverlaps(gr2, gr1, type = "any")
mature.young_df <- as.data.frame(gr2[queryHits(overlaps)]) %>%
  bind_cols(as.data.frame(gr1[subjectHits(overlaps)]))
overlaps <- findOverlaps(gr1, gr2, type = "any")
old.mature_df <- as.data.frame(gr1[queryHits(overlaps)]) %>%
  bind_cols(as.data.frame(gr2[subjectHits(overlaps)]))


gr2 <- GRanges(
  seqnames = gtf$V1,
  ranges = IRanges(start = gtf$V4, end = gtf$V5),
  strand = gtf$V7,
  transcript_id = gtf$V10
)
overlaps <- findOverlaps(gr2, gr1, type = "any")
mature.young_df <- as.data.frame(gr2[queryHits(overlaps)]) %>%
  bind_cols(as.data.frame(gr1[subjectHits(overlaps)]))
mature.young_df$source <- "mature.young"

## mature old
gr1 <- GRanges(
  seqnames = old.mature$chr,
  ranges = IRanges(start = old.mature$start, end = old.mature$stop),
  mean_diff = old.mature$mean_diff,
  CpGs = old.mature$CpGs,
  p.MWU = old.mature$p..MWU.
)
overlaps <- findOverlaps(gr2, gr1, type = "any")
old.mature_df <- as.data.frame(gr2[queryHits(overlaps)]) %>%
  bind_cols(as.data.frame(gr1[subjectHits(overlaps)]))
old.mature_df$source <- "old.mature"

mature.young_df_new <- mature.young_df[mature.young_df$transcript_id %in% old.mature_df$transcript_id,]
old.mature_df_new <- old.mature_df[old.mature_df$transcript_id %in% mature.young_df$transcript_id,]

write.table(mature.young_df_new, "./dmr_age/mature.young_df_new.txt", row.names = FALSE, sep = "\t")
write.table(old.mature_df_new, "./dmr_age/old.mature_df_new.txt", row.names = FALSE, sep = "\t")

#######################
library(data.table)

cgmatrix <- read.table("./cgmatrix_age/CGmatrix.age.filt.10x.80.xD7.imputed.txt", header = TRUE, sep = "\t")

setDT(cgmatrix)
non_constant_rows <- cgmatrix[, .SD[apply(.SD, 1, function(x) length(unique(x)) > 1)], .SDcols = 2:18]

cgmatrix[, variability := apply(.SD, 1, sd), .SDcols = 2:18]
top_variable_sites <- cgmatrix[order(-variability)][1:(.N/2)]
top_variable_sites$variability <- NULL

write.table(top_variable_sites, "./cgmatrix_age/CGmatrix.age.filt.10x.80.xD7.imputed.50%var.txt", row.names = FALSE,
            sep = "\t", quote = FALSE)




