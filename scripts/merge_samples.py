import os
import sys

def merge_samples(samples):
    with open('samples.txt', 'w') as file:
        for sample_path in samples:
            sample_name = os.path.basename(sample_path)
            full_path = os.path.abspath(sample_path)
            file.write(f'{sample_name}\t{full_path}\n')
            
if __name__ == "__main__":
    samples = sys.argv[1:]
    
    merge_samples(samples = samples)