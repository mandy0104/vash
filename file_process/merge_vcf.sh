#!/bin/bash

# Directory where the VCF files are located
vcf_dir="/mnt/c/Users/guest1/Desktop/af/test"

# Change to the directory with your VCF files
cd "$vcf_dir" || exit

# Compress and index each VCF file if not already done
for file in *.vcf; do
  if [ -e "$file" ] && [[ ! -f "${file}.gz" ]]; then
    echo "Compressing $file..."
    bgzip -c "$file" > "${file}.gz"
    echo "Indexing ${file}.gz..."
    bcftools index "${file}.gz"
  fi
done

echo "Merging VCF files..."
# Merge the VCF files using a lower number of threads
bcftools merge --threads 4 --force-samples ./*.vcf.gz -Oz -o "$vcf_dir/merged/merged_output.vcf.gz"

echo "Indexing the merged VCF file..."
# Index the merged VCF file
bcftools index "$vcf_dir/merged/merged_output.vcf.gz"

echo "VCF files have been merged and indexed."
