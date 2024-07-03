#!/bin/bash
#"1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "X" "Y" 
chromosomes=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "X" "Y" )

for chr in "${chromosomes[@]}"
do
    echo "Processing chromosome chr$chr..."

    bgzip -f "chr${chr}_modified.afreq"
    bgzip -f "chr${chr}_modified.acount"
    tabix -p vcf "chr${chr}_modified.afreq.gz"
    tabix -p vcf "chr${chr}_modified.acount.gz"

    sed -i 's/\t.;/\t/' "chr${chr}.vcf"
    bgzip -f "chr${chr}.vcf"
    tabix -p vcf "chr${chr}.vcf.gz"

    bcftools annotate -a "chr${chr}_modified.afreq.gz" -c CHROM,POS,-,REF,ALT,INFO/AF,- --force -o "chr${chr}_annotate.vcf" -O v "chr${chr}.vcf.gz"
    bgzip -f "chr${chr}_annotate.vcf"
    bcftools annotate -a "chr${chr}_modified.acount.gz" -c CHROM,POS,-,REF,ALT,INFO/AC,- --force -o "chr${chr}_final.vcf" -O v "chr${chr}_annotate.vcf.gz"

    bcftools reheader -h origin.hdr "chr${chr}_final.vcf" > "chr${chr}_new.vcf"
    bgzip -f "chr${chr}_new.vcf" 
    tabix -p vcf "chr${chr}_new.vcf.gz"
    bcftools annotate -a "chr${chr}_modified.acount.gz" -c CHROM,POS,-,REF,ALT,AC,INFO/AN --force -o "chr${chr}_added.vcf" -O v "chr${chr}_new.vcf.gz" 
    bcftools norm -m- -Ov -o "chr${chr}_split.vcf" "chr${chr}_added.vcf"
    sed -i 's/MutPred_score=-;/MutPred_score=.;/g' "chr${chr}_split.vcf" 
    sed -i '/^#/!s/\([^\t]*\)\t\([^\t]*\)\t\([^\t]*\)\t\([^\t]*\)\t\([^\t]*\)\t\([^\t]*\)\t/\1\t\2\t\3\t\4\t\5\t0\t/' "chr${chr}_split.vcf" > "chr${chr}_output.vcf" 

    echo "Chromosome chr$chr processing completed."

done
echo "All chromosomes processed."
