# Load required libraries
library(ggplot2)
library(ggridges)
set.seed(123)

setwd("/u/project/pellegrini/rainyliu/Daphnia/mfg_old")

## processing young
young <- data.frame(matrix(ncol = 4, nrow = 90))
colnames(young) <- paste0("D", 1:4)
for(sample in 1:4){
  data_temp <- read.table(paste0("D", sample,".CG.mfg.txt"), header = TRUE, row.names = 1)
  young[[paste0("D", sample)]] <- data_temp[7,,drop = TRUE]
  rownames(young) <- colnames(data_temp)
}
young <- as.data.frame(lapply(young, as.numeric))
young$avg <- rowMeans(young)

## processing mature
mature <- data.frame(matrix(ncol = 7, nrow = 90))
colnames(mature) <- paste0("D", c(5,6,8,13:16))
for(sample in c(5,6,8,13:16)){
  data_temp <- read.table(paste0("D", sample,".CG.mfg.txt"), header = TRUE, row.names = 1)
  mature[[paste0("D", sample)]] <- data_temp[7,,drop = TRUE]
  rownames(mature) <- colnames(data_temp)
}
mature <- as.data.frame(lapply(mature, as.numeric))
mature$avg <- rowMeans(mature)

## processing old
old <- data.frame(matrix(ncol = 4, nrow = 90))
colnames(old) <- paste0("D", 9:12)
for(sample in 9:12){
  data_temp <- read.table(paste0("D", sample,".CG.mfg.txt"), header = TRUE, row.names = 1)
  old[[paste0("D", sample)]] <- data_temp[7,,drop = TRUE]
  rownames(old) <- colnames(data_temp)
}
old <- as.data.frame(lapply(old, as.numeric))
old$avg <- rowMeans(old)

data_sum <- data.frame(Young = young$avg, Mature = mature$avg, Old = old$avg)
write.csv(data_sum, "age_group_meth_summary.csv", row.names = TRUE)

data <- data.frame(
  # Region_ID = rep(c("-3kb", rep(NA, 29), "TSS", rep(NA, 28),
  #                      "TES", rep(NA, 29), "3kb"), 3),
  Region_ID = factor(rep(1:90, 3), levels = 1:90),
  Methylation_Level = as.numeric(c(young$avg, mature$avg, old$avg)),
  Vector = factor(rep(c("Young", "Mature", "Old"), each = 90), levels = c("Young", "Mature", "Old")) 
)
data$Scaled_data <- data$Methylation_Level - 0.025


# Create the ridge plot with manual bandwidth adjustment
ggplot(data, aes(x = Region_ID, y = Vector, height = Scaled_data, group = Vector, fill = Vector)) +
  geom_ridgeline(scale = 50, alpha = 1) +  # Adjust scale parameter as needed
  labs(
    title = "CpG Gene-level Methylation",
    x = "Region",
    y = "Group"
  ) + 
  coord_cartesian(ylim = c(1.5, NA)) +
  theme_minimal() +
  # theme(
  #   plot.title = element_text(hjust = 0.5),
  #   legend.position = "none",
  #   axis.text.x = element_text(angle = 0, hjust = 1)
  #   
  # ) + 
  theme(
    plot.title = element_text(hjust = 0.5, color = "black", face = "bold"), # Title in black
    axis.title.x = element_text(color = "black", size = rel(1.2)),            # X-axis label in black
    axis.title.y = element_text(color = "black", size = rel(1.2)),            # Y-axis label in black
    axis.text.x = element_text(color = "black", face = "bold", size = rel(1.2)),             # X-axis ticks in black
    axis.text.y = element_text(color = "black", face = "bold", size = rel(1.2)),             # Y-axis ticks in black
    legend.position = "none",
    plot.margin = margin(2, 20, 2, 2)
  ) + 
  scale_x_discrete(
    breaks = c(1, 31, 60, 90),  # Positions of ticks
    labels = c("-3000b", "TSS", "TES", "3000b") # Custom labels
  ) + 
  scale_fill_manual(
    values = c("Young" = "#437FB6", "Mature" = "#CD6335", "Old" = "#50A849") # Custom colors for each group
  )

ggsave("ridge_plot.tiff", width = 5.5, height = 3.3, unit = "in", dpi = 150)

