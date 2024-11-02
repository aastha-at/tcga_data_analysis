library(ggplot2)

tpm_stn <- read.table("tpm_solid_tissue_normal.tsv", header=F)
tpm_pt <- read.table("tpm_primary_tumor.tsv", header=F)

plot <- ggplot() +
  geom_boxplot(aes(x="Solid Tissue Normal", y=tpm_stn$V1), fill="red") + 
  geom_boxplot(aes(x="Primary Tumor", y=tpm_pt$V1), fill="yellow") +    
  labs(title="Lung Adenocarcinoma",x="", y="log2(TPM+1)") +
  theme_minimal()

ggsave("plot.png", plot=plot, width=8, height=6, dpi=300)
