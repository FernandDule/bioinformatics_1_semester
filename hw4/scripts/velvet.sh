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

for K in 31 41 51 61; do
    echo "Запуск Velvet k=${K}"
    mkdir -p ${OUTDIR}/k${K}
    $VELVET/velveth ${OUTDIR}/k${K} ${K} -fastq -shortPaired -separate $R1 $R2
    $VELVET/velvetg ${OUTDIR}/k${K} -ins_length 300
done
