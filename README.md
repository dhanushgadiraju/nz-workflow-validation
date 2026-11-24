NZ CORDEX ML-Bench Workflow Validation on Setonix
Overview

This repository documents the successful reproduction and validation of the New Zealand (NZ) CORDEX ML-Bench workflow on the Pawsey Setonix supercomputer.

The objective of this work was to independently execute the benchmark workflow, verify reproducibility, identify environment and dependency issues, and validate all supported execution pathways. The workflow was successfully executed across CPU, GPU, and GPU+NVMe configurations, producing all expected benchmark outputs and evaluation results.

System Environment
HPC Platform

Pawsey Setonix Supercomputer

Python Environment

Environment Name:

Shell
cordex_myenv

Environment Location:

Shell
/software/projects/y98/dgadiraju/environments/cordex_myenv
Working Directory
Shell
/scratch/y98/dgadiraju/CORDEX_TESTING
Workflow Architecture
Plain Text
Input Climate Data
│
▼
Training
│
▼
Model Generation
│
▼
Submission Generation
│
▼
Prediction Outputs
│
▼
Submission Package
│
▼
Evaluation
│
▼
Benchmark Summary Report
Validation Results
CPU Training

Command:

Shell
sbatch train_nz.slurm

Status: PASS

Job ID:

Plain Text
53341663
GPU Training

Command:

Shell
sbatch train_nz_gpu.slurm

Status: PASS

Job ID:

Plain Text
53346648
CPU Submission

Command:

Shell
sbatch submission_nz.slurm

Status: PASS

Job ID:

Plain Text
53342353
GPU Submission

Command:

Shell
sbatch submission_nz_gpu.slurm

Status: PASS

Job ID:

Plain Text
53346904
GPU + NVMe Submission

Command:

Shell
sbatch submission_nz_gpu_nvme.slurm

Status: PASS

Job ID:

Plain Text
53348535
Evaluation

Command:

Shell
python evaluate_nz.py

Status: PASS

Generated Output:

Plain Text
nz_benchmark_summary.csv
Outputs Generated
Trained Models
Plain Text
DeepESD_ESD_pseudo_reality_NZ_pr.pt
 
DeepESD_ESD_pseudo_reality_NZ_tasmax.pt
 
DeepESD_Emulator_hist_future_NZ_pr.pt
 
DeepESD_Emulator_hist_future_NZ_tasmax.pt
Prediction Outputs
Plain Text
Predictions_pr_tasmax_*.nc
Submission Package
Plain Text
emulator_id.zip
Evaluation Results
Plain Text
nz_benchmark_summary.csv
Reproducibility Issues Identified

During workflow validation, several issues affecting portability and reproducibility were identified and resolved.

Hardcoded Data Paths

Several scripts referenced absolute dataset locations tied to a specific user environment. Manual updates were required before workflow execution.

Hardcoded Model Paths

Model save and load locations were embedded directly within workflow scripts, reducing portability across systems.

Hardcoded Output Paths

Output directories were predefined within scripts and required modification for execution on Setonix.

Hardcoded Environment Activation Paths

Environment setup commands referenced user-specific locations and needed adjustment for independent deployment.

PyTorch Version Mismatch

The workflow required a compatible PyTorch version that differed from the initially loaded module.

Missing Template Dependency

Required template files referenced by the submission workflow were not available in the expected location.

Missing Python Dependency

The Python package tqdm was missing from the environment and required installation prior to execution.

Validation Summary

The complete NZ CORDEX ML-Bench workflow was successfully reproduced and validated on Setonix.

Workflow Component	Status
CPU Training	PASS
GPU Training	PASS
CPU Submission	PASS
GPU Submission	PASS
GPU + NVMe Submission	PASS
Evaluation	PASS

All execution pathways completed successfully and produced the expected outputs without modification to the scientific workflow logic.

Key Achievements
Successfully reproduced the NZ CORDEX ML-Bench workflow on Setonix.
Validated CPU training and submission workflows.
Validated GPU training and submission workflows.
Validated GPU + NVMe execution workflows.
Generated benchmark prediction outputs.
Produced benchmark submission packages.
Successfully completed benchmark evaluation.
Identified and documented reproducibility limitations.
Resolved dependency and environment configuration issues.
Established a repeatable workflow validation process for future users.
Future Recommendations

To improve workflow portability and reproducibility, the following enhancements are recommended:

Replace hardcoded paths with configuration files.
Use environment variables for system-specific settings.
Document software dependencies and versions explicitly.
Add automated environment validation checks.
Consider containerised deployment using Apptainer or Singularity.
Introduce automated testing for workflow validation.
Acknowledgements

This work was completed as part of the Department of Water and Environmental Regulation (DWER), Western Australia Internship Program.

The original CORDEX ML-Bench workflow was developed and maintained by Jincy Jis Kanichai. This project focused on independently reproducing, validating, testing, and documenting the New Zealand workflow on the Pawsey Setonix supercomputing platform.

Special thanks to Jincy Jis Kanichai for providing the original workflow, technical guidance, and support throughout the validation process.

Author

Dhanush Gadiraju

Intern Student

Department of Water and Environmental Regulation (DWER), Western Australia

Project Title:

NZ CORDEX ML-Bench Workflow Reproducibility and Validation on Setonix

Year:

2026
