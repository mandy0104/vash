create.py -> 創造出特定格式的vcf檔以跑annovar

final.sh -> 將跑完annovar的vcf檔加上allele count, allele frequency和allele number
(過程可能可以簡化，目前跑X跑不出結果)
- annotations.hdr -> 要額外加上的header

merge.vcf -> 合併所有樣本

split.vcf -> 將merge完的vcf以chromosome分為1~22和XY以跑plink

snp.py -> 跑plink
