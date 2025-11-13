#!/bin/bash
#SBATCH --job-name=HaploCaller
#SBATCH --output=slurm-%j.out
#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --account=ec34

# Load module environment
module load BIOS-IN5410/HT-2023

# FILENAME is the first argument provided to sbatch
FILENAME="$1"

# Make gvcf directory in the submit folder
mkdir -p $SUBMITDIR/gvcf

# Run HaplotypeCaller
gatk HaplotypeCaller -R Orosv1mt.fasta \
    -I $FILENAME --ploidy 1 \
    -O gvcf/$FILENAME.gvcf.gz \
    -ERC GVCF \
    2> gvcf/HaploCaller_$FILENAME.out

echo "$FILENAME HaplotypeCalled"
