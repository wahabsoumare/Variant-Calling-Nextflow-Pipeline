process qc_pre_trimming {
    tag "QC ${sample_id}"
    publishDir "${params.outdir}/qc/pre-trimming", mode: 'copy', overwrite: true

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    path '*.html', emit: html
    path '*.zip', emit: zip

    script:
    """
    fastqc $read1 $read2
    """
}

process qc_post_trimming {
    tag "QC ${sample_id}"
    publishDir "${params.outdir}/qc/post-trimming", mode: 'copy', overwrite: true

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    path '*.html'
    path '*.zip'

    script:
    """
    fastqc $read1 $read2
    """
}