#!/bin/bash

#SBATCH --job-name=fsatqc
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw5/fastqc%j.log
#SBATCH --partition=E5-2630-TITAN_X

BASE_DIR="$HOME/hw5"
TRIMMED_DIR="${BASE_DIR}/data/trimmed"
FASTQC_TRIMMED_DIR="${BASE_DIR}/results/fastqc_trimmed"
MULTIQC_TRIMMED_DIR="${BASE_DIR}/results/multiqc_trimmed"
LOGS_DIR="${BASE_DIR}/logs"

mkdir -p "${FASTQC_TRIMMED_DIR}" "${MULTIQC_TRIMMED_DIR}"

FASTQ_FILES=("${TRIMMED_DIR}"/*.fastq.gz)

fastqc "${FASTQ_FILES[@]}" \
    --outdir "${FASTQC_TRIMMED_DIR}" \
    --extract \
    --thread 4 \
    2>&1 | tee "${LOGS_DIR}/fastqc_trimmed.log"

multiqc \
    "${FASTQC_TRIMMED_DIR}" \
    --outdir "${MULTIQC_TRIMMED_DIR}" \
    --filename "multiqc_report_trimmed_PRJEB84057" \
    --title "QC Report after trimming: PRJEB84057 (Illumina HiSeq 4000)" \
    --comment "Samples after fastp trimming: ERR14230586, ERR14230583, ERR14230587, ERR14230608" \
    2>&1 | tee "${LOGS_DIR}/multiqc_trimmed.log"
