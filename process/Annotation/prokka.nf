process PROKKA {
  tag "${id}"

  input:
    tuple val(id), path(fasta)

  output:
    tuple val(id),
          path("${id}.gff"),
          path("${id}.fna"),
          path("${id}.faa"),
          path("${id}.gbk"),
          path("${id}.txt")

  script:
  """
  prokka \
    --outdir . \
    --prefix ${id} \
    --cpus ${task.cpus} \
    --force \
    ${fasta}
  """
}

process PROKKA_REF {
  tag "REF"

  input:
    path ref_fa

  output:
    tuple val("REF"),
          path("REF.gff"),
          path("REF.fna"),
          path("REF.faa"),
          path("REF.gbk"),
          path("REF.txt")

  script:
  """
  prokka \
    --outdir . \
    --prefix REF \
    --cpus ${task.cpus} \
    --force \
    ${ref_fa}
  """
}

