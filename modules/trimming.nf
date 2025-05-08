process trimming {
    publishDir 'results/trimmed', mode: 'copy'

    input:
    path file

    output:
    path '*.fastq.gz'

    script:
    """
    read=\$(basename $file | cut -d'_' -f2)

    if [ "\$read" == "R1" ]; then
        adapter="TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG"
        cutadapt -a \$adapter -a "A{10}" -o trimmed_\$(basename $file) $file

    elif [ "\$read" == "R2" ]; then
        adapter="GTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG"
        cutadapt -a \$adapter -a "A{10}" -o trimmed_\$(basename $file) $file
    fi
    """
}