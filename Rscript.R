tpm_stn <- read.table("tpm_solid_tissue_normal.tsv", header=F)
tpm_pt <- read.table("tpm_primary_tumor.tsv", header=FALSE)

boxplot(tpm_stn$V1, tpm_pt$V1, 
        names = c("Solid Tissue Normal", "Primary Tumor"), 
        main = "Lung Adenocarcinoma", 
        col = c("red", "yellow"), ylab = "log2(TPM+1)")

