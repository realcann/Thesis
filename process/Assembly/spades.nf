nextflow.enable.dsl=2

process SPADES_ASSEMBLY {

    tag "$sample"

    input:
    tuple val(sample), path(read1), path(read2)

    output:
    tuple val(sample), path("spades_out/contigs.fasta")

    script:
    """
    /usr/bin/spades.py \
      -1 ${read1} \
      -2 ${read2} \
      -t 4 \
      -m 24 \
      -o spades_out
    """
}

