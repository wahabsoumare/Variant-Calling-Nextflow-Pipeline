process visualizeResults {
    tag "Visualisation"
    publishDir "${params.outdir}/visualization", mode: 'copy', overwrite: true

    input:
    path vcf_files

    output:
    path "*.png"
    path "*.tsv"

    script:
    """
    python3 "${params.script}/visualize.py" ${vcf_files.join(' ')}
    """
}