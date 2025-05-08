process alignment {
    publishDir 'results/alignment', mode: 'copy'

    input:
    path reference
    tuple val(sample), path(reads)

    output:
    path "${sample}.sorted.bam"

    script:
    """
    R1=${reads[0]}
    R2=${reads[1]}

    bwa mem -t 2 $reference \$R1 \$R2 | samtools view -bS | samtools sort -o ${sample}.sorted.bam
    """
}