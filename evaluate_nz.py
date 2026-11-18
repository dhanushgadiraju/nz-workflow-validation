"""
Created on 2nd September 2026

Written by:
1. Jincy Jis Kanichai- Jincy.JisKanichai@dwer.wa.gov.au
2. Omer Mughal- Omer.Mughal@dwer.wa.gov.au

About the script:
This script has been made to generate the final nz_benchmark_summary.csv based on the functions from the diagnostics and indices python scripts.

"""


import os
import pandas as pd
import xarray as xr
import diagnostics
import indices

BASE_TARGET = "/scratch/y98/dgadiraju/CORDEX_TESTING/NZ_data/NZ_domain/test"

BASE_PRED = "/scratch/y98/dgadiraju/CORDEX_TESTING/results/submission_files/NZ_Domain"
experiments = [
    "ESD_pseudo_reality",
    "Emulator_hist_future"
]

periods = [
    "historical",
    "mid_century",
    "end_century"
]

conditions = [
    "perfect",
    "imperfect"
]

gcms = {
    "historical": [
        ("ACCESS-CM2", "1981-2000"),
        ("EC-Earth3", "1981-2000")
    ],
    "mid_century": [
        ("ACCESS-CM2", "2041-2060"),
        ("EC-Earth3", "2041-2060")
    ],
    "end_century": [
        ("ACCESS-CM2", "2080-2099"),
        ("EC-Earth3", "2080-2099")
    ]
}

results = []

for experiment in experiments:
    for period in periods:
        for condition in conditions:
            for gcm, years in gcms[period]:

                target_file = f"{BASE_TARGET}/{period}/target/pr_tasmax_{gcm}_{years}.nc"

                pred_file = (
                    f"{BASE_PRED}/{experiment}/{period}/{condition}/"
                    f"Predictions_pr_tasmax_{gcm}_{years}.nc"
                )

                if not (
                    os.path.exists(target_file)
                    and os.path.exists(pred_file)
                ):
                    continue

                print(
                    f"Processing: {experiment} | "
                    f"{period} | {condition} | {gcm}"
                )

                target = xr.open_dataset(target_file)
                pred = xr.open_dataset(pred_file)

                # RMSE
                rmse_tasmax = diagnostics.rmse(
                    target,
                    pred,
                    var="tasmax",
                    dim="time"
                )

                rmse_pr = diagnostics.rmse(
                    target,
                    pred,
                    var="pr",
                    dim="time"
                )

                # Mean Bias
                mean_bias = diagnostics.bias_index(
                    target,
                    pred,
                    index_fn=indices.mean,
                    var="tasmax"
                )

                # TXx Bias
                txx_bias = diagnostics.bias_index(
                    target,
                    pred,
                    index_fn=indices.txx,
                    var="tasmax"
                )

                # RX1day Bias
                rx1day_bias = diagnostics.bias_index(
                    target,
                    pred,
                    index_fn=indices.rx1day,
                    var="pr"
                )

                # SDII Bias
                sdii_bias = diagnostics.bias_index(
                    target,
                    pred,
                    index_fn=indices.sdii,
                    var="pr"
                )

                results.append({
                    "experiment": experiment,
                    "period": period,
                    "condition": condition,
                    "gcm": gcm,

                    "rmse_tasmax":
                        rmse_tasmax["tasmax"].mean().item(),

                    "rmse_pr":
                        rmse_pr["pr"].mean().item(),

                    "mean_bias_tasmax":
                        abs(mean_bias["tasmax"]).mean().item(),

                    "txx_bias":
                        abs(txx_bias["tasmax"]).mean().item(),

                    "rx1day_bias":
                        abs(rx1day_bias["pr"]).mean().item(),

                    "sdii_bias":
                        abs(sdii_bias["pr"]).mean().item()
                })

df = pd.DataFrame(results)

print("\n===== SUMMARY =====")
print(df)

output_csv = "nz_benchmark_summary.csv"

df.to_csv(output_csv, index=False)

print(f"\nSaved: {output_csv}")
