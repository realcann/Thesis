include { FASTANI } from '../../process/Comparative/fastani.nf'
include { MUMMER_NUCMER } from '../../process/Comparative/mummer.nf'

workflow COMPARATIVE_WORKFLOW {
  take:
    contigs_ch
    ref_fasta

  main:
    ani_ch = FASTANI(contigs_ch, ref_fasta)
    mummer_ch = MUMMER_NUCMER(contigs_ch, ref_fasta)
  emit:
    ani = ani_ch
    mummer = mummer_ch
}
