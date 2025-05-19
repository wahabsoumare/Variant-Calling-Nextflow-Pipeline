process indexReference {
    tag "$ref_fasta"
    publishDir 'data/ref', mode: 'copy', overwrite: true

    input:
    path ref_fasta

    output:
    tuple path(ref_fasta), path("*.amb"), path("*.ann"), path("*.bwt"), path("*.pac"), path("*.sa")

    script:
    """
    bwa index $ref_fasta
    """
}