rule filter:
    input:
        "gdc_sample_sheet.2024-09-27.tsv"
    output:
        pt="primary_tumor.tsv",
        stn="solid_tissue_normal.tsv"
    shell:
        """
        grep "Primary Tumor" {input} | awk '{{print $1}}' > {output.pt}
        grep "Solid Tissue Normal" {input} | awk '{{print $1}}' > {output.stn}
        """

rule read_data:
    input:
        "{sample}.tsv"
    output:
        "tpm_{sample}.tsv"
    shell:
        """
        while read file; do
            if [ -d "$file" ]; then 
                find "$file" -name "*.tsv" | xargs grep -E 'NKX2-1\\s' | awk '{{print log($7+1)/ log(2)}}' >> {output}
            fi
        done < {input}
        """

rule plot:
    input:
        tpm_pt="tpm_primary_tumor.tsv",
        tpm_stn="tpm_solid_tissue_normal.tsv",
        script="Rscript.R"
    output: 
        "plot.pdf"
    shell:
        "Rscript {input.script} {output}"
