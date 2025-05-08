process indexReference {
    publishDir '../data/ref/', mode: 'copy'
    input:
    path ref_fasta

    output:
    tuple path(ref_fasta), path("*.amb"), path("*.ann"), path("*.bwt"), path("*.pac"), path("*.sa")

    script:
    """
    bwa index $ref_fasta
    """
}