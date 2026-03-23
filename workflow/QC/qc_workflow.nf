nextflow.enable.dsl=2

include { FASTQC } from '../../process/QC/fastqc.nf'

workflow QC_PIPELINE {

    take:
    read_pairs

    main:
    read_pairs
        .map { sample_id, reads -> reads }
        .flatten()
        .set { fastq_ch }

    FASTQC(fastq_ch)
}

