
setwd("/u/project/pellegrini/rainyliu/Daphnia")
sample <- 1

## New Sample
data <- read.table(paste0("./cgmap_new/S", sample, ".filt.CGmap.gz"), sep = "\t", header = FALSE)
data <- subset(data, V1 == "MH683648.1")

summary <- data.frame(matrix(nrow = 8, ncol = 8))
colnames(summary) <- c(paste(c("CA", "CC", "CG", "CT"), "freq", sep = "."),
                       paste(c("CA", "CC", "CG", "CT"), "count", sep = "."))
rownames(summary) <- c("[0.00]", "(0.00,0.05]", "(0.05,0.10]", "(0.10,0.20]",
                       "(0.20,0.40]", "(0.40,0.60]", "(0.60,0.80]", "(0.80,1]")

for(i in 1:4){
  type <- c("CA", "CC", "CG", "CT")
  data_sub <- subset(data, V5 == type[i])
  num <- nrow(data_sub)
  summary[1, i] <- sum(data_sub$V6 == 0)/num
  summary[2, i] <- sum(data_sub$V6 > 0 & data_sub$V6 <= 0.05)/num
  summary[3, i] <- sum(data_sub$V6 > 0.05 & data_sub$V6 <= 0.1)/num
  summary[4, i] <- sum(data_sub$V6 > 0.1 & data_sub$V6 <= 0.2)/num
  summary[5, i] <- sum(data_sub$V6 > 0.2 & data_sub$V6 <= 0.4)/num
  summary[6, i] <- sum(data_sub$V6 > 0.4 & data_sub$V6 <= 0.6)/num
  summary[7, i] <- sum(data_sub$V6 > 0.6 & data_sub$V6 <= 0.8)/num
  summary[8, i] <- sum(data_sub$V6 > 0.8)/num
  
  summary[1, i+4] <- sum(data_sub$V6 == 0)
  summary[2, i+4] <- sum(data_sub$V6 > 0 & data_sub$V6 <= 0.05)
  summary[3, i+4] <- sum(data_sub$V6 > 0.05 & data_sub$V6 <= 0.1)
  summary[4, i+4] <- sum(data_sub$V6 > 0.1 & data_sub$V6 <= 0.2)
  summary[5, i+4] <- sum(data_sub$V6 > 0.2 & data_sub$V6 <= 0.4)
  summary[6, i+4] <- sum(data_sub$V6 > 0.4 & data_sub$V6 <= 0.6)
  summary[7, i+4] <- sum(data_sub$V6 > 0.6 & data_sub$V6 <= 0.8)
  summary[8, i+4] <- sum(data_sub$V6 > 0.8)
}

write.table(summary, paste0("./mstat_new/S", sample, ".summary.mito.txt"), sep = "\t", quote = FALSE,
            row.names = TRUE)

## Old Sample
summary <- data.frame(matrix(nrow = 8, ncol = 15))
colnames(summary) <- paste0("D", c(1:6,8:16))
rownames(summary) <- c("[0.00]", "(0.00,0.20]",
                       "(0.20,0.40]", "(0.40,0.60]", "(0.60,0.80]", "(0.80,1]",
                       "median", "mean")
for(i in colnames(summary)){
  print(i)
  data <- read.table(paste0("./cgmap_old/", i, ".filt.CGmap.gz"), sep = "\t", header = FALSE)
  data <- subset(data, V1 != "MH683648.1")
  data <- subset(data, V5 == "CG")
  num <- nrow(data)
  summary[1, i] <- sum(data$V6 == 0)/num
  summary[2, i] <- sum(data$V6 > 0   & data$V6 <= 0.2)/num
  summary[3, i] <- sum(data$V6 > 0.2 & data$V6 <= 0.4)/num
  summary[4, i] <- sum(data$V6 > 0.4 & data$V6 <= 0.6)/num
  summary[5, i] <- sum(data$V6 > 0.6 & data$V6 <= 0.8)/num
  summary[6, i] <- sum(data$V6 > 0.8)/num
  summary[7, i] <- median(data$V6)
  summary[8, i] <- mean(data$V6)  
  
  summary[1, i+4] <- sum(data_sub$V6 == 0)
  summary[2, i+4] <- sum(data_sub$V6 > 0 & data_sub$V6 <= 0.05)
  summary[3, i+4] <- sum(data_sub$V6 > 0.05 & data_sub$V6 <= 0.1)
  summary[4, i+4] <- sum(data_sub$V6 > 0.1 & data_sub$V6 <= 0.2)
  summary[5, i+4] <- sum(data_sub$V6 > 0.2 & data_sub$V6 <= 0.4)
  summary[6, i+4] <- sum(data_sub$V6 > 0.4 & data_sub$V6 <= 0.6)
  summary[7, i+4] <- sum(data_sub$V6 > 0.6 & data_sub$V6 <= 0.8)
  summary[8, i+4] <- sum(data_sub$V6 > 0.8)
}

summary$young <- rowMeans(summary[,1:4])
summary$mature <- rowMeans(summary[,c(5:7, 12:15)])
summary$old <- rowMeans(summary[,8:11])
write.table(summary, "./mstat_old/summary.nuclear.txt", sep = "\t", quote = FALSE,
            row.names = TRUE)

