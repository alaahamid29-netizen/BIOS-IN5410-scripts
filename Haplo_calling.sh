#!/bin/bash
#SBATCH --job-name=HaploCaller
#SBATCH --account=ec34
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=02:00:00
#SBATCH --mem=4G
#SBATCH --output=slurm-%j.out

set -o errexit
set -o nounset

module --quiet purge
module load BIOS-IN5410/HT-2023

# The script expects the first argument to be the BAM filename
FILENAME="$1"

# Create gvcf directory in submit dir (safe)
mkdir -p $SUBMITDIR/gvcf

# Run GATK HaplotypeCaller producing a gvcf for this file
gatk HaplotypeCaller -R Orosv1mt.fasta \
  -I "$FILENAME" --ploidy 1 -O gvcf/"$FILENAME".gvcf.gz -ERC GVCF \
  2> gvcf/HaploCaller_"$FILENAME".out

echo "$FILENAME HaplotypeCalled"
