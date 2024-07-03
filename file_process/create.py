import os
import gzip

def simplify_vcf(input_file, output_file):
    with open(input_file, 'r') as infile, open(output_file, 'w') as outfile:
        outfile.write('##fileformat=VCFv4.2\n')
        outfile.write('##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">\n')
        outfile.write('#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tSAMPLE\n')
        for line in infile:
            if line.startswith('#'):
                # if line.startswith(b'#CHROM'):
                    # 只寫入需要的欄位標頭
                    # outfile.write('#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tSAMPLE\n')
                continue

            parts = line.strip().split('\t')
            # 只保留CHROM, POS, REF, ALT, 其他用'.'替代
            simplified_line = f"{parts[0]}\t{parts[1]}\t.\t{parts[3]}\t{parts[4]}\t.\t.\t.\tGT\t1/1\n"
            outfile.write(simplified_line)

def process_folder(folder_path):
    # 確保資料夾存在
    if not os.path.exists(folder_path):
        print("Folder does not exist.")
        return
    
    for file_name in os.listdir(folder_path):
        if file_name.endswith('.afreq'):
            input_file = os.path.join(folder_path, file_name)
            file_name = file_name[:-6]
            output_file = os.path.join('C:\\Users\\guest1\\Desktop\\af\\test_annovar', 'simplified_' + file_name + '.vcf')
            simplify_vcf(input_file, output_file)
            print(f"Processed {file_name}")

# 資料夾路徑
folder_path = 'C:\\Users\\guest1\\Desktop\\af\\test\\merged\\snp'  # 資料夾路徑
process_folder(folder_path)
