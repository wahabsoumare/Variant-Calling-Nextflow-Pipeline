#!/usr/bin/env nextflow

include { quality_control } from './modules/qc.nf'
include { trimming } from './modules/trimming.nf'
include { qc_post_trimming } from './modules/qc_post_trimming.nf'
include { indexReference } from './modules/indexReference.nf'
include { alignment } from './modules/alignment.nf'

workflow  {
    reads = Channel.fromPath(params.reads, checkIfExists: true)
    reference = Channel.fromPath(params.ref, checkIfExists: true)

    quality_control(reads)

    trimmed_reads = trimming(reads)
    qc_post_trimming(trimmed_reads)

    indexed_ref = indexReference(reference)
    
    paired_trimmed_reads = Channel.fromFilePairs("results/trimmed/*_R{1,2}_001.fastq.gz", flat: true)
    alignment(indexed_ref[0], paired_trimmed_reads)
}