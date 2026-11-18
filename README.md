# NZ CORDEX ML-Bench Workflow Validation on Setonix

## Overview

This repository contains the scripts and documentation used to reproduce and validate the New Zealand (NZ) CORDEX ML-Bench workflow on the Pawsey Setonix supercomputer.

The objective was to independently reproduce the benchmark workflow, identify reproducibility issues, and validate all execution paths.

## Environment

### HPC System
Pawsey Setonix

### Python Environment

Environment name:

cordex_myenv

Environment path:

/software/projects/y98/dgadiraju/environments/cordex_myenv

### Working Directory

/scratch/y98/dgadiraju/CORDEX_TESTING

---

## Workflow Validation

### CPU Training

```bash
sbatch train_nz.slurm
```

Status: PASS

Job ID: 53341663

### GPU Training

```bash
sbatch train_nz_gpu.slurm
```

Status: PASS

Job ID: 53346648

### CPU Submission

```bash
sbatch submission_nz.slurm
```

Status: PASS

Job ID: 53342353

### GPU Submission

```bash
sbatch submission_nz_gpu.slurm
```

Status: PASS

Job ID: 53346904

### GPU + NVMe Submission

```bash
sbatch submission_nz_gpu_nvme.slurm
```

Status: PASS

Job ID: 53348535

### Evaluation

```bash
python evaluate_nz.py
```

Status: PASS

Generated:

```text
nz_benchmark_summary.csv
```

---

## Outputs Generated

### Trained Models

```text
DeepESD_ESD_pseudo_reality_NZ_pr.pt
DeepESD_ESD_pseudo_reality_NZ_tasmax.pt
DeepESD_Emulator_hist_future_NZ_pr.pt
DeepESD_Emulator_hist_future_NZ_tasmax.pt
```

### Prediction Outputs

```text
Predictions_pr_tasmax_*.nc
```

### Submission Package

`*`text
emulator_id.zip*```

### Evaluation Results

```te*t
nz_benchmark_summary.csv
```

--*

## Reproducibility Issues Ident*fied

1. Hardcoded data paths*
2. Hardcoded model*paths.
3. Hardcoded output*paths.
4. Hardcoded*environment activation paths.
5. I*correct*PyTorch module version.
6. Missing*template dependency in submission.*y.
7. Missing Python dependency (t*dm).

---

## Validation Summary

*he complete NZ CORDEX ML-Bench wor*flow was successfully reproduced o* Setonix.

Workflow:

Training
↓
M*del Generation
↓
Submission Genera*ion
↓
Prediction Outputs
↓
emulato*_id.zip
↓
Evaluation
↓
nz_benchmar*_summary.csv*
All CPU, GPU, and GPU+NVMe execut*on paths completed successfully.

*--

## Author

Dhanush Gadiraju

D*ER-WA Internship Project

*Z CORDEX ML-Bench Workflow Re*roducibility Validation
``*
