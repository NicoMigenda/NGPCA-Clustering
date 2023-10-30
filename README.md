<h3 align="center">NGPCA: Clustering high-dimensional and non-stationary data streams</h3>
Local PCA Clustering for streaming and high-dimensional data distributions. 
This repo serves to reproduce the results from the publication: Adaptive local Principal Component Analysis improves the clustering of high-dimensional data.
Please cite this code using the following DOI: https://doi.org/10.1016/j.patcog.2023.110030

# Table of contents
- [Quick start](#quick-start)
- [What's included](#whats-included)
- [Getting Started](#getting-started)
- [Creators](#creators)
- [Visualizations](#visualizations)

## Quick start

Get started by downloading the latest release:

- [Download the latest release](https://github.com/NicoMigenda/NGPCA-Clustering/archive/refs/tags/NGPCA.zip)
- Clone the repo: `git clone https://github.com/NicoMigenda/NGPCA-Clustering.git`

## What's included

Within the download you'll find the following directories and files:

<details>
  <summary>Download contents</summary>

  ```text
  |-- Example.m
|-- Example_Live.mlx
|-- README.md
|-- Results
|   `-- gif
|       |-- s1_G_AR_S_V.gif
|       |-- s2_G_AR_S_V.gif
|       |-- s3_G_AR_S_V.gif
|       |-- s4_G_AR_S_V.gif
|-- data_sets_combined
|   |-- a1.mat
|   |-- a2.mat
|   |-- a3.mat
|   |-- b1.mat
|   |-- b2.mat
|   |-- h128.mat
|   |-- h256.mat
|   |-- h32.mat
|   |-- h512.mat
|   |-- h64.mat
|   |-- s1.mat
|   |-- s2.mat
|   |-- s3.mat
|   |-- s4.mat
|   `-- u1.mat
`-- ngpca
    |-- NGPCA.m
    |-- drawunits.m
    |-- eforrlsa.m
    |-- init.m
    |-- normalizedmi.m
    |-- plot_ellipse.m
    |-- potentialFunction.m
    |-- update.m
    |-- validate_CI.m
    `-- validate_NMI_DU.m
  ```
</details>

## Getting Started

The latest release contains all files needed to directly run the algorithm:

1. Open `Example.m` or `Example.mlx` in Matlab
2. Compiling the script will automatically perform NGPCA Clustering on the S1 data set with standard settings

Optional:

3. Change default settings or add optional parameters to the ngpca object creation or for the training process
4. Train the model directly on a full data set using the `fit_multiple()` function or build your own training loops with `fit_single()`
5. Visualize the clustering results with the `draw()` function
6. Calculate validation metrics (CI, NMI, DU) by provding ground thruth and cluster shape information

## Visualizations
The following visualizations represent the learning process on selected data sets of the standard clustering benchmark database. For all data sets the default settings are used.
### Data set S1
![N1-G-V-H-V_s1](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/s1_G_AR_S_V.gif)
### Data set S2
![N1-G-V-H-V_s2](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/s2_G_AR_S_V.gif)
### Data set S3
![N1-G-V-H-V_s3](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/s3_G_AR_S_V.gif)
### Data set S4
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/s4_G_AR_S_V.gif)

## Creators

Nico Migenda

Ralf Möller

Wolfram Schenck
