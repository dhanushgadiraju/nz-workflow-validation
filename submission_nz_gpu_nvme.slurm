#!/bin/bash

#SBATCH --job-name=submission_nz_gpu_nvme
#SBATCH --account=y98-gpu
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=02:00:00

#SBATCH --output=/scratch/y98/dgadiraju/CORDEX_TESTING/logs/submission_nz_gpu_nvme_%j.out
#SBATCH --error=/scratch/y98/dgadiraju/CORDEX_TESTING/logs/submission_nz_gpu_nvme_%j.err

echo "========================================"
echo "Started: $(date)"
echo "Node: $(hostname)"
echo "TMPDIR: $TMPDIR"
echo "========================================"

module load pawseyenv/2025.08
module load pytorch/2.7.1-rocm6.3.3

# --------------------------------------------------
# Create local NVMe workspace
# --------------------------------------------------

mkdir -p $TMPDIR/NZ_run
mkdir -p $TMPDIR/NZ_run/models
mkdir -p $TMPDIR/NZ_run/results

echo "Copying NZ dataset to NVMe..."

cp -r \
/scratch/y98/dgadiraju/CORDEX_TESTING/NZ_data/NZ_domain \
$TMPDIR/NZ_run/

echo "Copying trained models to NVMe..."

cp -r \
/scratch/y98/dgadiraju/CORDEX_TESTING/models/* \
$TMPDIR/NZ_run/models/

echo "Copying submission script..."

cp \
/scratch/y98/dgadiraju/CORDEX_TESTING/scripts/submission.py \
$TMPDIR/NZ_run/submission.py

# --------------------------------------------------
# Patch paths in local copy of submission.py
# --------------------------------------------------

sed -i "s|DATA_PATH = .*|DATA_PATH = '$TMPDIR/NZ_run'|" \
$TMPDIR/NZ_run/submission.py

sed -i "s|MODELS_PATH = .*|MODELS_PATH = '$TMPDIR/NZ_run/models'|" \
$TMPDIR/NZ_run/submission.py

sed -i "s|OUTPUT_BASE = .*|OUTPUT_BASE = '$TMPDIR/NZ_run/results'|" \
$TMPDIR/NZ_run/submission.py

echo "Patched submission.py paths:"

grep "DATA_PATH" $TMPDIR/NZ_run/submission.py
grep "MODELS_PATH" $TMPDIR/NZ_run/submission.py
grep "OUTPUT_BASE" $TMPDIR/NZ_run/submission.py

# --------------------------------------------------
# Execute submission workflow
# --------------------------------------------------

echo "Running submission workflow from NVMe..."

pytorch-exec bash -c "

source /software/projects/y98/dgadiraju/environments/cordex_myenv/bin/activate

python $TMPDIR/NZ_run/submission.py

"

# --------------------------------------------------
# Copy outputs back to scratch
# --------------------------------------------------

echo "Copying results back to scratch..."

mkdir -p \
/scratch/y98/dgadiraju/CORDEX_TESTING/results_nvme

cp -r \
$TMPDIR/NZ_run/results/* \
/scratch/y98/dgadiraju/CORDEX_TESTING/results_nvme/

echo "Results copied to:"
echo "/scratch/y98/dgadiraju/CORDEX_TESTING/results_nvme"

echo "========================================"
echo "Finished: $(date)"
echo "========================================"

