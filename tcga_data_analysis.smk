import pandas as pd

metadata=pd.read_csv("data/metadata.tsv", sep="\t")
sample_types = dict(zip(metadata['output_name'], metadata['sample_type']))
output_names=list(sample_types.keys())

rule filter:
    input:
        sample_sheet="gdc_sample_sheet.tsv"
    output:
        "gene_files/{sample}.tsv"
    params:
        sample_type=lambda wildcards: sample_types[wildcards.sample]
    shell:
        """
        grep '{params.sample_type}' {input.sample_sheet} | awk '{{print $1}}' > {output}
        """

rule read_data:
    input:
        sample_file="gene_files/{sample}.tsv",
        gene_file="data/gene_name.tsv"
    output:
        "tpm_files/tpm_{sample}.tsv"
    shell:
        """
        gene_name=$(cat {input.gene_file})
        while read file; do
            if [ -d "tcga_data/$file" ]; then
                find "tcga_data/$file" -name "*augmented_star_gene_counts.tsv" | xargs grep -E "$gene_name\\s" | awk '{{print log($7+1)/ log(2)}}' >> {output}
            fi
        done < {input.sample_file}
        """

rule plot:
    input:
        tpm_files=expand("tpm_files/tpm_{sample}.tsv", sample=output_names),
        script="scripts/Rscript.R"
    output:
        "plot.pdf"
    shell:
        "Rscript {input.script}"
