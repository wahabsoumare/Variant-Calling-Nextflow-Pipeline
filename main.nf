#!/usr/bin/env nextflow

include { qc_pre_trimming } from './modules/qc.nf'
include { qc_post_trimming } from './modules/qc.nf'
include { trimReads } from './modules/trim.nf'
include {indexReference} from './modules/index_reference.nf'
include { alignReads } from './modules/align.nf'
include { merge_samples } from './modules/merge_samples.nf'
include { qualimap } from './modules/qualimap.nf'
include { callVariants } from './modules/call_variants.nf'
include { annotateReads } from './modules/annotate.nf'
include { visualizeResults } from './modules/visualize.nf'

workflow  {
    reads = Channel.fromFilePairs(params.reads, flat: true)
    ref = Channel.fromPath(params.ref)
    
    qc_pre_trimming(reads) 

    trimmed_reads = trimReads(reads)

    qc_post_trimming(trimmed_reads)

    indexed_ref = indexReference(ref)

    alignements = alignReads(indexed_ref.collect(), trimmed_reads)
    samples = merge_samples(alignements.collect())

    qualimap(samples)

    variants = callVariants(indexed_ref.collect(), alignements)

    annotated_variants = annotateReads(variants)

    visualizeResults(annotated_variants.collect())
}