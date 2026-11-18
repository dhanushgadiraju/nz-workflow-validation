#!/bin/bash

# Created on 2nd September 2026

# Written by:
# 1. Jincy Jis Kanichai- Jincy.JisKanichai@dwer.wa.gov.au
# 2. Omer Mughal- Omer.Mughal@dwer.wa.gov.au

# About the script: created to run the submission script using cpu



#!/bin/bash
#SBATCH --job-name=submission_nz
#SBATCH --account=y98
#SBATCH --partition=work
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --output=/scratch/y98/dgadiraju/CORDEX_TESTING/logs/submission_nz_%j.out
#SBATCH --error=/scratch/y98/dgadiraju/CORDEX_TESTING/logs/submission_nz_%j.err
module load pawseyenv/2025.08

module load pytorch/2.7.1-rocm6.3.3


pytorch-exec bash -c "

source /software/projects/y98/dgadiraju/environments/cordex_myenv/bin/activate

cd /scratch/y98/dgadiraju/CORDEX_TESTING/scripts

python submission.py

"
