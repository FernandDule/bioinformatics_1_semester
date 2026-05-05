#!/bin/bash
#SBATCH --job-name=quast
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=08:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw4/quast_%j.log
#SBATCH --partition=E5-2630-TITAN_X

QUAST=/home/STUDY/FBMF/bioinformatics/soft/bin/quast.py

VELVET_K31=/home/STUDY/FBMF/studfbmf02_10/hw4/k31/contigs.fa
VELVET_K41=/home/STUDY/FBMF/studfbmf02_10/hw4/k41/contigs.fa
VELVET_K51=/home/STUDY/FBMF/studfbmf02_10/hw4/k51/contigs.fa
VELVET_K61=/home/STUDY/FBMF/studfbmf02_10/hw4/k61/contigs.fa


SPADES_K31=/home/STUDY/FBMF/studfbmf02_10/hw4/spades_k31/contigs.fasta
SPADES_K41=/home/STUDY/FBMF/studfbmf02_10/hw4/spades_k41/contigs.fasta
SPADES_K51=/home/STUDY/FBMF/studfbmf02_10/hw4/spades_k51/contigs.fasta
SPADES_K61=/home/STUDY/FBMF/studfbmf02_10/hw4/spades_k61/contigs.fasta



OUTDIR=/home/STUDY/FBMF/studfbmf02_10/hw4/quast
python $QUAST \
    $VELVET_K31 \
    $VELVET_K41 \
    $VELVET_K51 \
    $VELVET_K61 \
    $SPADES_K31 \
    $SPADES_K41 \
    $SPADES_K51 \
    $SPADES_K61\
    -o $OUTDIR \
    --labels "Velvet_k31,Velvet_k41,Velvet_k51,Velvet_k61,SPAdes_k31, SPAdes_k41, SPAdes_k51, SPAdes_k61" \
    --threads 8 \
    --min-contig 200 


