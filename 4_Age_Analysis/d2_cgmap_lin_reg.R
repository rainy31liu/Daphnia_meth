
library(ggplot2)
library(dplyr)
library(broom)
setwd("/u/project/pellegrini/rainyliu/Daphnia")

summary <- data.frame()

data <- read.table("./mtr_new/S1.filt.mtr.txt", sep = "\t", header = TRUE)
data$geneID <- paste0(data$chr, ":", data$start, "-", data$end, "|", data$dir)
data$sample <- "S1"
data$age <- 45
summary <- rbind(summary, data[,c("geneID", "sample", "age", "per_m_1")])

data <- read.table("./mtr_new/S2.filt.mtr.txt", sep = "\t", header = TRUE)
data$geneID <- paste0(data$chr, ":", data$start, "-", data$end, "|", data$dir)
data$sample <- "S2"
data$age <- 45
summary <- rbind(summary, data[,c("geneID", "sample", "age", "per_m_1")])

for (sample in 1:4){
  data <- read.table(paste0("./mtr_old/D", sample, ".filt.mtr.txt"), sep = "\t", header = TRUE)
  data$geneID <- paste0(data$chr, ":", data$start, "-", data$end, "|", data$dir)
  data$sample <- paste0("D",sample)
  data$age <- 9
  summary <- rbind(summary, data[,c("geneID", "sample", "age", "per_m_1")])
}

for (sample in c(5,6,8)){
  data <- read.table(paste0("./mtr_old/D", sample, ".filt.mtr.txt"), sep = "\t", header = TRUE)
  data$geneID <- paste0(data$chr, ":", data$start, "-", data$end, "|", data$dir)
  data$sample <- paste0("D",sample)
  data$age <- 26
  summary <- rbind(summary, data[,c("geneID", "sample", "age", "per_m_1")])
}

for (sample in 9:10){
  data <- read.table(paste0("./mtr_old/D", sample, ".filt.mtr.txt"), sep = "\t", header = TRUE)
  data$geneID <- paste0(data$chr, ":", data$start, "-", data$end, "|", data$dir)
  data$sample <- paste0("D",sample)
  data$age <-58
  summary <- rbind(summary, data[,c("geneID", "sample", "age", "per_m_1")])
}

for (sample in 11:12){
  data <- read.table(paste0("./mtr_old/D", sample, ".filt.mtr.txt"), sep = "\t", header = TRUE)
  data$geneID <- paste0(data$chr, ":", data$start, "-", data$end, "|", data$dir)
  data$sample <- paste0("D",sample)
  data$age <- 52
  summary <- rbind(summary, data[,c("geneID", "sample", "age", "per_m_1")])
}

for (sample in 13:16){
  data <- read.table(paste0("./mtr_old/D", sample, ".filt.mtr.txt"), sep = "\t", header = TRUE)
  data$geneID <- paste0(data$chr, ":", data$start, "-", data$end, "|", data$dir)
  data$sample <- paste0("D",sample)
  data$age <- 22
  summary <- rbind(summary, data[,c("geneID", "sample", "age", "per_m_1")])
}

data <- summary
results <- data %>%
  group_by(geneID) %>%
  do({
    model <- lm(per_m_1 ~ age, data = .)
    summary_model <- summary(model)
    slope <- coef(summary_model)[2, "Estimate"]  # Slope for 'age'
    p_value <- coef(summary_model)[2, "Pr(>|t|)"]  # P-value for 'age'
    data.frame(slope = slope, p.value = p_value)
  })

results_df <- as.data.frame(results)
results_df$p.adj <- p.adjust(results_df$p.value)
write.table(results_df, "./mfg_age/dap_lin_reg.txt", sep = "\t", row.names = FALSE)

results_df <- read.table("./mfg_age/dap_lin_reg.txt", header = TRUE)

results_df$color <- ifelse(results_df$p.value > 0.05, "darkgrey", ifelse(results_df$slope < 0, "#1C3879", "#EB1D36"))
ggplot(data = results_df, aes(x = slope, y = -log10(p.value), col = color)) +
  geom_point(size = 1) +
  scale_color_identity() + 
  geom_hline(yintercept = -log10(0.05), col = "grey", linetype = "dashed") +
  theme_minimal() +
  labs(x = "slope", y = "-log10(p-value)", title = "CpG Gene-level Methylation Linear Regression by Age") + 
  theme(plot.title = element_text(hjust = 0.5, color = "black", face = "bold", size = rel(1.2)),
        axis.title.x = element_text(color = "black", size = rel(1.2)),
        axis.title.y = element_text(color = "black", size = rel(1.2)),
        axis.text.x = element_text(color = "black", face = "bold", size = rel(1.2)),
        axis.text.y = element_text(color = "black", size = rel(1.2)),
        strip.text = element_text(face = "bold", size = rel(1.2)),
        legend.position = "none",
        plot.margin = margin(2, 20, 2, 2)
  )
ggsave("./mfg_age/lin_reg.tiff", width = 5, height = 3.3, dpi = 150)