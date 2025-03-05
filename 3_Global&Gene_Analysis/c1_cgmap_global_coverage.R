
setwd("/u/project/pellegrini/rainyliu/Daphnia")

summary <- data.frame(matrix(nrow = 17, ncol = 8))
colnames(summary) <- c("Min","1st Qu.","Median","Mean","3rd Qu.", "90 perc.", "99 perc.","Max.")
rownames(summary) <- c("S1","S2", paste0("D",c(1:6, 8:16)))

for (sample in 1:2) {
  data <- read.table(paste0("./cgmap_new/S", sample, ".filt.CGmap.gz"), sep = "\t", header = FALSE)
  data <- subset(data, V1 != "MH683648.1")
  
  # Compute summary statistics
  stats <- summary(data$V8)
  perc_90 <- quantile(data$V8, 0.90, na.rm = TRUE)  # Compute 90th percentile
  perc_99 <- quantile(data$V8, 0.99, na.rm = TRUE)
  
  # Store values in the dataframe
  summary[paste0("S", sample), ] <- c(stats["Min."], stats["1st Qu."], stats["Median"], 
                                      mean(data$V8, na.rm = TRUE), stats["3rd Qu."], perc_90, perc_99, stats["Max."])
  
  print(sample)
}

for (sample in c(1:6, 8:16)) {
  data <- read.table(paste0("./cgmap_old/D", sample, ".filt.CGmap.gz"), sep = "\t", header = FALSE)
  data <- subset(data, V1 != "MH683648.1")
  
  # Compute summary statistics
  stats <- summary(data$V8)
  perc_90 <- quantile(data$V8, 0.90, na.rm = TRUE)  # Compute 90th percentile
  perc_99 <- quantile(data$V8, 0.99, na.rm = TRUE)
  
  # Store values in the dataframe
  summary[paste0("D", sample), ] <- c(stats["Min."], stats["1st Qu."], stats["Median"], 
                                      mean(data$V8, na.rm = TRUE), stats["3rd Qu."], perc_90, perc_99, stats["Max."])
  
  print(sample)
}

write.table(summary, "./coverage/summary.txt", row.names = TRUE, sep = "\t")
