nextflow.enable.dsl=2

include { TRIMMING } from '../../process/trimming/trimming.nf'

workflow TRIMMING_PIPELINE {

    take:
    read_pairs

    main:
    trimmed_ch = TRIMMING(read_pairs)

    emit:
    trimmed_ch
}

