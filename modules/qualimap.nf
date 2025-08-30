process qualimap {
    // tag "${bam_file.simpleName}"
    publishDir "${params.outdir}/qualimap/", mode: 'copy'
    container 'community.wave.seqera.io/library/qualimap:2.3--c1797c2253925b3a'

    input:
        path samples

    output:
        path "reports"

    script:
    """
    qualimap multi-bamqc -r -d "$samples" -outdir reports
    """
}