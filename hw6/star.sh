#!/bin/bash
#SBATCH --job-name=star
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw6/star%j.log
#SBATCH --partition=E5-2630-TITAN_X

source /home/STUDY/FBMF/bioinformatics/anaconda3/etc/profile.d/conda.sh
conda activate bioinf

GENOME_DIR="/home/STUDY/FBMF/studfbmf02_10/hw6/ref/STAR_index"
READS1="/home/STUDY/FBMF/studfbmf02_10/hw6/data/trimmed_paired/Eg_Treg_S71_R1_trimmed.fastq.gz"
READS2="/home/STUDY/FBMF/studfbmf02_10/hw6/data/trimmed_paired/Eg_Treg_S71_R2_trimmed.fastq.gz"
OUTPUT_DIR="/home/STUDY/FBMF/studfbmf02_10/hw6/star_alignment"

mkdir -p $OUTPUT_DIR

STAR \
  --runThreadN 8 \
  --runMode alignReads \
  --genomeDir $GENOME_DIR \
  --readFilesIn $READS1 $READS2 \
  --readFilesCommand zcat \
  --outFileNamePrefix ${OUTPUT_DIR}/RNA_ \
  --outSAMtype BAM SortedByCoordinate \
  --quantMode GeneCounts

echo "Alignment Done"
