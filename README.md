# virtualMast_unstable
A short set of functions to study surface layer fluxes and wind velocity spectra (simulated data) for wind engineering applications.



## Summary

A meteorological tower with 3 sonic anemometers at 3 different heights is "simulated" and 4 samples corresponding to both neutral and unstable atmospheric stratifications are provided for each height.
The goal is to use the eddy-covariance method to retrieve the different turbulence statistics and the associated flux of momentum and heat in the surface layer.

## Method 

The submission contains

• 4 .mat files with the different samples (simulated time series)

• One example file Example.mlx

• The functions “verticalSpectrum_Hojstrup” and “longitudinalSpectrum_Hojstrup” to compute the spectral model from Højstrup [1].

• The function “getStability” to estimate the Obukhov length, the heat flux, the scaling temperature and friction velocity.

• The function “obukhovLength” to compute the Obukhov length.

• The function “similarityFun” to get the non-dimensional vertical profile of heat and momentum.

• The functions “plotSimilarityFun” and “plotVelocitySpectra” to plot more clearly the velocity spectra and the non-dimensional profiles

Any comments or suggestion to improve this submission is warmly welcomed.


## Reference

[1] Højstrup, J. (1981). A simple model for the adjustment of velocity spectra in unstable conditions downstream of an abrupt change in roughness and heat flux. Boundary-Layer Meteorology, 21(3), 341-356.
