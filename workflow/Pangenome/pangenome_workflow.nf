include { ROARY } from '../../process/Pangenome/roary.nf'

workflow PANGENOME_WORKFLOW {

  take:
    gff_files_ch

  main:
    // Roary tek seferde tüm GFF'lerle çalışır
    ROARY( gff_files_ch.collect() )

  emit:
    roary_dir = ROARY.out.roary_dir
}
