process qc_post_trimming {
    publishDir 'results/qc_post_trimming', mode: 'copy'

    input:
    path trimmed_file

    output:
    path '*.html'
    path '*.zip'

    script:
    """
    fastqc $trimmed_file
    """
}