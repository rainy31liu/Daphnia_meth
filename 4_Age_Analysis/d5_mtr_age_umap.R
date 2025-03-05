
library(tidyr)
library(dplyr)
library(ggplot2)
set.seed(123)
setwd("/u/project/pellegrini/rainyliu/Daphnia")

####################### 
## create a meta file

gtf <- read.table("./bed/Daphnia_annotation_rainyliu.gtf.txt",  sep = "\t")
gtf <- subset(gtf, V3 == "transcript")
gtf <- gtf[, c("V1","V4","V5","V7")]
gtf <- unique(gtf)

for(i in 1:2){
  file_name <- paste0("./mtr_new/S", i, ".filt.mtr.txt")
  file_temp <- read.table(file_name, header = TRUE)
  file_temp <- file_temp[,c("chr","start","end","dir","per_m_1")]
  colnames(file_temp)[5] <- paste0("S",i)
  gtf <- merge(x = gtf, y = file_temp, 
               by.x = c("V1","V4","V5","V7"), by.y = c("chr","start","end","dir"), 
               all.x = TRUE)
}

for(i in c(1:6,8:16)){
  file_name <- paste0("./mtr_old/D", i, ".filt.mtr.txt")
  file_temp <- read.table(file_name, header = TRUE)
  file_temp <- file_temp[,c("chr","start","end","dir","per_m_1")]
  colnames(file_temp)[5] <- paste0("D",i)
  gtf <- merge(x = gtf, y = file_temp, 
               by.x = c("V1","V4","V5","V7"), by.y = c("chr","start","end","dir"), 
               all.x = TRUE)
}

colnames(gtf)[1:4] <- c("chr","start","end","dir")
write.csv(gtf, "./cgmatrix_age/cgmatrix_age_gene_meth_sum.txt", row.names = FALSE)

####################### 
## calculate the percentage of non-zero values

numeric_columns <- gtf[, 5:ncol(gtf)]
percent_nonzero <- apply(numeric_columns, 1, function(row) {
  mean(row > 0.1) * 100
})
gtf$percent_nonzero <- percent_nonzero


####################### 
## filter methylation of genes in 80% samples

gtf <- subset(gtf, percent_nonzero > 80)

####################### 
## filter cgmatrix sites

gtf_pos <- unlist(
  apply(gtf, 1, function(row) {
    chr <- row["chr"]
    start <- as.numeric(row["start"])
    end <- as.numeric(row["end"])
    paste0(chr, ":", seq(start, end))
  })
)
gtf_pos <- unname(gtf_pos)

cgmatrix <- read.table("./cgmatrix_age/CGmatrix.age.filt.10x.80.xD7.txt", header = TRUE)

cgmatrix_filtered <- subset(cgmatrix, Site %in% gtf_pos)
write.table(cgmatrix_filtered, "CGmatrix.age.filt.10x.80.xD7.filtered_gene_new.txt", 
            row.names = FALSE, quote = FALSE, sep = "\t")

####################### 
## make UMAP (used BSBolt for imputation)

cgmatrix <- read.table("./cgmatrix_age/CGmatrix.age.filt.10x.80.xD7.filtered_gene.imputed.txt", header = TRUE, row.names = 1)
cgmatrix <- cgmatrix[rowSums(cgmatrix) != 0, ]
cgmatrix <- t(cgmatrix)

## UMAP
umap_result <- umap::umap(cgmatrix)
umap_df <- as.data.frame(umap_result$layout)
colnames(umap_df) <- c("UMAP1", "UMAP2")
umap_df$Sample <- rownames(cgmatrix)
umap_df$Sample <- sub("\\..*", "", umap_df$Sample)
umap_df$Group <- c(rep("Mature-old", 2), rep("Young", 4), rep("Mature", 3),
                   rep("Old", 4), rep("Mature", 4))
umap_df$Group <- factor(umap_df$Group, levels = c("Young", "Mature", "Mature-old", "Old"))
ggplot(umap_df, aes(x = UMAP1, y = UMAP2, label = Sample, color = Group)) +
  geom_point(size = 3) +
  geom_text(aes(label = Sample), hjust = 1.5, vjust = 1.5, size = 2.5) +
  xlim(-1.5, 1.5) +
  ylim(-2.7, 2.5) +
  scale_color_manual(values = c("Young" = "#1F77B4", "Mature" = "#CC5500", "Mature-old" = "#9467BD", "Old" = "#2CA02C")) +
  labs(title = "UMAP of Filtered CpG Sites", x = "UMAP 1", y = "UMAP 2") +
  theme_minimal() + 
  theme(
    plot.title = element_text(hjust = 0.5),  # Center the title
    panel.border = element_rect(color = "black", fill = NA, linewidth = 1)  # Add a black border
  )
ggsave("./cgmatrix_age/CGmatrix.age.filt.10x.80.xD7.filtered_gene.UMAP.tiff", width = 5, height = 4, dpi = 300)




