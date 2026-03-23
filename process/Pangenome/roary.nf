process ROARY {

  publishDir "${params.outdir}/07_pangenome_roary", mode: 'copy', overwrite: true

  input:
    path gff_files

  output:
    path("roary_out"), emit: roary_dir

  script:
  """
  set -euo pipefail

  rm -rf roary_out roary_out_*
  mkdir -p roary_out

  echo "=== GFF files received ==="
  ls -lah ${gff_files} || true
  echo "GFF count: ${gff_files.size()}"

  roary -e -n -v -p ${task.cpus} -f roary_out ${gff_files}

  # Eğer Roary timestamp'li klasöre yazdıysa onu roary_out'a taşı
  if ls -d roary_out_* 1>/dev/null 2>&1; then
    latest=\$(ls -dt roary_out_* | head -n 1)
    echo "Roary wrote output to: \$latest"
    rm -rf roary_out
    mv "\$latest" roary_out
  fi

  echo "=== roary_out contents ==="
  ls -lah roary_out | head -n 200
  """
}
