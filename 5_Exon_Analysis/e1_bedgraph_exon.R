
library(dplyr)
library(data.table)
setwd("/u/project/pellegrini/rainyliu/Daphnia")

gtf <- read.table("./bed/Daphnia_annotation_rainyliu.gtf.txt",  sep = "\t")
gtf_transcript <- subset(gtf, V3 == "transcript")
gtf <- subset(gtf, V3 == "exon")

contig <- read.csv("./contig_filter/contigs.csv")
contig <- contig$Contig
gtf <- subset(gtf, V1 %in% contig)
gtf <- gtf[order(gtf$V1, gtf$V4),]

cgmap <- read.table("./cgmap_new_CG/S1.filt.CGmap.gz")
gene_name <- "snap_masked-falcon_000015F-processed-gene-12.68-mRNA-1"

gtf_exon <- gtf
gtf_sub <- subset(gtf_exon, V10 == gene_name)
gtf_sub <- gtf_sub[,c("V1", "V4", "V5")]
gtf_sub$val <- 1
write.table(gtf_sub, "./bedgraph/exon/gene.4.exon.bedgraph.txt",
            col.names = FALSE, row.names = FALSE, sep = "\t", quote = FALSE)

gtf_transcript_sub <- subset(gtf_transcript, V10 == gene_name)
gtf_transcript_sub <- data.frame(chr = gtf_transcript_sub$V1, loc_1 = c(gtf_transcript_sub$V4, gtf_transcript_sub$V5),
                                 loc_2 = c(gtf_transcript_sub$V4, gtf_transcript_sub$V5),
                                 label = c("TES","TSS"))
write.table(gtf_transcript_sub, "./bedgraph/exon/gene.4.transcript_loc.txt",
            col.names = FALSE, row.names = FALSE, sep = "\t", quote = FALSE)


cgmap_sub <- subset(cgmap, V3 >  gtf_transcript_sub$loc_1[1] - 500 & V3 < gtf_transcript_sub$loc_1[2] + 500 & V1 %in% gtf_transcript_sub$chr)
cgmap_sub$V6 <- ifelse(cgmap_sub$V2 == "G", -cgmap_sub$V6, cgmap_sub$V6)
cgmap_sub <- cgmap_sub[,c("V1","V3","V3","V6")]
write.table(cgmap_sub, "./bedgraph/exon/gene.4.transcript.bedgraph.txt",
            col.names = FALSE, row.names = FALSE, sep = "\t", quote = FALSE)
