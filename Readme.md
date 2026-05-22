# KrakenUniq Metagenomics Pipeline

A lightweight metagenomics workflow for processing human-derived FASTQ files and performing microbial classification using **KrakenUniq**. This repository includes shell scripts for preprocessing and classification, along with a Python utility for converting Kraken results into an Excel-friendly summary.

## Overview

This pipeline is designed for metagenomic screening of sequencing data where the primary input is raw FASTQ files. The workflow includes read trimming, taxonomic classification with KrakenUniq, and post-processing of the output into a tabular report.

## Repository structure

- `trim.sh` — preprocessing script for trimming raw sequencing reads.
- `run_kraken.sh` — runs KrakenUniq classification on processed FASTQ files.
- `kraken_excel.py` — converts Kraken output into a structured spreadsheet/report format.

## Workflow

1. Start with raw FASTQ files.
2. Trim adapters and low-quality bases.
3. Run KrakenUniq against the selected database.
4. Parse the classification output into a summary table for downstream review.

## Requirements

Install the following before running the pipeline:

- Bash
- Python 3
- KrakenUniq
- A compatible Kraken/KrakenUniq database
- Standard command-line tools used in NGS preprocessing

Optional but commonly useful:

- `fastp` or `cutadapt` for trimming
- `gzip` support for compressed FASTQ files

## Input

The pipeline expects sequencing reads in FASTQ format, typically one of the following:

- Paired-end FASTQ files: `sample_R1.fastq.gz` and `sample_R2.fastq.gz`
- Single-end FASTQ file: `sample.fastq.gz`

## Output

Typical outputs include:

- Trimmed FASTQ files
- KrakenUniq classification reports
- Tabular summaries for interpretation
- Excel-compatible output generated from parsed classification results

## Setup

Clone the repository:

```bash
git clone <repository-url>
cd kraken-metagenomics
```

Make the shell scripts executable:

```bash
chmod +x trim.sh
chmod +x run_kraken.sh
```

Update the scripts as needed for:

- Input FASTQ locations
- Output directory
- KrakenUniq database path
- Thread count
- Sample naming convention

## Example usage

### 1. Trim reads

```bash
./trim.sh
```

### 2. Run KrakenUniq

```bash
./run_kraken.sh
```

### 3. Generate spreadsheet summary

```bash
python3 kraken_excel.py
```

## Suggested execution pattern

For production use, it is a good idea to edit the scripts so they accept command-line arguments such as:

- `--input`
- `--output`
- `--db`
- `--threads`
- `--sample-id`

This makes the workflow easier to scale across multiple samples and simpler to integrate into larger analysis pipelines.

## Notes

- This workflow is intended for metagenomic classification and reporting.
- Human-derived sequencing data may require careful handling of host background, contamination, and low-biomass interpretation.
- Taxonomic calls should always be reviewed in the context of read depth, unique k-mer support, sample type, and laboratory controls.

## Limitations

- Classification accuracy depends heavily on database quality and completeness.
- Low-level or unexpected taxa may represent contamination, index bleed-through, or environmental/background signal.
- The current repository structure suggests a script-based workflow rather than a fully parameterized pipeline framework.

## Future improvements

Potential enhancements for this repository include:

- Command-line argument support
- Batch processing for multiple samples
- Config file support
- Logging and error handling
- Containerization with Docker
- Workflow orchestration with Nextflow or Snakemake
- Automated QC summary reports

## Citation

If this pipeline supports published work (https://dx.doi.org/10.1186/s13059-019-1891-0) or internal validation, cite KrakenUniq and any preprocessing tools used in the workflow.

## Credits: 

https://github.com/DerrickWood/kraken2

## License

Add an appropriate license for reuse and distribution.

