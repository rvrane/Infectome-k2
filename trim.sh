#!/bin/bash

# Create a new directory for the trimmed results
mkdir -p trimmed_results

# Define adapter sequences
adapter1="CCACTGGCACAGAATGCTAC"
adapter2="GTAGCATTCTGTGCCAGTGG"
adapter_polyA="A{10}"
adapter_polyT="T{10}"
adapter_polyC="C{10}"
adapter_polyG="G{10}"
adapter3="CTGTCTCTTATACACATCT"
adapter4="AGATGTGTATAAGAGACAG"

# Loop through each FASTQ file
for fastq_file in *.fastq.gz; do
    # Define the output file name inside the new directory
    output_file="trimmed_results/${fastq_file}"

    # Define the report file name inside the new directory
    report_file="trimmed_results/cutadapt_report_${fastq_file}.output.txt"

    # Run cutadapt to trim adapters and poly-G tail, perform NextSeq quality trimming, and filter by minimum length
    cutadapt -g CCTACACGACGCTCTTCCGATCT \
             -g TTCAGACGTGTGCTCTTCCGATCT \
             -a AGATCGGAAGAGCGTCGTGTAGG \
             -a AGATCGGAAGAGCACACGTCTGAA \
             -a "$adapter1" \
             -a "$adapter2" \
             -a "$adapter_polyA" \
             -a "$adapter_polyT" \
             -a "$adapter_polyC" \
             -a "$adapter_polyG" \
             -a "$adapter3" \
             -a "$adapter4" \
             -e 0.1 -O 9 -m 20 -n 2 \
             --minimum-length=70 \
             -o "${output_file}" "${fastq_file}" > "${report_file}"

    # Run FastQC on the trimmed FASTQ file
    fastqc "${output_file}" -o trimmed_results/
done

# Run MultiQC to generate a summary report for all FastQC results
multiqc trimmed_results/ -o trimmed_results/