nextflow.enable.dsl=2

include { PROKKA; PROKKA_REF } from '../../process/Annotation/prokka'

workflow ANNOTATION_PIPELINE {

  take:
    assemblies_ch   // tuple(id, fasta)  (sen meta demişsin ama aslında id)

  main:
    prokka_out = PROKKA(assemblies_ch)

    ref_ch  = Channel.fromPath(params.ref_fasta, checkIfExists: true)
    ref_out = PROKKA_REF(ref_ch)

  emit:
    prokka     = prokka_out
    prokka_ref = ref_out
}

