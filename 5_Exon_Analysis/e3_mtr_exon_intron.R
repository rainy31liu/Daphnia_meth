
library(dplyr)
library(data.table)
setwd("/u/project/pellegrini/rainyliu/Daphnia")

gtf <- read.table("./bed/Daphnia_annotation_rainyliu.gtf.txt",  sep = "\t")
# gtf_transcript <- subset(gtf, V3 == "transcript")

# mtr <- read.table("./mtr_new/S1.filt.mtr.txt", header = TRUE)
# mtr <- merge(mtr, gtf_transcript, by.x = c("chr","start","end","dir"), 
#              by.y = c("V1", "V4", "V5","V7"), all.x = TRUE)

gtf <- subset(gtf, V3 == "exon")
gtf <- gtf[order(gtf$V10, gtf$V5), ]

intron_df <- data.frame()

# Loop through each unique transcript (V10)
for (transcript in unique(gtf$V10)) {
  # Filter rows for the current transcript
  exon_rows <- gtf[gtf$V10 == transcript, ]
  
  # Identify intron start and end positions
  if (nrow(exon_rows) > 1){
    for (i in 1:(nrow(exon_rows) - 1)) {
      intron_start <- exon_rows$V5[i] + 1
      intron_end <- exon_rows$V4[i + 1] - 1
      
      # Create a new row for the intron
      intron_row <- exon_rows[i, ]  # Copy the first exon row as a template
      intron_row$V3 <- "intron"     # Set the feature type to "intron"
      intron_row$V4 <- intron_start  # Set the intron start position
      intron_row$V5 <- intron_end    # Set the intron end position
      
      # Append the intron row to the intron data frame
      intron_df <- rbind(intron_df, intron_row)
    }
  }
}

# Combine original data with intron rows and sort by V10 and V5
result_df <- rbind(gtf, intron_df)
result_df <- result_df[order(result_df$V10, result_df$V5), ]


write.table(result_df, "./mtr_exon_intron/annotation_exon_intron.gtf.txt",  sep = "\t", row.names = FALSE,
            quote = FALSE)

result_df <- result_df[,c("V1", "V4", "V5","V7")]
write.table(result_df, "./mtr_exon_intron/annotation_exon_intron.bed.txt",  sep = "\t", row.names = FALSE,
            quote = FALSE, col.names = FALSE)

########### after mtr

mtr <- read.table("./mtr_exon_intron/annotation_exon_intron.bed.S1.mtr.txt", sep = "\t")
mtr$V6 <- ifelse(is.na(mtr$V6), 0, mtr$V6)
mtr <- mtr[,c("V1","V2","V3","V6")]

gtf <- read.table("./mtr_exon_intron/annotation_exon_intron.gtf.txt",  sep = "\t", header = TRUE)
gtf <- gtf[,c("V1","V3","V4","V5","V7")]

## check
all(mtr$V1 == gtf$V1)
all(mtr$V2 == gtf$V4)
all(mtr$V3 == gtf$V5)

mtr$V4 <- gtf$V3
mtr$V7 <- gtf$V7

exon <- mtr[mtr$V4 == "exon", "V6"]
write.table(as.data.frame(exon), "./mtr_exon_intron/mtr_exon.txt", quote = FALSE, row.names = FALSE,
            col.names = FALSE)
intron <- mtr[mtr$V4 == "intron", "V6"]
write.table(as.data.frame(intron), "./mtr_exon_intron/mtr_intron.txt", quote = FALSE, row.names = FALSE,
            col.names = FALSE)
t.test(exon, intron)
# Welch Two Sample t-test
# data:  exon and intron
# t = 16.535, df = 704781, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   0.0008753903 0.0011108239
# sample estimates:
#   mean of x    mean of y 
# 0.0017011676 0.0007080605 

wilcox.test(exon, intron, alternative = "two.sided")
# Wilcoxon rank sum test with continuity correction
# data:  exon and intron
# W = 8.0629e+10, p-value < 2.2e-16
# alternative hypothesis: true location shift is not equal to 0

exon_m <- exon[exon != 0]
write.table(as.data.frame(exon_m), "./mtr_exon_intron/mtr_exon_m.txt", quote = FALSE, row.names = FALSE,
            col.names = FALSE)
intron_m <- intron[intron != 0]
write.table(as.data.frame(intron_m), "./mtr_exon_intron/mtr_inron_m.txt", quote = FALSE, row.names = FALSE,
            col.names = FALSE)
t.test(exon_m, intron_m)
# Welch Two Sample t-test
# data:  exon_m and intron_m
# t = 11.629, df = 13672, p-value < 2.2e-16
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   0.03107548 0.04367520
# sample estimates:
#   mean of x  mean of y 
# 0.08665029 0.04927495 

wilcox.test(exon_m, intron_m, alternative = "two.sided")
# Wilcoxon rank sum test with continuity correction
# data:  exon_m and intron_m
# W = 26355294, p-value < 2.2e-16
# alternative hypothesis: true location shift is not equal to 0
