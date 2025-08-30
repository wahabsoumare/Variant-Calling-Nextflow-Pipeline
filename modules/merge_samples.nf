process merge_samples {
    publishDir "${params.outdir}/alignments", mode: 'copy'
    
    input:
    path samples

    output:
    path "samples.txt"

    script:
    """
    python3 "${params.script}/merge_samples.py" ${samples.join(' ')}
    """
}