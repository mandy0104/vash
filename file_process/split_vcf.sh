#!/bin/bash

# The original VCF file
VCF_FILE="merged/merged_output.vcf"

# Number of lines in each smaller file
LINES_PER_FILE=10000

# Total number of lines in the VCF file
TOTAL_LINES=$(wc -l < "$VCF_FILE")

# Calculate the number of files to be created
NUM_FILES=$((TOTAL_LINES / LINES_PER_FILE))
if [ $((TOTAL_LINES % LINES_PER_FILE)) -ne 0 ]; then
    NUM_FILES=$((NUM_FILES + 1))
fi

echo "Splitting into $NUM_FILES files"

# Splitting the file
START_LINE=1
for (( i=1; i<=NUM_FILES; i++ ))
do
    END_LINE=$((START_LINE + LINES_PER_FILE - 1))
    if [ $END_LINE -gt $TOTAL_LINES ]; then
        END_LINE=$TOTAL_LINES
    fi

    # Extracting the lines using bcftools and head/tail
    bcftools view "$VCF_FILE" | head -n $END_LINE | tail -n +$START_LINE > "split/split_file_$i.vcf"

    echo "Created split_file_$i.vcf"

    START_LINE=$((END_LINE + 1))
done
