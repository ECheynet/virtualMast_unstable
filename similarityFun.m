function [phiU,phiT,phiW,phiTheta,varargout] = similarityFun(varargin)
% [phiU,phiT,phiW,phiTheta,varargout] = similarityFun(varargin) computes
% the similarity functions. In the present version, the similarity functions
% for the momentum (phiM) and heat transfer (phiT) are those from Dyer[2] 
% and modified by Högstrom [1]. .
% 
% Inputs:
% varargin: eta (=zL): [1 x N]. Vector of non-dimensional obukhov length, with values between -2 and +1
% 
% Output
% phiU: Similarity function for the velocity profile
% phiT: Similarity function for the temperature profile
% phiW: variability of stdW/_star with stability
% phiTheta: variability of potential temperature stability
% varargout: eta (=zL): [1 x N]. Vector of non-dimensional obukhov length
% 
% References:
% [1] Högström, U. L. F. (1988). Non-dimensional wind and temperature 
% profiles in the atmospheric surface layer: A re-evaluation. 
% Boundary-Layer Meteorology, 42(1), 55-78.
% 
% [2] Dyer, A. J. (1974). A review of flux-profile relationships. 
% Boundary-Layer Meteorology, 7(3), 363-372.
% 
% Author info: 
% E. Cheynet - University of Stavanger -  last modified: 16.06.2017
% 
% see also plotSimilarityFun getStability

narginchk(0,1);

%% Initialisation
if nargin ==1,
    eta = varargin{1};
else
    eta = linspace(-2,2,100);
    varargout = {eta};
end

phiU = nan(1,numel(eta));
phiT = nan(1,numel(eta));
phiW = nan(1,numel(eta));
phiTheta = nan(1,numel(eta));

%% Main body
indE1 = find(eta<=0); % unstable
indE2 = find(eta >0); % stable

% Vertical velocity profile
phiU(indE1) =(1+15.2*abs(eta(indE1))).^(-1/4); % Hogstrom (1988) from Dyer (1974)
phiU(indE2) =(1+4.8.*eta(indE2));% Hogstrom (1988)

% Vertical temperature profile
phiT(indE1) =0.95.*(1+11.6.*abs(eta(indE1))).^(-1/2);% Hogstrom (1988)
phiT(indE2) =0.95+4.5.*eta(indE2);% Hogstrom (1988)

% variability in w
phiW(indE1) = 1.25.*(1+3.*abs(eta(indE1))).^(1/3);
phiW(indE2) = 1.25.*(1+0.1.*abs(eta(indE2)));

% variability in theta
phiTheta(indE1) = 2.0.*(1+9.5.*abs(eta(indE1))).^(-1/3);
phiTheta(indE2) = 2.0.*(1+0.5.*abs(eta(indE2))).^(-1);

end