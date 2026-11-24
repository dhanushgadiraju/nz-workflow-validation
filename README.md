# NZ CORDEX ML-Bench Workflow Validation and Climate Diagnostics Extension

## Overview

This repository documents my independent reproduction and validation of the New Zealand (NZ) CORDEX ML-Bench workflow on the Pawsey Setonix supercomputer.

The original NZ benchmark workflow was developed by Jincy Jis Kanichai and Omer Mughal. This work focuses on:

- Reproducing the workflow in an independent environment.
- Validating CPU, GPU and GPU+NVMe execution paths.
- Identifying reproducibility issues.
- Exploring additional climate diagnostics available within the benchmark framework.

---

## Validation Objectives

The objectives of this work were to:

- Understand and reproduce the existing NZ benchmark workflow.
- Validate workflow execution in an independent user environment.
- Verify training, submission and evaluation outputs.
- Identify workflow dependencies and reproducibility challenges.
- Explore additional climate-focused evaluation metrics.

---

## Environment

### HPC System

Pawsey Supercomputing Centre – Setonix

### Python Environment

```text
/software/projects/y98/dgadiraju/environments/cordex_myenv
```

### Working Directory

```text
/scratch/y98/dgadiraju/CORDEX_TESTING
```

---

## Workflow Components

### Training

Scripts:

```text
training.py
train_nz.slurm
train_nz_gpu.slurm
```

Generated outputs:

```text
DeepESD_ESD_pseudo_reality_NZ_pr.pt
DeepESD_ESD_pseudo_reality_NZ_tasmax.pt
DeepESD_Emulator_hist_future_NZ_pr.pt
DeepESD_Emulator_hist_future_NZ_tasmax.pt
```

---

### Submission

Scripts:

```text
submission.py
submission_nz.slurm
submission_nz_gpu.slurm
submission_nz_gpu_nvme.slurm
```

Generated outputs:

```text
Prediction NetCDF files
emulator_id.zip
```

---

### Evaluation

Scripts:

```text
evaluate_nz.py
evaluate_nz_extended.py
```

Generated outputs:

```text
nz_benchmark_summary.csv
nz_benchmark_summary_climate_extended.csv
```

---

## Validation Results

| Workflow | Status |
|-----------|----------|
| CPU Training | PASS |
| GPU Training | PASS |
| CPU Submission | PASS |
| GPU Submission | PASS |
| GPU + NVMe Submission | PASS |
| Evaluation Workflow | PASS |

---

## Performance Comparison

| Workflow | Runtime |
|-----------|----------|
| CPU Training | 4m 54s |
| GPU Training | ~7s |
| CPU Submission | 18m 56s |
| GPU Submission | 13m 34s |

### Observation

GPU execution reduced runtime significantly compared with CPU execution.

The GPU + NVMe workflow provided the fastest submission execution due to local NVMe staging and reduced filesystem overhead.

---

## Experimental Climate Diagnostics

The original benchmark summary includes:

```text
RMSE
Mean Bias
TXx Bias
RX1day Bias
SDII Bias
```

An experimental evaluation workflow was developed to investigate additional climate diagnostics already implemented within `indices.py`.

Additional diagnostics evaluated:

| Metric | Description |
|----------|----------|
| CDD | Consecutive Dry Days |
| CWD | Consecutive Wet Days |
| SU | Summer Days |

### Purpose

These metrics provide additional information regarding:

- Dry spell characteristics
- Wet spell persistence
- Frequency of hot days

which are important indicators of climate extremes.

### Extended Evaluation Output

The experimental evaluation generates:

```text
nz_benchmark_summary_climate_extended.csv
```

Additional columns:

```text
cdd_bias
cwd_bias
su_bias
```

These metrics are provided for investigation and discussion and are not intended to replace the existing benchmark methodology.

---

## Reproducibility Issues Identified

During validation the following issues were encountered:

- Hardcoded data paths
- Hardcoded model paths
- Hardcoded environment references
- Missing workflow dependencies
- Incorrect module references within GPU workflows

These issues were resolved as part of workflow validation.

---

## Acknowledgements

The original NZ CORDEX ML-Bench workflow, benchmark design and implementation were developed by:

- Jincy Jis Kanichai
- Omer Mughal

This repository documents independent workflow validation, testing, and exploratory evaluation conducted on Setonix.

---

## Author

Dhanush Gadiraju

DWER-WA Internship Project

Setonix Workflow Validation and Reproducibility Testing
