nextflow.enable.dsl=2

include { QC_PIPELINE }           from './workflow/QC/qc_workflow.nf'
include { TRIMMING_PIPELINE }     from './workflow/trimming/trimming_workflow.nf'
include { ASSEMBLY_PIPELINE }     from './workflow/Assembly/assembly_workflow.nf'
include { ANNOTATION_PIPELINE }   from './workflow/Annotation/annotation_workflow.nf'
include { COMPARATIVE_WORKFLOW }  from './workflow/Comparative/comparative_workflow.nf'
include { PANGENOME_WORKFLOW }    from './workflow/Pangenome/pangenome_workflow.nf'

workflow {

    reads_ch = Channel.fromFilePairs(params.fastq_files)


    QC_PIPELINE(reads_ch)


    trimmed_ch = TRIMMING_PIPELINE(reads_ch)


    assembly_out = ASSEMBLY_PIPELINE(trimmed_ch)


    annotation_out = ANNOTATION_PIPELINE(assembly_out.contigs_ch)


    prokka_out     = annotation_out.prokka
    prokka_ref_out = annotation_out.prokka_ref

 
    ref_fasta = file(params.ref_fasta)


    comparative_out = COMPARATIVE_WORKFLOW(assembly_out.contigs_ch, ref_fasta)

 
    gff_sample_ch = prokka_out.map     { row -> row[1] }
    gff_ref_ch    = prokka_ref_out.map { row -> row[1] }
    gff_all_ch    = gff_sample_ch.mix(gff_ref_ch)

  
    pangenome_out = PANGENOME_WORKFLOW(gff_all_ch)

}
