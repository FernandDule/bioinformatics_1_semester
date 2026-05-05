#!/bin/bash
#SBATCH --job-name=velvet_assembly
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw4/velvet_%j.log
#SBATCH --partition=E5-2630-TITAN_X

VELVET=/home/STUDY/FBMF/bioinformatics/soft/velvet
R1=/home/STUDY/FBMF/studfbmf02_10/sem10/genome_de_novo/7_S4_L001_R1_001.fastq
R2=/home/STUDY/FBMF/studfbmf02_10/sem10/genome_de_novo/7_S4_L001_R2_001.fastq
OUTDIR=/home/STUDY/FBMF/studfbmf02_10/hw4

# Улучшенная сборка Velvet с k=51
echo "Запуск улучшенного Velvet k=51"
mkdir -p ${OUTDIR}/k51_improved
$VELVET/velveth ${OUTDIR}/k51_improved 51 -fastq -shortPaired -separate $R1 $R2
$VELVET/velvetg ${OUTDIR}/k51_improved \
    -ins_length 300 \
    -cov_cutoff auto \
    -min_contig_lgth 200
