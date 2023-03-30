function [Su] = longitudinalSpectrum_Hojstrup(u_star,L,f,fr,fi,zi,varargin)
% [Su] = longitudinalSpectrum_Hojstrup(u_star,L,f,fr,fi,zi) computes the
% longitudinal specturm following the model proposed by Højstrup [1], 
% based on the Kansas experiment [2].
% 
% Input:
% u_star
% L: [1x1]: Obukhov length (m) -> must be <0
% f: [1xN] : frequency vector (Hz)
% fr: [1xN] : reduced frequency w.r.t. z (dimensionless)
% fi: [1xN] : reduced frequency w.r.t. zi (dimensionless)
% zi: [1x1]: Inversion height (m)
% varargin : 1 for normalzied or 0 for non-normalized.
% 
% Output
% Su: vector: [1 x N] : longitudinal wind spectrum in (m/s)^2/Hz
% 
% 
% Author info: 
% E. Cheynet - University of Stavanger -  last modified: 16.06.2017
% 
% References:
% [1] Højstrup, J. (1981). A simple model for the adjustment of velocity
% spectra in unstable conditions downstream of an abrupt change in roughness 
% and heat flux. Boundary-Layer Meteorology, 21(3), 341-356.
% [2] Kaimal, J. C., Wyngaard, J., Izumi, Y., & Coté, O. R. (1972). 
% Spectral characteristics of surface?layer turbulence. Quarterly Journal of 
% the Royal Meteorological Society, 98(417), 563-589.


if nargin > 6,
    Normalization = varargin{1};
else
    Normalization = 0;
end

A = 105.*fr./(1+33.*fr).^(5/3); % Kaimal model
B = 0.5.*fi./(1+2.2.*fi.^(5/3)); %  low frequency spectrum 

if (L)^(-1)<0, % unstable
    C = abs(zi./L).^(2/3);
else
    C = 0;
end

if Normalization==1,
    Su = (A + B.*C);
else
    Su = (A + B.*C).*u_star.^2./f;
end

end
