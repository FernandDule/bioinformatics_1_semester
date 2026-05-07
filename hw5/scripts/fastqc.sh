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
SCRIPTS_DIR="${BASE_DIR}/scripts"
RESULTS_DIR="${BASE_DIR}/results"
FASTQC_DIR="${RESULTS_DIR}/fastqc"
MULTIQC_DIR="${RESULTS_DIR}/multiqc"
LOGS_DIR="${BASE_DIR}/logs"


mkdir -p "${DATA_DIR}" \
         "${SCRIPTS_DIR}" \
         "${FASTQC_DIR}" \
         "${MULTIQC_DIR}" \
         "${LOGS_DIR}"

cd "${DATA_DIR}"

curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR142/086/ERR14230586/ERR14230586.fastq.gz -o ERR14230586_Illumina_HiSeq_4000_sequencing.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR142/083/ERR14230583/ERR14230583.fastq.gz -o ERR14230583_Illumina_HiSeq_4000_sequencing.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR142/087/ERR14230587/ERR14230587.fastq.gz -o ERR14230587_Illumina_HiSeq_4000_sequencing.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR142/008/ERR14230608/ERR14230608.fastq.gz -o ERR14230608_Illumina_HiSeq_4000_sequencing.fastq.gz


FASTQ_FILES=("${DATA_DIR}"/*.fastq.gz)

fastqc "${FASTQ_FILES[@]}" --outdir "${FASTQC_DIR}" --extract 2>&1 | tee "${LOGS_DIR}/fastqc.log"

multiqc \
    "${FASTQC_DIR}" \
    --outdir "${MULTIQC_DIR}" \
    --filename "multiqc_report_PRJEB84057" \
    --title "QC Report: PRJEB84057 (Illumina HiSeq 4000)" \
    --comment "Samples: ERR14230586, ERR14230583, ERR14230587, ERR14230608" \
    2>&1 | tee "${LOGS_DIR}/multiqc.log"

