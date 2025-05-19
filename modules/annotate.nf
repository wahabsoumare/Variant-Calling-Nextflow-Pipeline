process annotateReads {
    tag "Annotate ${vcf_file.baseName}"
    publishDir "${params.outdir}/annotations", mode: 'copy', overwrite: true

    input:
    path vcf_file

    output:
    path "*.vcf"

    script:
    """
    filename=\$(basename $vcf_file | cut -d'.' -f1)

    java -jar ${params.snpEff} Plasmodium_falciparum $vcf_file > \${filename}_annotated.vcf
    """
}