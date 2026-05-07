#!/bin/bash

#SBATCH --job-name=fsatqc
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw5/fastqc%j.log
#SBATCH --partition=E5-2630-TITAN_X

BASE_DIR="$HOME/hw5"
DATA_DIR="${BASE_DIR}/data/raw"
TRIMMED_DIR="${BASE_DIR}/data/trimmed"
FASTP_REPORTS_DIR="${BASE_DIR}/results/fastp"

mkdir -p "${TRIMMED_DIR}" "${FASTP_REPORTS_DIR}"

for INPUT in "${DATA_DIR}"/*.fastq.gz; do

    SAMPLE=$(basename "${INPUT}" .fastq.gz)

    fastp \
        -i "${INPUT}" \
        -o "${TRIMMED_DIR}/${SAMPLE}_trimmed.fastq.gz" \
        --cut_right \
        --cut_window_size 5 \
        --cut_mean_quality 20 \
        --length_required 36 \
        --thread 4 \
        --html "${FASTP_REPORTS_DIR}/${SAMPLE}_fastp.html" \
        --json "${FASTP_REPORTS_DIR}/${SAMPLE}_fastp.json" \
        2>&1 | tee "${LOGS_DIR}#SBATCH --job-name=fsatqc"

done
