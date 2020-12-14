Documentation
=============
**General Description:**

This project is a solution to 2019 Mathematical Contest in Modeling, Problem C, which mainly focuses on analyzing opioid crisis in five states in the United States

Project mainly includes four parts:
1. Artificial Potential Field part
2. K-Means Clustering part
3. Particle Swarm Optimization part

Dependencies
-------------
**Language:**  MATLAB

**Interpreter:**  MATLAB 2020a

Project Architecture
-------------
```buildoutcfg
├── Readme.md                   // help
├── APF                         // Artifical Potential Field
│   ├── APF.m                   // create Artificial Potential Field
│   └── force.m                 // calculate attractive and replusive force
├── K-Means
│   ├── AHP.m                   // Analytic Hierarchy Process
│   ├── clustering.m            // K-Means clustering algorithm 
│   ├── clustering_distance.m   // calculate distance between data points 
│   └── gauss.m                 // Gaussian distribution probability density function
├── prediction
│   ├── ARIMA_Predict.m         // ARIMA function for times-series prediction
│   └── predict_main.m          // main function for prediction
├── PSO&LS
│   ├── euclidean_dis.m         // calculating euclidean distance between data points
│   ├── LeastSquare.m           // Least Square Regression algorithm
│   └── PSO.m                   // Particle Swarm Optimization
└── Threshold_selection
    ├── threshold_iteration.m   // determining threshold through iteration
```