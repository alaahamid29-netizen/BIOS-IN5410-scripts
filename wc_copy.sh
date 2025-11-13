#!/bin/bash
#SBATCH --job-name=wc_copy
#SBATCH --output=slurm-%j.out
#SBATCH --time=00:01:00
#SBATCH --mem=1G

FILE_NAME="$1"
echo "Working on: $FILE_NAME"
mkdir -p results
# if file doesn't exist, create a fake small file to test
if [ ! -f "$FILE_NAME" ]; then
  echo "Test file for $FILE_NAME" > "$FILE_NAME"
fi
wc -l "$FILE_NAME" > results/"$FILE_NAME".wc
cp results/"$FILE_NAME".wc $SUBMITDIR/ 2>/dev/null || echo "Could not copy to SUBMITDIR (maybe not set in this environment)."
echo "Done with $FILE_NAME"
