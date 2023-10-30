<h3 align="center">NGPCA Clustering</h3>
Local PCA Clustering for streaming and high-dimensional data distributions.
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
|       |-- a1_G_AR_S_V.gif
|       |-- a2_G_AR_S_V.gif
|       |-- a3_G_AR_S_V.gif
|       |-- b1_G_AR_S_V.gif
|       |-- b2_G_AR_S_V.gif
|       |-- b3_G_AR_S_V.gif
|       |-- h1_G_AR_S_V.gif
|       |-- h2_G_AR_S_V.gif
|       |-- h3_G_AR_S_V.gif
|       |-- h5_G_AR_S_V.gif
|       |-- h6_G_AR_S_V.gif
|       |-- s1_G_AR_S_V.gif
|       |-- s2_G_AR_S_V.gif
|       |-- s3_G_AR_S_V.gif
|       |-- s4_G_AR_S_V.gif
|       `-- u1_G_AR_S_V.gif
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

1. Open `NGPCA_Learningrate.m` in Matlab
2. Compiling the script will automatically perform NGPCA Clustering on the S1 data set with standard settings

Optional:

3. Open `Extra_Functions\Init.m`
4. Change the data set to one containted in `data sets\`
5. Adjust the model parameters (e.g. initial learning rate or activity)
6. Adjust the potential function or learning rate algorithm

## Visualizations
The following visualizations represent the learning process on selected data sets of the standard clustering benchmark database. For all 4 presented data sets, the *N1-G-V-H-V* learning combination is used.
### Data set S1
![N1-G-V-H-V_s1](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/s1_G_AR_S_V.gif)
### Data set S2
![N1-G-V-H-V_s2](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/s2_G_AR_S_V.gif)
### Data set S3
![N1-G-V-H-V_s3](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/s3_G_AR_S_V.gif)
### Data set S4
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/s4_G_AR_S_V.gif)
### Data set A1
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/a1_G_AR_S_V.gif)
### Data set A2
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/a2_G_AR_S_V.gif)
### Data set A3
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/a3_G_AR_S_V.gif)
### Data set U1
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/u1_G_AR_S_V.gif)
### Data set B1
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/b1_G_AR_S_V.gif)
### Data set B2
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/b2_G_AR_S_V.gif)
### Data set B3
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/b3_G_AR_S_V.gif)
### Data set H32
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/h32_G_AR_S_V.gif)
### Data set H64
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/h64_G_AR_S_V.gif)
### Data set H128
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/h128_G_AR_S_V.gif)
### Data set H256
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/h256_G_AR_S_V.gif)
### Data set H512
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/h512_G_AR_S_V.gif)
### Data set H1024
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/Results/gif/h1024_G_AR_S_V.gif)

## Creators

Nico Migenda

Ralf Möller

Wolfram Schenck
