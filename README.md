Activate environment
```
mamba activate tcga_data_analysis
```
1. Rule filter: It separated the lines containing Solid Tissue Normal and Primary Tumor in the input file
2. Rule read_data: This rule searched for the *augmented_star_gene_counts.tsv in the directories and calculated log(tpm+1)
3. Rule plot: It plots the boxplot of the tpm values
To run the snakemake
```
snakemake --snakefile tcga_data_analysis.smk plot.pdf
```
