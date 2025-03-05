
setwd("/u/project/pellegrini/rainyliu/Daphnia")

## New Sample
mstat_new <- list()
for(i in 1:2){
  mstat_temp <- read.table(paste0("./mstat_new/S", i, ".filt.mstat.txt"), header = TRUE,
                           sep = "\t")
  mstat_temp <- mstat_temp[-(1:10), c(2,4,7,8,9)]
  colnames(mstat_temp)[2:5] <- paste0(colnames(mstat_temp)[2:5], ".", i)
  mstat_new[[i]] <- mstat_temp
}

Cp <- c("CG", "CA", "CC", "CT")
for(j in 1:4){
  name <- Cp[j]
  mstat_new[[name]] <- merge(x = mstat_new[[1]][, c(1, j+1)], y = mstat_new[[2]][, c(1, j+1)],
                          by = "context")
  mstat_new[[name]]$avg <- rowMeans(mstat_new[[name]][2:3], na.rm = TRUE)
  write.table(mstat_new[[name]], paste0("./mstat_new/", name, ".sum.txt"), row.names = FALSE,
              sep = "\t", quote = FALSE)
}

## Old Sample
mstat_old <- list()
for(i in 1:16){
  mstat_temp <- read.table(paste0("./mstat_old/D", i, ".filt.mstat.txt"), header = TRUE,
                           sep = "\t")
  mstat_temp <- mstat_temp[-(1:10), c(2,4,7,8,9)]
  colnames(mstat_temp)[2:5] <- paste0(colnames(mstat_temp)[2:5], ".", i)
  mstat_old[[i]] <- mstat_temp
}

Cp <- c("CG", "CA", "CC", "CT")
for(j in 1:4){
  name <- Cp[j]
  merged_df <- mstat_old[[1]][, c(1, j+1)]
  for(i in 2:16){
    merged_df <- merge(x = merged_df, y = mstat_old[[i]][, c(1, j+1)], 
                       by = "context", 
                       all = TRUE)
  }
  merged_df$avg <- rowMeans(merged_df[ ,-1], na.rm = TRUE)
  write.table(merged_df, paste0("./mstat_old/", name, ".sum.txt"), 
              row.names = FALSE, sep = "\t", quote = FALSE)
}
