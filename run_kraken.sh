#!/bin/bash

  

for file in *.fastq.gz; do
    base=$(basename "$file" .fastq.gz)
    krakenuniq --db /media/user/36d81ee3-f383-4bc4-b619-20abd785be33/DATABASE/DBDIR \
               --threads 96 \
               --report "${base}_report.txt" \
               --output "${base}_mapped.kraken" \
               "$file"
done