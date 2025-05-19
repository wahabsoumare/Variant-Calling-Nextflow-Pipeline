process trimReads {
    tag "Trim ${sample_id}"
    publishDir "${params.outdir}/trimmed", mode: 'copy', overwrite: true

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    tuple val(sample_id), 
          path("${sample_id}_trimmed_R1.fastq.gz"),
          path("${sample_id}_trimmed_R2.fastq.gz")

    script:
    """
    cutadapt \\
        -a ${params.adapter} -a "A{10}" -a "G{10}" \\
        -A ${params.adapter} -A "A{10}" -A "G{10}" \\
        -q 20,20 \\
        -o ${sample_id}_trimmed_R1.fastq.gz -p ${sample_id}_trimmed_R2.fastq.gz \\
        ${read1} ${read2}
    """
}