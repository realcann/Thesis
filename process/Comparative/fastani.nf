process FASTANI {
  tag "$id"

  input:
    tuple val(id), path(query_fasta)
    path(ref_fasta)

  output:
    tuple val(id), path("${id}.fastani.tsv")

  script:
  """
  fastANI -q ${query_fasta} -r ${ref_fasta} -o ${id}.fastani.tsv
  """
}

