process  quality_control {
    publishDir 'results/qc', mode: 'copy'
    input:
    path read

    output:
    path '*.html'
    path '*.zip'

    script:
    """
    fastqc $read
    """
}