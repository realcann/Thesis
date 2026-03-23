nextflow.enable.dsl=2

include { SPADES_ASSEMBLY } from '../../process/Assembly/spades.nf'

workflow ASSEMBLY_PIPELINE {

    take:
    trimmed_ch

    main:
    contigs_ch = SPADES_ASSEMBLY(trimmed_ch)

    emit:
    contigs_ch
}

