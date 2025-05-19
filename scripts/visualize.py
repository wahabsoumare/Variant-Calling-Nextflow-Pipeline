import pandas as pd
import matplotlib.pyplot as plt

import os
import sys

def count_variants(vcf_file):
    data = []
    sample = vcf_file.split('/')[-1].replace('.vcf', '')
    count = sum(1 for line in open(vcf_file) if not line.startswith('#'))

    data.append({'sample': sample, 'variant_count': count})
    return pd.DataFrame(data)

if __name__ == "__main__":
    vcf_files = sys.argv[1:]
    


    all_data = []
    for vcf_file in vcf_files:
        data = count_variants(vcf_file)
        all_data.append(data)

    df = pd.concat(all_data, ignore_index = True)
    df = df.sort_values(by = "sample")

    plt.figure(figsize = (8, 6))

    plt.bar(df['sample'], df['variant_count'], color = 'teal')
    plt.xlabel("Samples")
    plt.ylabel("Number of Variants")
    plt.title("Variant Counts per Sample")
    plt.xticks(rotation = 45)
    plt.tight_layout()

    plt.savefig("variant_counts.png")

    df.to_csv("variant_counts.tsv", index = False)