process callVariants {
    tag "Variant calling ${align_file.baseName}"
    publishDir "${params.outdir}/variants-calling", mode: 'copy', overwrite: true

    input:
    path reference
    path align_file

    output:
    path "*.vcf"

    script:
    """
    filename=\$(basename $align_file | cut -d'_' -f1)
    
    bcftools mpileup -f ${reference[0]} ${align_file} | \\
    bcftools call -mv -Ob -o \${filename}.vcf
    """
}