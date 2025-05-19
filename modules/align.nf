process alignReads {
    tag "Align ${sample_id}"
    publishDir "${params.outdir}/alignments", mode: 'copy', overwrite: true

    input:
    path reference
    tuple val(sample_id), path(read1), path(read2)

    output:
    path "${sample_id}_sorted.bam"

    script:
    """
    bwa mem -t ${params.threads} ${reference[0]} ${read1} ${read2} | \\
    samtools view -bS - | \\
    samtools sort -@ ${params.threads} -o ${sample_id}_sorted.bam
    """
}