🧬 Thesis – Reproducible Genomic Analysis Pipeline (Nextflow)

This repository contains a reproducible bioinformatics pipeline developed for undergraduate thesis work.
The pipeline performs genome processing and comparative analysis, including quality control, trimming, assembly, annotation, and pangenome analysis.

🚀 Features

Reproducible workflow using Nextflow
Modular pipeline design (DSL2)
Supports:

Quality Control (FastQC)
Trimming
Genome Assembly (SPAdes)
Genome Annotation (Prokka)
Comparative Genomics (MUMmer)
Pangenome Analysis (Roary)
Scalable and portable across systems

📦 Requirements

Make sure the following are installed:

Nextflow (>= 22.x)
Conda (recommended)

⚙️ Setup

Clone the repository:

git clone https://github.com/realcann/Thesis.git

cd Thesis

📂 Input Data

The pipeline expects:

Paired-end FASTQ files
A reference genome in FASTA format

Example structure:

files/
├── sample_R1_001.fastq
├── sample_R2_001.fastq
└── Earth_reference.fasta

⚠️ Note: Input data is not included due to size limitations.

▶️ Running the Pipeline
Basic run:
nextflow run main.nf -profile conda \
  --fastq_files "files/*_R{1,2}_001.fastq" \
  --ref_fasta "files/Earth_reference.fasta"
Custom output directory:
nextflow run main.nf -profile conda \
  --fastq_files "your_data/*_R{1,2}.fastq.gz" \
  --ref_fasta "your_data/reference.fasta" \
  --outdir "results"
📊 Output

Results will be generated in the specified output directory (out/ by default), including:

Quality control reports
Trimmed reads
Assembled genomes
Annotation outputs
Comparative analysis results
Pangenome outputs
🧪 Reproducibility
All dependencies are managed via environment.yml
The pipeline can be executed on any system with Nextflow + Conda
Intermediate files are stored in the work/ directory
📁 Project Structure
.
├── main.nf
├── nextflow.config
├── environment.yml
├── workflow/
├── modules/
├── files/ (not included)
├── out/ (generated)

👤 Author

Can Gerçek

Istanbul University

Molecular Biology and Genetics

Bioinformatics & Comparative Genomics

📌 Notes

This pipeline was developed as part of a thesis project focusing on reproducible genomic analysis.
