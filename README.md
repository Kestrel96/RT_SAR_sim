# RT_SAR_sim

Simulation project for RT_SAR on CUDA thesis. 

```
. - Root. Conatins `main` and `sensing` scripts.
├── data - Output directory from simulation (binary files)
├── display_scripts - Data presentation scripts.
├── functions - Core of RT_SAR. Functions contain radar and point target representations and all algorithms implemented.

├── graphics - Output directory for figures from simulation.
├── legacy - Old functions that may be useful later. Will be deleted in final version.
├── msc - Helper functions (eg. data export) not strictly related to data processing.
└── tests - Some test scripts (eg. matched filter examples etc.).
```

### Main 

Main script is the script that should be run to run whole simulation. 

In the first section User can modify radar parameters, add targets etc. 

### Sensing
Sensing is called by `main.m`. This script is the simulation of radar frontend ie. raw data (echoes) are collected inside this script.

