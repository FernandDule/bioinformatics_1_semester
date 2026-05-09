#!/bin/bash

#SBATCH --job-name=fsatqc
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw5/fastqc%j.log
#SBATCH --partition=E5-2630-TITAN_X

BASE_DIR="$HOME/hw6"
RESULTS_DIR="${BASE_DIR}/results"
FASTQC_DIR="${RESULTS_DIR}/fastqc_trimmed"
MULTIQC_DIR="${RESULTS_DIR}/multiqc_trimmed"
LOGS_DIR="${BASE_DIR}/logs"


mkdir -p "${FASTQC_DIR}" \
         "${MULTIQC_DIR}" \
         "${LOGS_DIR}"


fastqc "${BASE_DIR}/data/trimmed/"*.gz -outdir "${FASTQC_DIR}" --extract 2>&1 | tee "${LOGS_DIR}/fastqc.log"

multiqc \
    "${FASTQC_DIR}" \
    --outdir "${MULTIQC_DIR}" \
    --filename "multiqc_report_Eg_Treg_S71" \
    --title "QC Report: Eg_Treg_S71" \
    --comment "Samples: R1_001, R2_001" \
    2>&1 | tee "${LOGS_DIR}/multiqc.log"
~                                           
