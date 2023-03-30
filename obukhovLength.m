function [L] = obukhovLength(u_star,wT,Theta,varargin)
% [L] = obukhovLength(u_star,wT,Theta,varargin) computes the Obukhov length
% 
% Input
% u_star: [1 x 1] friction velocity at the surface (m/s)
% wT: [1 x 1] flux of virtual potential temperature at the surface (K m/s)
% Theta: [1 x 1] mean virtual potential temperature in the surface layer
% (K)
% 
% Output
% L:[1x1]: Obukhov length (m)
% 
% Author info: 
% E. Cheynet - University of Stavanger -  last modified: 16.06.2017
% 
% see also similarityFun getStability

%% Inputparseer
p = inputParser();
p.CaseSensitive = false;
p.addOptional('kappa',0.40);
p.addOptional('g',9.81);
p.parse(varargin{:});
%%%%%%%%%%%%%%%%%%%%%%%%%%
kappa = p.Results.kappa;
g = p.Results.g;

L = -(Theta.*u_star.^3)./(kappa*g.*wT);

end