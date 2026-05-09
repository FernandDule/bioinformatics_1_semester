#!/bin/bash
#SBATCH --job-name=htseq_count
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw6/htseq%j.log
#SBATCH --partition=E5-2630-TITAN_X

source /home/STUDY/FBMF/bioinformatics/anaconda3/etc/profile.d/conda.sh
conda activate bioinf

BAM="/home/STUDY/FBMF/studfbmf02_10/hw6/star_alignment/RNA_Aligned.sortedByCoord.out.bam"
GTF="/home/STUDY/FBMF/studfbmf02_10/hw6/ref/downloads/Homo_sapiens.GRCh38.110.gtf"
OUT="/home/STUDY/FBMF/studfbmf02_10/hw6/htseq_counts.txt"

htseq-count \
    --format bam \
    --order pos \
    --stranded no \
    --type exon \
    --idattr gene_id \
    $BAM $GTF > $OUT

echo "HTSeq Done"
