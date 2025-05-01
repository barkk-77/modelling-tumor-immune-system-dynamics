# modelling-tumor-immune-system-dynamics
**Introduction**

This repository contains MATLAB code for replicating key figures from a research paper titled '_Dormant Tumor Cell Vaccination: A Mathematical Model of Immunological Dormancy in Triple-Negative Breast Cancer_'. In the paper, the researchers develop a model that uses a system of ordinary differential equations to simulate interactions between tumor cells and immune components. 


**Features**

This repository includes MATLAB scripts that:
- Define the system of ODEs describing tumor-immune interactions:
- Simulate scenarios involving:
  1. Growth of individual tumor subtypes
  2. Mixed tumor environments
  3. Vaccination-like preconditioning strategies
- Animate the figures
  

**Structure**

- **simul_diff_x.m** - Function Definitions for ODE models (e.g., simul_diff_proliferative)
- **simulation_x.m** - Main scripts to simulate specific biological scenarios (e.g., simulation_proliferative)
- **simulation_x_animation.m** - Scripts to animate simulation figures
  

**Special Addition**

This repository also includes a custom-built 3D animation framework that visually simulates the spatial structure of tumor growth and immune response using cube and dot representations.

This framework invovles 3 files
- **draw_cube.m** - Renders a single 3D cube given the center, side length, color and transparency
- **grow_cubes.m** - Generates a cluster of connected cubes to simulate tumor growth. Uses a BFS-like algorithm to expand cubes in 6 possible directions. Also prevents overlaps using a dictionary-based tracking system
- **x_tumor_environment** - Represents simulation results spatially


**Insructions for Usage**

- Requires MATLAB R2022b or later 
- Ensure all files are in a single folder before you run


**Acknowledgments**

Code based on information from:
_Mehdizadeh, R., Shariatpanahi, S. P., Goliaei, B., Peyvandi, S., & Rüegg, C. (2021). Dormant Tumor Cell Vaccination: A Mathematical Model of Immunological Dormancy in Triple-Negative Breast Cancer. Cancers, 13(2), 245. https://doi.org/10.3390/cancers13020245_