## supplementary figure
data <- data.frame(
  Region_ID = factor(rep(1:90, 3), levels = 1:90),
  Methylation_Level = as.numeric(c(mature$avg - young$avg, old$avg - young$avg, old$avg - mature$avg)),
  Vector = factor(rep(c("Mature - Young", "Old - Young", "Old - Mature"), each = 90), 
                  levels = c("Mature - Young", "Old - Mature", "Old - Young")) 
)


# Create the area plot for methylation differences
ggplot(data, aes(x = as.numeric(Region_ID), y = Methylation_Level, fill = Vector)) +
  geom_area(stat = "identity", position = "identity", alpha = 0.7) +
  facet_wrap(~ Vector, ncol = 1, scales = "fixed") +  
  labs(
    title = "CpG Gene-level Methylation Difference",
    x = "Region",
    y = "Methylation Level Difference"
  ) +
  xlim(1, 90) + 
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, color = "black", face = "bold", size = rel(1.2)),
    axis.title.x = element_text(color = "black", size = rel(1.2)),
    axis.title.y = element_text(color = "black", size = rel(1.2)),
    axis.text.x = element_text(color = "black", face = "bold", size = rel(1.2)),
    axis.text.y = element_text(color = "black", size = rel(1.2), angle = 45),
    strip.text = element_text(face = "bold", size = rel(1.2)),
    legend.position = "none",
    plot.margin = margin(2, 20, 2, 2)
  ) +
  scale_x_continuous(
    breaks = c(1, 31, 60, 90),  # Positions of ticks
    labels = c("-3000b", "TSS", "TES", "3000b") # Custom labels
  ) + 
  scale_y_continuous(
    breaks = c(0, -0.003),  # Specify y-axis breaks
    labels = c("0", "-0.003") # Specify labels for the breaks
  )

# Save the plot
ggsave("methylation_difference_plot.tiff", width = 5, height = 3.3, unit = "in", dpi = 150)


### random permutation for significance

full <- data.frame(matrix(ncol = 15, nrow = 90))
colnames(full) <- paste0("D", c(1:6, 8:16))
for(sample in c(1:6, 8:16)){
  data_temp <- read.table(paste0("D", sample,".CG.mfg.txt"), header = TRUE, row.names = 1)
  full[[paste0("D", sample)]] <- data_temp[7,,drop = TRUE]
  rownames(full) <- colnames(data_temp)
}
full <- as.data.frame(lapply(full, as.numeric))

# Load your dataframe (assuming it's called `df`)
df <- full

# Specify column groups
# ## young vs. mature
# group1 <- c("D1", "D2", "D3", "D4")
# group2 <- c("D5", "D6", "D8", "D13", "D14", "D15", "D16")

# ## mature vs. old
# group1 <- c("D5", "D6", "D8", "D13", "D14", "D15", "D16")
# group2 <- c("D9", "D10", "D11", "D12")

## young vs. old
group1 <- c("D1", "D2", "D3", "D4")
group2 <- c("D9", "D10", "D11", "D12")

# Number of permutations
num_permutations <- 100000

# Initialize a vector to store p-values
p_values <- numeric(nrow(df))

# Perform permutation test for each row
for (i in 1:nrow(df)) {
  
  print(i)
  # Extract the current row
  row <- df[i, ]
  
  # Calculate observed mean difference
  observed_diff <- mean(as.numeric(row[group1])) - mean(as.numeric(row[group2]))
  
  # Pool all values from the row
  pooled_values <- unlist(row)
  
  # Initialize a vector to store permuted differences
  permuted_diffs <- numeric(num_permutations)
  
  for (j in 1:num_permutations) {
    # Randomly permute values
    permuted_values <- sample(pooled_values)
    
    # Split into two groups based on original group sizes
    perm_group1 <- permuted_values[1:length(group1)]
    perm_group2 <- permuted_values[(length(group1) + 1):(length(group1) + length(group2))]
    stopifnot(length(perm_group1) == length(group1))
    stopifnot(length(perm_group2) == length(group2))
    
    # Calculate mean difference for the permutation
    permuted_diffs[j] <- mean(perm_group1) - mean(perm_group2)
  }
  
  # Calculate p-value (two-tailed)
  p_values[i] <- mean(abs(permuted_diffs) >= abs(observed_diff))
}

# Add p-values as a new column in the dataframe
df$p_values <- p_values

write.csv(df, "random_perm_young_vs_old.csv", row.names = TRUE)

