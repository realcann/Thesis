nextflow.enable.dsl=2

include { QC_PIPELINE }           from './workflow/QC/qc_workflow.nf'
include { TRIMMING_PIPELINE }     from './workflow/trimming/trimming_workflow.nf'
include { ASSEMBLY_PIPELINE }     from './workflow/Assembly/assembly_workflow.nf'
include { ANNOTATION_PIPELINE }   from './workflow/Annotation/annotation_workflow.nf'
include { COMPARATIVE_WORKFLOW }  from './workflow/Comparative/comparative_workflow.nf'
include { PANGENOME_WORKFLOW }    from './workflow/Pangenome/pangenome_workflow.nf'

workflow {

    reads_ch = Channel.fromFilePairs(params.fastq_files)

    // QC
    QC_PIPELINE(reads_ch)

    // Trimming
    trimmed_ch = TRIMMING_PIPELINE(reads_ch)

    // Assembly
    assembly_out = ASSEMBLY_PIPELINE(trimmed_ch)

    // Annotation (sample + ref)
    annotation_out = ANNOTATION_PIPELINE(assembly_out.contigs_ch)

    // Prokka outputs emitted by ANNOTATION_PIPELINE
    // annotation_out.prokka     : tuples (id, gff, fna, faa, gbk, txt)
    // annotation_out.prokka_ref : tuples (id, gff, fna, faa, gbk, txt)  (ref için)
    prokka_out     = annotation_out.prokka
    prokka_ref_out = annotation_out.prokka_ref

    // Reference fasta (for comparative workflow)
    ref_fasta = file(params.ref_fasta)

    // Comparative (ANI + WGA vs)
    comparative_out = COMPARATIVE_WORKFLOW(assembly_out.contigs_ch, ref_fasta)

    /*
     * Roary inputs:
     * Take ONLY the .gff from both sample + ref Prokka outputs and merge.
     * Row[1] is gff if tuple is (id, gff, fna, faa, gbk, txt)
     */
    gff_sample_ch = prokka_out.map     { row -> row[1] }
    gff_ref_ch    = prokka_ref_out.map { row -> row[1] }
    gff_all_ch    = gff_sample_ch.mix(gff_ref_ch)

    // Roary (PANGENOME_WORKFLOW should collect() and run ROARY once)
    pangenome_out = PANGENOME_WORKFLOW(gff_all_ch)

    // ---- Buradan sonra yeni aşamaları ekleyebilirsin ----
    // Örnek:
    // NEXT_STEP( pangenome_out.roary_dir )
}
