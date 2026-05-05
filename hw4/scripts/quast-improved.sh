#!/bin/bash
#SBATCH --job-name=quast
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw4/quast_%j.log
#SBATCH --partition=E5-2630-TITAN_X

QUAST=/home/STUDY/FBMF/bioinformatics/soft/bin/quast.py

VELVET_K51=/home/STUDY/FBMF/studfbmf02_10/hw4/k51/contigs.fa
VELVET_IMPROVED=/home/STUDY/FBMF/studfbmf02_10/hw4/k51_improved/contigs.fa

SPADES_K61=/home/STUDY/FBMF/studfbmf02_10/hw4/spades_k61/contigs.fasta
SPADES_IMPROVED=/home/STUDY/FBMF/studfbmf02_10/hw4/spades_improved/contigs.fasta

OUTDIR=/home/STUDY/FBMF/studfbmf02_10/hw4/quast_final

python $QUAST \
    $VELVET_K51 \
    $VELVET_IMPROVED \
    $SPADES_K61 \
    $SPADES_IMPROVED \
    -o $OUTDIR \
    --labels "Velvet_k51,Velvet_improved,SPAdes_k61,SPAdes_improved" \
    --threads 8 \
    --min-contig 200
