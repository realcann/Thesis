process MUMMER_NUCMER {
  tag "$id"

  input:
    tuple val(id), path(query_fasta)
    path(ref_fasta)

  output:
    tuple val(id),
          path("${id}.delta"),
          path("${id}.coords.txt")

  script:
  """
  nucmer --prefix=${id} ${ref_fasta} ${query_fasta}
  delta-filter -r -q ${id}.delta > ${id}.filtered.delta
  show-coords -rcl ${id}.filtered.delta > ${id}.coords.txt

  # keep original delta name stable
  cp ${id}.filtered.delta ${id}.delta
  """
}
