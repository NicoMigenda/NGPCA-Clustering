<h3 align="center">NGPCA Clustering</h3>
Local PCA Clustering for streaming and high-dimensional data distributions.

# Table of contents
- [Quick start](#quick-start)
- [What's included](#whats-included)
- [Getting Started](#getting-started)
- [Creators](#creators)
- [Visualizations](#visualizations)
- [Copyright and license](#copyright-and-license)

## Quick start

Get started by downloading the latest release:

- [Download the latest release](https://github.com/NicoMigenda/NGPCA-Clustering/archive/refs/tags/NGPCA.zip)
- Clone the repo: `git clone https://github.com/NicoMigenda/NGPCA-Clustering.git`

## What's included

Within the download you'll find the following directories and files:
<details>
    <summary>Download contents</summary>
```md
|-- Extra_Functions\
|   |-- Init.m
|   |-- centroidIndexMeasure.m
|   |-- drawupdate.m
|   |-- makegif.m
|   |-- memAloc.m
|   |-- normalizedmi.m
|   |-- pickDataset.m
|   |-- plot_ellipse.m
|   |-- saveNet.m
|   `-- unitInit.m
|-- NGPCA_Functions\
|   |-- DOE_DistanceMeasures.m
|   |-- eforrlsa.m
|   |-- init_benchmark.m
|   |-- normalizedmi.m
|   |-- pickDataset.m
|   |-- plot_ellipse.m
|   |-- potentialFunctions.m
|   |-- saveNet.m
|   |-- set_data_distribution.m
|   |-- unit_adaptation.m
|   |-- unit_ranking_order.m
|   |-- vconstTest.m
|   `-- vconstpot.m
|-- NGPCA_Learningrate.m
|-- README.md
|-- Results\
|   |-- V_hard\
|   |   |-- a1_with_gt_V_hard_AR.mat
|   |   |-- a1_with_gt_V_hard_H.mat
|   |   |-- a1_with_gt_V_hard_N.mat
|   |   |-- a1_with_gt_V_hard_VRR.mat
|   |   |-- a2_with_gt_V_hard_AR.mat
|   |   |-- a2_with_gt_V_hard_H.mat
|   |   |-- a2_with_gt_V_hard_N.mat
|   |   |-- a2_with_gt_V_hard_VRR.mat
|   |   |-- a3_with_gt_V_hard_AR.mat
|   |   |-- a3_with_gt_V_hard_H.mat
|   |   |-- a3_with_gt_V_hard_N.mat
|   |   |-- a3_with_gt_V_hard_VRR.mat
|   |   |-- b1_with_gt_V_hard_AR.mat
|   |   |-- b1_with_gt_V_hard_H.mat
|   |   |-- b1_with_gt_V_hard_N.mat
|   |   |-- b1_with_gt_V_hard_VRR.mat
|   |   |-- b2_with_gt_V_hard_AR.mat
|   |   |-- b2_with_gt_V_hard_H.mat
|   |   |-- b2_with_gt_V_hard_N.mat
|   |   |-- b2_with_gt_V_hard_VRR.mat
|   |   |-- b3_with_gt_V_hard_AR.mat
|   |   |-- b3_with_gt_V_hard_H.mat
|   |   |-- b3_with_gt_V_hard_N.mat
|   |   |-- b3_with_gt_V_hard_VRR.mat
|   |   |-- h1024_with_gt_V_hard_AR.mat
|   |   |-- h1024_with_gt_V_hard_H.mat
|   |   |-- h1024_with_gt_V_hard_N.mat
|   |   |-- h1024_with_gt_V_hard_VRR.mat
|   |   |-- h128_with_gt_V_hard_AR.mat
|   |   |-- h128_with_gt_V_hard_H.mat
|   |   |-- h128_with_gt_V_hard_N.mat
|   |   |-- h128_with_gt_V_hard_VRR.mat
|   |   |-- h256_with_gt_V_hard_AR.mat
|   |   |-- h256_with_gt_V_hard_H.mat
|   |   |-- h256_with_gt_V_hard_N.mat
|   |   |-- h256_with_gt_V_hard_VRR.mat
|   |   |-- h32_with_gt_V_hard_AR.mat
|   |   |-- h32_with_gt_V_hard_H.mat
|   |   |-- h32_with_gt_V_hard_N.mat
|   |   |-- h32_with_gt_V_hard_VRR.mat
|   |   |-- h512_with_gt_V_hard_AR.mat
|   |   |-- h512_with_gt_V_hard_H.mat
|   |   |-- h512_with_gt_V_hard_N.mat
|   |   |-- h512_with_gt_V_hard_VRR.mat
|   |   |-- h64_with_gt_V_hard_AR.mat
|   |   |-- h64_with_gt_V_hard_H.mat
|   |   |-- h64_with_gt_V_hard_N.mat
|   |   |-- h64_with_gt_V_hard_VRR.mat
|   |   |-- s1_with_gt_V_hard_AR.mat
|   |   |-- s1_with_gt_V_hard_H.mat
|   |   |-- s1_with_gt_V_hard_N.mat
|   |   |-- s1_with_gt_V_hard_VRR.mat
|   |   |-- s2_with_gt_V_hard_AR.mat
|   |   |-- s2_with_gt_V_hard_H.mat
|   |   |-- s2_with_gt_V_hard_N.mat
|   |   |-- s2_with_gt_V_hard_VRR.mat
|   |   |-- s3_with_gt_V_hard_AR.mat
|   |   |-- s3_with_gt_V_hard_H.mat
|   |   |-- s3_with_gt_V_hard_N.mat
|   |   |-- s3_with_gt_V_hard_VRR.mat
|   |   |-- s4_with_gt_V_hard_AR.mat
|   |   |-- s4_with_gt_V_hard_H.mat
|   |   |-- s4_with_gt_V_hard_N.mat
|   |   |-- s4_with_gt_V_hard_VRR.mat
|   |   |-- u1_with_gt_V_hard_AR.mat
|   |   |-- u1_with_gt_V_hard_H.mat
|   |   |-- u1_with_gt_V_hard_N.mat
|   |   `-- u1_with_gt_V_hard_VRR.mat
|   |-- V_soft\
|   |   |-- a1_with_gt_V_soft_AR.mat
|   |   |-- a1_with_gt_V_soft_H.mat
|   |   |-- a1_with_gt_V_soft_N.mat
|   |   |-- a1_with_gt_V_soft_VRR.mat
|   |   |-- a2_with_gt_V_soft_AR.mat
|   |   |-- a2_with_gt_V_soft_H.mat
|   |   |-- a2_with_gt_V_soft_N.mat
|   |   |-- a2_with_gt_V_soft_VRR.mat
|   |   |-- a3_with_gt_V_soft_AR.mat
|   |   |-- a3_with_gt_V_soft_H.mat
|   |   |-- a3_with_gt_V_soft_N.mat
|   |   |-- a3_with_gt_V_soft_VRR.mat
|   |   |-- b1_with_gt_V_soft_AR.mat
|   |   |-- b1_with_gt_V_soft_H.mat
|   |   |-- b1_with_gt_V_soft_N.mat
|   |   |-- b1_with_gt_V_soft_VRR.mat
|   |   |-- b2_with_gt_V_soft_AR.mat
|   |   |-- b2_with_gt_V_soft_H.mat
|   |   |-- b2_with_gt_V_soft_N.mat
|   |   |-- b2_with_gt_V_soft_VRR.mat
|   |   |-- b3_with_gt_V_soft_AR.mat
|   |   |-- b3_with_gt_V_soft_H.mat
|   |   |-- b3_with_gt_V_soft_N.mat
|   |   |-- b3_with_gt_V_soft_VRR.mat
|   |   |-- h1024_with_gt_V_soft_AR.mat
|   |   |-- h1024_with_gt_V_soft_H.mat
|   |   |-- h1024_with_gt_V_soft_N.mat
|   |   |-- h1024_with_gt_V_soft_VRR.mat
|   |   |-- h128_with_gt_V_soft_AR.mat
|   |   |-- h128_with_gt_V_soft_H.mat
|   |   |-- h128_with_gt_V_soft_N.mat
|   |   |-- h128_with_gt_V_soft_VRR.mat
|   |   |-- h256_with_gt_V_soft_AR.mat
|   |   |-- h256_with_gt_V_soft_H.mat
|   |   |-- h256_with_gt_V_soft_N.mat
|   |   |-- h256_with_gt_V_soft_VRR.mat
|   |   |-- h32_with_gt_V_soft_AR.mat
|   |   |-- h32_with_gt_V_soft_H.mat
|   |   |-- h32_with_gt_V_soft_N.mat
|   |   |-- h32_with_gt_V_soft_VRR.mat
|   |   |-- h512_with_gt_V_soft_AR.mat
|   |   |-- h512_with_gt_V_soft_H.mat
|   |   |-- h512_with_gt_V_soft_N.mat
|   |   |-- h512_with_gt_V_soft_VRR.mat
|   |   |-- h64_with_gt_V_soft_AR.mat
|   |   |-- h64_with_gt_V_soft_H.mat
|   |   |-- h64_with_gt_V_soft_N.mat
|   |   |-- h64_with_gt_V_soft_VRR.mat
|   |   |-- s1_with_gt_V_soft_AR.mat
|   |   |-- s1_with_gt_V_soft_H.mat
|   |   |-- s1_with_gt_V_soft_N.mat
|   |   |-- s1_with_gt_V_soft_VRR.mat
|   |   |-- s2_with_gt_V_soft_AR.mat
|   |   |-- s2_with_gt_V_soft_H.mat
|   |   |-- s2_with_gt_V_soft_N.mat
|   |   |-- s2_with_gt_V_soft_VRR.mat
|   |   |-- s3_with_gt_V_soft_AR.mat
|   |   |-- s3_with_gt_V_soft_H.mat
|   |   |-- s3_with_gt_V_soft_N.mat
|   |   |-- s3_with_gt_V_soft_VRR.mat
|   |   |-- s4_with_gt_V_soft_AR.mat
|   |   |-- s4_with_gt_V_soft_H.mat
|   |   |-- s4_with_gt_V_soft_N.mat
|   |   |-- s4_with_gt_V_soft_VRR.mat
|   |   |-- u1_with_gt_V_soft_AR.mat
|   |   |-- u1_with_gt_V_soft_H.mat
|   |   |-- u1_with_gt_V_soft_N.mat
|   |   `-- u1_with_gt_V_soft_VRR.mat
|   `-- gif\
|       |-- a1_G_AR_S_V.gif
|       |-- a3_G_AR_S_V.gif
|       |-- h3_G_AR_S_V.gif
|       |-- rl_G_AR_S_V.gif
|       |-- s1_G_AR_S_V.gif
|       `-- s4_G_AR_S_V.gif
`-- data sets\
    |-- a1-label.pa
    |-- a1.mat
    |-- a1_with_gt.mat
    |-- a2-label.pa
    |-- a2.mat
    |-- a2_with_gt.mat
    |-- a3-label.pa
    |-- a3.mat
    |-- a3_with_gt.mat
    |-- b1-label.pa
    |-- b1_with_gt.mat
    |-- b2-label.pa
    |-- b2_with_gt.mat
    |-- b3_with_gt.mat
    |-- gaussian.mat
    |-- h1024-label.pa
    |-- h1024_with_gt.mat
    |-- h128-label.pa
    |-- h128_with_gt.mat
    |-- h256-label.pa
    |-- h256_with_gt.mat
    |-- h32-label.pa
    |-- h32_with_gt.mat
    |-- h512-label.pa
    |-- h512_with_gt.mat
    |-- h64-label.pa
    |-- h64_with_gt.mat
    |-- rls.mat
    |-- s1-label.pa
    |-- s1.mat
    |-- s1_with_gt.mat
    |-- s2-label.pa
    |-- s2.mat
    |-- s2_with_gt.mat
    |-- s3-label.pa
    |-- s3.mat
    |-- s3_with_gt.mat
    |-- s4-label.pa
    |-- s4.mat
    |-- s4_with_gt.mat
    |-- u1-label.pa
    |-- u1_with_gt.mat
    `-- vortex.m
```
</details>

<details>
  <summary>Download contents</summary>

  ```text
  |-- Extra_Functions\
|   |-- Init.m
|   |-- centroidIndexMeasure.m
|   |-- drawupdate.m
|   |-- makegif.m
|   |-- memAloc.m
|   |-- normalizedmi.m
|   |-- pickDataset.m
|   |-- plot_ellipse.m
|   |-- saveNet.m
|   `-- unitInit.m
|-- NGPCA_Functions\
|   |-- DOE_DistanceMeasures.m
|   |-- eforrlsa.m
|   |-- init_benchmark.m
|   |-- normalizedmi.m
|   |-- pickDataset.m
|   |-- plot_ellipse.m
|   |-- potentialFunctions.m
|   |-- saveNet.m
|   |-- set_data_distribution.m
|   |-- unit_adaptation.m
|   |-- unit_ranking_order.m
|   |-- vconstTest.m
|   `-- vconstpot.m
|-- NGPCA_Learningrate.m
|-- README.md
|-- Results\
|   |-- V_hard\
|   |   |-- a1_with_gt_V_hard_AR.mat
|   |   |-- a1_with_gt_V_hard_H.mat
|   |   |-- a1_with_gt_V_hard_N.mat
|   |   |-- a1_with_gt_V_hard_VRR.mat
|   |   |-- a2_with_gt_V_hard_AR.mat
|   |   |-- a2_with_gt_V_hard_H.mat
|   |   |-- a2_with_gt_V_hard_N.mat
|   |   |-- a2_with_gt_V_hard_VRR.mat
|   |   |-- a3_with_gt_V_hard_AR.mat
|   |   |-- a3_with_gt_V_hard_H.mat
|   |   |-- a3_with_gt_V_hard_N.mat
|   |   |-- a3_with_gt_V_hard_VRR.mat
|   |   |-- b1_with_gt_V_hard_AR.mat
|   |   |-- b1_with_gt_V_hard_H.mat
|   |   |-- b1_with_gt_V_hard_N.mat
|   |   |-- b1_with_gt_V_hard_VRR.mat
|   |   |-- b2_with_gt_V_hard_AR.mat
|   |   |-- b2_with_gt_V_hard_H.mat
|   |   |-- b2_with_gt_V_hard_N.mat
|   |   |-- b2_with_gt_V_hard_VRR.mat
|   |   |-- b3_with_gt_V_hard_AR.mat
|   |   |-- b3_with_gt_V_hard_H.mat
|   |   |-- b3_with_gt_V_hard_N.mat
|   |   |-- b3_with_gt_V_hard_VRR.mat
|   |   |-- h1024_with_gt_V_hard_AR.mat
|   |   |-- h1024_with_gt_V_hard_H.mat
|   |   |-- h1024_with_gt_V_hard_N.mat
|   |   |-- h1024_with_gt_V_hard_VRR.mat
|   |   |-- h128_with_gt_V_hard_AR.mat
|   |   |-- h128_with_gt_V_hard_H.mat
|   |   |-- h128_with_gt_V_hard_N.mat
|   |   |-- h128_with_gt_V_hard_VRR.mat
|   |   |-- h256_with_gt_V_hard_AR.mat
|   |   |-- h256_with_gt_V_hard_H.mat
|   |   |-- h256_with_gt_V_hard_N.mat
|   |   |-- h256_with_gt_V_hard_VRR.mat
|   |   |-- h32_with_gt_V_hard_AR.mat
|   |   |-- h32_with_gt_V_hard_H.mat
|   |   |-- h32_with_gt_V_hard_N.mat
|   |   |-- h32_with_gt_V_hard_VRR.mat
|   |   |-- h512_with_gt_V_hard_AR.mat
|   |   |-- h512_with_gt_V_hard_H.mat
|   |   |-- h512_with_gt_V_hard_N.mat
|   |   |-- h512_with_gt_V_hard_VRR.mat
|   |   |-- h64_with_gt_V_hard_AR.mat
|   |   |-- h64_with_gt_V_hard_H.mat
|   |   |-- h64_with_gt_V_hard_N.mat
|   |   |-- h64_with_gt_V_hard_VRR.mat
|   |   |-- s1_with_gt_V_hard_AR.mat
|   |   |-- s1_with_gt_V_hard_H.mat
|   |   |-- s1_with_gt_V_hard_N.mat
|   |   |-- s1_with_gt_V_hard_VRR.mat
|   |   |-- s2_with_gt_V_hard_AR.mat
|   |   |-- s2_with_gt_V_hard_H.mat
|   |   |-- s2_with_gt_V_hard_N.mat
|   |   |-- s2_with_gt_V_hard_VRR.mat
|   |   |-- s3_with_gt_V_hard_AR.mat
|   |   |-- s3_with_gt_V_hard_H.mat
|   |   |-- s3_with_gt_V_hard_N.mat
|   |   |-- s3_with_gt_V_hard_VRR.mat
|   |   |-- s4_with_gt_V_hard_AR.mat
|   |   |-- s4_with_gt_V_hard_H.mat
|   |   |-- s4_with_gt_V_hard_N.mat
|   |   |-- s4_with_gt_V_hard_VRR.mat
|   |   |-- u1_with_gt_V_hard_AR.mat
|   |   |-- u1_with_gt_V_hard_H.mat
|   |   |-- u1_with_gt_V_hard_N.mat
|   |   `-- u1_with_gt_V_hard_VRR.mat
|   |-- V_soft\
|   |   |-- a1_with_gt_V_soft_AR.mat
|   |   |-- a1_with_gt_V_soft_H.mat
|   |   |-- a1_with_gt_V_soft_N.mat
|   |   |-- a1_with_gt_V_soft_VRR.mat
|   |   |-- a2_with_gt_V_soft_AR.mat
|   |   |-- a2_with_gt_V_soft_H.mat
|   |   |-- a2_with_gt_V_soft_N.mat
|   |   |-- a2_with_gt_V_soft_VRR.mat
|   |   |-- a3_with_gt_V_soft_AR.mat
|   |   |-- a3_with_gt_V_soft_H.mat
|   |   |-- a3_with_gt_V_soft_N.mat
|   |   |-- a3_with_gt_V_soft_VRR.mat
|   |   |-- b1_with_gt_V_soft_AR.mat
|   |   |-- b1_with_gt_V_soft_H.mat
|   |   |-- b1_with_gt_V_soft_N.mat
|   |   |-- b1_with_gt_V_soft_VRR.mat
|   |   |-- b2_with_gt_V_soft_AR.mat
|   |   |-- b2_with_gt_V_soft_H.mat
|   |   |-- b2_with_gt_V_soft_N.mat
|   |   |-- b2_with_gt_V_soft_VRR.mat
|   |   |-- b3_with_gt_V_soft_AR.mat
|   |   |-- b3_with_gt_V_soft_H.mat
|   |   |-- b3_with_gt_V_soft_N.mat
|   |   |-- b3_with_gt_V_soft_VRR.mat
|   |   |-- h1024_with_gt_V_soft_AR.mat
|   |   |-- h1024_with_gt_V_soft_H.mat
|   |   |-- h1024_with_gt_V_soft_N.mat
|   |   |-- h1024_with_gt_V_soft_VRR.mat
|   |   |-- h128_with_gt_V_soft_AR.mat
|   |   |-- h128_with_gt_V_soft_H.mat
|   |   |-- h128_with_gt_V_soft_N.mat
|   |   |-- h128_with_gt_V_soft_VRR.mat
|   |   |-- h256_with_gt_V_soft_AR.mat
|   |   |-- h256_with_gt_V_soft_H.mat
|   |   |-- h256_with_gt_V_soft_N.mat
|   |   |-- h256_with_gt_V_soft_VRR.mat
|   |   |-- h32_with_gt_V_soft_AR.mat
|   |   |-- h32_with_gt_V_soft_H.mat
|   |   |-- h32_with_gt_V_soft_N.mat
|   |   |-- h32_with_gt_V_soft_VRR.mat
|   |   |-- h512_with_gt_V_soft_AR.mat
|   |   |-- h512_with_gt_V_soft_H.mat
|   |   |-- h512_with_gt_V_soft_N.mat
|   |   |-- h512_with_gt_V_soft_VRR.mat
|   |   |-- h64_with_gt_V_soft_AR.mat
|   |   |-- h64_with_gt_V_soft_H.mat
|   |   |-- h64_with_gt_V_soft_N.mat
|   |   |-- h64_with_gt_V_soft_VRR.mat
|   |   |-- s1_with_gt_V_soft_AR.mat
|   |   |-- s1_with_gt_V_soft_H.mat
|   |   |-- s1_with_gt_V_soft_N.mat
|   |   |-- s1_with_gt_V_soft_VRR.mat
|   |   |-- s2_with_gt_V_soft_AR.mat
|   |   |-- s2_with_gt_V_soft_H.mat
|   |   |-- s2_with_gt_V_soft_N.mat
|   |   |-- s2_with_gt_V_soft_VRR.mat
|   |   |-- s3_with_gt_V_soft_AR.mat
|   |   |-- s3_with_gt_V_soft_H.mat
|   |   |-- s3_with_gt_V_soft_N.mat
|   |   |-- s3_with_gt_V_soft_VRR.mat
|   |   |-- s4_with_gt_V_soft_AR.mat
|   |   |-- s4_with_gt_V_soft_H.mat
|   |   |-- s4_with_gt_V_soft_N.mat
|   |   |-- s4_with_gt_V_soft_VRR.mat
|   |   |-- u1_with_gt_V_soft_AR.mat
|   |   |-- u1_with_gt_V_soft_H.mat
|   |   |-- u1_with_gt_V_soft_N.mat
|   |   `-- u1_with_gt_V_soft_VRR.mat
|   `-- gif\
|       |-- a1_G_AR_S_V.gif
|       |-- a3_G_AR_S_V.gif
|       |-- h3_G_AR_S_V.gif
|       |-- rl_G_AR_S_V.gif
|       |-- s1_G_AR_S_V.gif
|       `-- s4_G_AR_S_V.gif
`-- data sets\
    |-- a1-label.pa
    |-- a1.mat
    |-- a1_with_gt.mat
    |-- a2-label.pa
    |-- a2.mat
    |-- a2_with_gt.mat
    |-- a3-label.pa
    |-- a3.mat
    |-- a3_with_gt.mat
    |-- b1-label.pa
    |-- b1_with_gt.mat
    |-- b2-label.pa
    |-- b2_with_gt.mat
    |-- b3_with_gt.mat
    |-- gaussian.mat
    |-- h1024-label.pa
    |-- h1024_with_gt.mat
    |-- h128-label.pa
    |-- h128_with_gt.mat
    |-- h256-label.pa
    |-- h256_with_gt.mat
    |-- h32-label.pa
    |-- h32_with_gt.mat
    |-- h512-label.pa
    |-- h512_with_gt.mat
    |-- h64-label.pa
    |-- h64_with_gt.mat
    |-- rls.mat
    |-- s1-label.pa
    |-- s1.mat
    |-- s1_with_gt.mat
    |-- s2-label.pa
    |-- s2.mat
    |-- s2_with_gt.mat
    |-- s3-label.pa
    |-- s3.mat
    |-- s3_with_gt.mat
    |-- s4-label.pa
    |-- s4.mat
    |-- s4_with_gt.mat
    |-- u1-label.pa
    |-- u1_with_gt.mat
    `-- vortex.m
  ```
</details>

## Getting Started

The latest release contains all files needed to directly run the algorithm:

1. Open `NGPCA_Learningrate.m` in Matlab
2. 
3.
4.
5.

## Visualizations
The following visualizations represent the learning process on selected data sets of the standard clustering benchmark database. For all 4 presented data sets, the *N1-G-V-H-V* learning combination is used.
## Data set S1
![N1-G-V-H-V_s1](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/visualizations/s1_NGPCAGIF.gif)
## Data set S2
![N1-G-V-H-V_s2](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/visualizations/s2_NGPCAGIF.gif)
## Data set S3
![N1-G-V-H-V_s3](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/visualizations/s3_NGPCAGIF.gif)
## Data set S4
![N1-G-V-H-V_s4](https://github.com/NicoMigenda/NGPCA-Clustering/blob/main/visualizations/s4_NGPCAGIF.gif)

## Creators

## Copyright and license