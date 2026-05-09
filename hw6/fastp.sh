#!/bin/bash
#SBATCH --job-name=fastp_paired
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw6/fastp%j.log
#SBATCH --partition=E5-2630-TITAN_X

source /home/STUDY/FBMF/bioinformatics/anaconda3/etc/profile.d/conda.sh
conda activate bioinf

TRIMMED_DIR="/home/STUDY/FBMF/studfbmf02_10/hw6/data/trimmed_paired"
REPORTS_DIR="/home/STUDY/FBMF/studfbmf02_10/hw6/results/fastp"
mkdir -p $TRIMMED_DIR $REPORTS_DIR

fastp \
    -i /home/STUDY/FBMF/bioinformatics/rnaseq_map_star/raw_data/Eg_Treg_S71_R1_001.fastq.gz \
    -I /home/STUDY/FBMF/bioinformatics/rnaseq_map_star/raw_data/Eg_Treg_S71_R2_001.fastq.gz \
    -o ${TRIMMED_DIR}/Eg_Treg_S71_R1_trimmed.fastq.gz \
    -O ${TRIMMED_DIR}/Eg_Treg_S71_R2_trimmed.fastq.gz \
    --cut_right \
    --cut_window_size 5 \
    --cut_mean_quality 20 \
    --length_required 36 \
    --thread 8 \
    --html ${REPORTS_DIR}/fastp.html \
    --json ${REPORTS_DIR}/fastp.json

echo "fastp Done"
