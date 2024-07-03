#!/usr/bin/env python3
import subprocess
import os
import glob

input_files = input("input filenames(in *.vcf form, seperated by space) or all:")
output_file = "snp_results"
cwd = os.getcwd()
files = glob.glob(cwd + "/*.vcf.gz")
if len(files)==0 or len(input_files)==0: print("No vcf file in this directory.")
else:
    if(input_files=="all"):
        ct=1
        for file in files:
            file = file.split("\\")[-1]
            print("Find {}".format(file))
            # plink_cmd = ["./plink2",
            plink_cmd = ["C:\\Users\\guest1\\Desktop\\plink2.exe",
                    "--vcf", file,
                    "--snps-only",
                    "--freq",
                    "'counts'", 
                    "cols=+pos",#=和+中間不能有空格
                    "--psam", "test.psam",
                    "--split-par", "2781479", "155701383",
                    "--out", ".\\snp\\" + file.split(".")[0]]
            subprocess.run(plink_cmd)
            ct+=1
    else:
        input_files = input_files.split(" ")
        ct=1
        for file_name in input_files:
            full_path = os.path.join(cwd, file_name)
            if full_path not in files:
                print("Cannot find {}".format(file_name))
            else:
                print("Find {}".format(file_name))
                plink_cmd = ["C:\\Users\\guest1\\Desktop\\plink2.exe",
                            "--vcf", file_name,
                            "--snps-only",
                            "--freq",
                            "'counts'",
                            "cols=+pos",#=和+中間不能有空格
                            "--psam", "test.psam",
                            "--split-par", "2781479", "155701383",
                            "--out", ".\\snp\\" + file_name.split(".")[0]]
                subprocess.run(plink_cmd)
                ct+=1

# 完成
print("SNV 分析已完成，结果已保存至", output_file)