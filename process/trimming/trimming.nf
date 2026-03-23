nextflow.enable.dsl = 2

process TRIMMING {

    tag "$sample"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("${sample}_R1_paired.fastq"), path("${sample}_R2_paired.fastq")

    script:
    """
    trimmomatic PE \
      ${reads[0]} ${reads[1]} \
      ${sample}_R1_paired.fastq ${sample}_R1_unpaired.fastq \
      ${sample}_R2_paired.fastq ${sample}_R2_unpaired.fastq \
      SLIDINGWINDOW:4:20 MINLEN:50
    """
}

