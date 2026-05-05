#!/bin/bash
#SBATCH --job-name=spades
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw4/spades_k_%j.log
#SBATCH --partition=E5-2630-TITAN_X

SPADES=/home/STUDY/FBMF/bioinformatics/soft/SPAdes-4.2.0-Linux/bin/spades.py
R1=/home/STUDY/FBMF/studfbmf02_10/sem10/genome_de_novo/7_S4_L001_R1_001.fastq
R2=/home/STUDY/FBMF/studfbmf02_10/sem10/genome_de_novo/7_S4_L001_R2_001.fastq
OUTDIR=/home/STUDY/FBMF/studfbmf02_10/hw4

for K in 31 41 51 61; do
    echo "Запуск SPAdes с k-mer = ${K}"
    mkdir -p ${OUTDIR}/spades_k${K}
    $SPADES \
        -1 $R1 \
        -2 $R2 \
        -o ${OUTDIR}/spades_k${K} \
        --threads $SLURM_CPUS_PER_TASK \
        --memory 32 \
        -k ${K}
done
