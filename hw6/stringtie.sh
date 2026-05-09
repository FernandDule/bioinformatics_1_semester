#!/bin/bash
#SBATCH --job-name=stringtie
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=01:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw6/stringtie%j.log
#SBATCH --partition=E5-2630-TITAN_X

source /home/STUDY/FBMF/bioinformatics/anaconda3/etc/profile.d/conda.sh
conda activate bioinf

BAM="/home/STUDY/FBMF/studfbmf02_10/hw6/star_alignment/RNA_Aligned.sortedByCoord.out.bam"
OUTDIR="/home/STUDY/FBMF/studfbmf02_10/hw6/stringtie_out"
mkdir -p $OUTDIR

stringtie $BAM \
  -o $OUTDIR/transcripts.gtf \
  -p $SLURM_CPUS_PER_TASK

echo "StringTie Done"
