#!/bin/bash
#SBATCH --job-name=cordex_nz_train
#SBATCH --account=y98
#SBATCH --partition=work
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --output=/scratch/y98/dgadiraju/CORDEX_TESTING/logs/train_nz_%j.out
#SBATCH --error=/scratch/y98/dgadiraju/CORDEX_TESTING/logs/train_nz_%j.err
echo "========================================"
echo "CORDEX ML-Bench NZ Training"
echo "Started: $(date)"
echo "Node: $(hostname)"
echo "========================================"

module load pawseyenv/2025.08
module load pytorch/2.7.1-rocm6.3.3

pytorch-exec bash -c "
source /software/projects/y98/dgadiraju/environments/cordex_myenv/bin/activate
echo 'Python:'
which python

python -c '
import torch
import xarray
import pandas
import netCDF4
import matplotlib
import cartopy

print(\"Environment validation passed\")
print(\"Torch:\", torch.__version__)
print(\"CUDA available:\", torch.cuda.is_available())
'

cd /scratch/y98/dgadiraju/CORDEX_TESTING/scripts

python training.py
"

echo "========================================"
echo "Finished: $(date)"
echo "========================================"
