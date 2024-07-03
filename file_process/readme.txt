create.py -> 創造出特定格式的vcf檔以跑annovar

final.sh -> 將跑完annovar的vcf檔加上allele count, allele frequency和allele number
(過程可能可以簡化，目前跑X跑不出結果)
- annotations.hdr -> 要額外加上的header

merge_vcf.sh -> 合併所有樣本

split_vcf.sh -> 將merge完的vcf以chromosome分為1~22和XY以跑plink

snp.py -> 跑plink

additional files that are not on Github (privacy issue):

test.psam -> 跑snp會用到的性別資料

vcf-merge_list_gender.xlsx -> 以F和M表示的2608個樣本清單

vcf-merge_list_gender_12.xlsx -> 以2和1表示的2608個樣本清單 (F = 2，M = 1)
