
setwd("/u/project/pellegrini/rainyliu/Daphnia")
library(dplyr)
library(data.table)

################################################################################
################## convert gtf to bed file #####################################
################################################################################

gtf <- read.table("./bed/Daphnia_annotation_rainyliu.gtf.txt", sep = "\t", header = FALSE)
gtf <- subset(gtf, V3 == "transcript")
gtf <- gtf[, c(1,4,5,7)]

gtf <- unique(gtf)

write.table(gtf, "./bed/transcript.bed.txt", sep = "\t", quote = FALSE,
            row.names = FALSE, col.names = FALSE)

################################################################################
################## convert gtf to bed file #####################################
################################################################################

for (i in 1:2){
  print(paste0("Starting mtr order for sample S", i))
  gtf <- fread("./bed/transcript.bed.txt", header = FALSE, col.names = c("chr", "start", "end", "dir"))
  gtf[, `:=`(per_m_site = NA_real_, per_m_1 = NA_real_, per_m_2 = NA_real_, num_mc_site = NA_real_)]

  cgmap <- fread(paste0("./cgmap_new/S", i, ".filt.CGmap.gz"), header = FALSE)
  cgmap_filtered <- cgmap %>%
    filter(V5 == "CG")
  
  total_rows <- nrow(gtf)
  completed_rows <- 0
  
  gtf <- gtf %>%
    mutate(
      temp = start, 
      start = ifelse(dir == "-", end, start), 
      end = ifelse(dir == "-", temp, end) 
    ) %>%
    select(-temp)
  
  gtf <- gtf[, {
    sub_cgmap <- cgmap_filtered[V1 == chr & V3 >= start & V3 <= end]
    
    per_m_site <- ifelse(nrow(sub_cgmap) > 0, sum(sub_cgmap$V6 > 0) / nrow(sub_cgmap), 0) ## the number of sites that is methylated
    per_m_1 <- ifelse(nrow(sub_cgmap) > 0, mean(sub_cgmap$V6), 0) ## average methylation of all sites
    per_m_2 <- ifelse(nrow(sub_cgmap[sub_cgmap$V6 != 0]) > 0, mean(sub_cgmap$V6[sub_cgmap$V6 != 0]), 0) ## average methylation of methylated sites
    num_mc_site <- nrow(sub_cgmap)
    
    completed_rows <- completed_rows + 1
    complete_cases <- complete.cases(per_m_site, per_m_1, per_m_2)
    percentage_complete <- (completed_rows / total_rows) * 100
    if (completed_rows %% 100 == 0) {
      print(paste("Processed", completed_rows, "of", total_rows, "rows (", round(percentage_complete, 2), "% complete)", sep = " "))
    }
    
    list(
      per_m_site = per_m_site,
      per_m_1 = per_m_1,
      per_m_2 = per_m_2,
      num_mc_site = num_mc_site
    )
    
  }, by = .(chr, start, end, dir)]
  
  gtf <- gtf[order(-gtf$per_m_1), ]
  fwrite(gtf, paste0("./mtr_new/S", i, ".filt.new.mtr.txt"), sep = "\t")
  gtf <- gtf[, c(1:4)]
  
  gtf <- gtf %>%
    mutate(
      temp = start, 
      start = ifelse(dir == "-", end, start), 
      end = ifelse(dir == "-", temp, end) 
    ) %>%
    select(-temp)
  n <- 10
  gtf.gene <- split(gtf, cut(seq(nrow(gtf)), n, labels = FALSE))
  for (j in seq_along(gtf.gene)) {
    write.table(gtf.gene[[j]], paste0("./mtr_new/gene/S", i, ".mtr.", j, ".txt"),
                row.names = FALSE, col.names = FALSE, sep = "\t", quote = FALSE)
  }
  gtf.TSS <- gtf
  gtf.TSS$end <- gtf.TSS$start
  gtf.TSS <- split(gtf.TSS, cut(seq(nrow(gtf.TSS)), n, labels = FALSE))
  for (j in seq_along(gtf.TSS)) {
    write.table(gtf.TSS[[j]], paste0("./mtr_new/tss/S", i, ".mtr.", j, ".txt"),
                row.names = FALSE, col.names = FALSE, sep = "\t", quote = FALSE)
  }
  gtf.TES <- gtf
  gtf.TES$start <- gtf.TES$end
  gtf.TES <- split(gtf.TES, cut(seq(nrow(gtf.TES)), n, labels = FALSE))
  for (j in seq_along(gtf.TES)) {
    write.table(gtf.TES[[j]], paste0("./mtr_new/tes/S", i, ".mtr.", j, ".txt"),
                row.names = FALSE, col.names = FALSE, sep = "\t", quote = FALSE)
  }
  print(paste0("Finished mtr order for sample S", i))
}













