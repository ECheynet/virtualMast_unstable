function [L,wT,T_star,u_star] = getStability(u,w,theta,z,varargin)
% [L,wT,T_star,u_star] = getStability(u,w,theta,z) compute the scaling
% parameters following the Monin-Obukhov similarity theory.
% 
% Notations for the Input:
% M = number of sensors and N = number of time step
% 
% Input:
% u: [N x M] matrix of along-wind velocity fluctuations + mean.
% w: [N x M] matrix of vertical-wind velocity fluctuations.
% theta [N x M] matrix of potential temperature fluctuations + mean.
% z: [1 x M] or [ M x 1]  measurement height.
% varargin: v: [N x M] matrix of across-wind velocity fluctuations + mean.
% 
% Output
% L: [1 x 1]  Obukhov length (m)
% wT: [M x 1] Heat flux (K m/s)
% u_star: [M x 1] friction velocity (m/s)
% T_star: [M x 1] scaling temperature (K)
% 
% Author info: 
% E. Cheynet - University of Stavanger -  last modified: 16.06.2017
% 
% see also plotSimilarityFun similarityFun

%% Inputparseer
p = inputParser();
p.CaseSensitive = false;
p.addOptional('v',[]);
p.parse(varargin{:});

v = p.Results.v;
%% Initialisation
Nm = numel(z);
if size(u,1)~=Nm && size(u,2)~=Nm, error(' You must have numel(z) = size(u,2)'); end
        
if size(u,1)==Nm,   u = u';end
if size(w,1)==Nm,   w = w';end
if size(theta,1)==Nm,   theta = theta';end

u_star = zeros(1,Nm);
wT = zeros(1,Nm);

%% Main body
for ii=1:Nm
    dummy1 = cov(detrend(w(:,ii))',detrend(theta(:,ii))');
    wT(ii) = dummy1(1,2);
    u_star(ii) = frictionVelocity(u,v,w);   
end
T_star = -wT./u_star;

T0 = mean(mean(theta,'omitnan'),'omitnan'); % reference absolute temperature (average of temperature in the surface layer ?)
[L] = obukhovLength(mean(u_star,'omitnan'),mean(wT,'omitnan'),T0);
fprintf('\n')

fprintf(['Estimated T* = ',num2str(mean(T_star,'omitnan'),2),' K \n']);
fprintf(['Estimated u* = ',num2str(mean(u_star,'omitnan'),2),' m/s \n']);
fprintf(['Estimated heat flux wT = ',num2str(mean(wT,'omitnan'),2),' \n']);
fprintf(['Estimated L = ',num2str(round(mean(L,'omitnan'))),' m \n\n']);

%% Nested functions
    function [u_star] = frictionVelocity(u,v,w)

        u = detrend(u);
        w = detrend(w);
        uw=mean(u(:).*w(:),'omitnan');

        if ~isempty(v)
            v = detrend(v);
            vw=mean(w(:).*v(:),'omitnan');
        else
            vw = 0;
        end

        u_star = (uw.^2+vw.^2).^(1/4);

        u_star(isinf(u_star))=NaN;
        u_star(u_star==0)=NaN;
    end


end

