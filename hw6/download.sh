#!/bin/bash
#SBATCH --job-name=star_index
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=06:00:00
#SBATCH --output=/home/STUDY/FBMF/studfbmf02_10/hw6/star_index%j.log
#SBATCH --partition=E5-2630-TITAN_X

REF_DIR="/home/STUDY/FBMF/studfbmf02_10/hw6/ref"
mkdir -p ${REF_DIR}/downloads
mkdir -p ${REF_DIR}/STAR_index

# Скачать FASTA
wget -c https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
    -O ${REF_DIR}/downloads/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz

# Скачать GTF
wget -c https://ftp.ensembl.org/pub/release-110/gtf/homo_sapiens/Homo_sapiens.GRCh38.110.gtf.gz \
    -O ${REF_DIR}/downloads/Homo_sapiens.GRCh38.110.gtf.gz

# Распаковать
gunzip -k ${REF_DIR}/downloads/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
gunzip -k ${REF_DIR}/downloads/Homo_sapiens.GRCh38.110.gtf.gz

# Построить индекс STAR
source /home/STUDY/FBMF/bioinformatics/anaconda3/etc/profile.d/conda.sh
conda activate bioinf

STAR \
    --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir ${REF_DIR}/STAR_index \
    --genomeFastaFiles ${REF_DIR}/downloads/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
    --sjdbGTFfile ${REF_DIR}/downloads/Homo_sapiens.GRCh38.110.gtf \
    --sjdbOverhang 74

echo "Index Done"
EOF
