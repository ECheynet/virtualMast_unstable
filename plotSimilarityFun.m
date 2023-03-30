function plotSimilarityFun(z,zL,u_star,T_star,U,Theta,varargin)
% [phiU,phiT,phiW,phiTheta] = 
% plotSimilarityFun(z,zL,u_star,T_star,kappa,U,Theta,eta) plots the
% theoritical similarity function compared to the measured one.
% 
% Notations for the Input:
% M = number of sensors and P = number of stability classes
% 
% Input:
% z: [M x 1]: measurement height
% zL: [M x P]: Non-dimensional obukhov length
% u_star: [M x 1] friction velocity (m/s)
% T_star: [M x 1] scaling temperature (K)
% U: [M x 1] mean wind velocity (m/s)
% Theta: [M x 1] mean potential temperature (K)
% varargin:
%   kappa: von karman constant (0.4 by default)
%   eta: Non-dimensional obukhov length (eta=zL) for the target similarity
%   function
%   method: 1: to combine only the lowest and highest height
%           2: to combine every heights
% 
% Output
% none
% 
% Author info: 
% E. Cheynet - University of Stavanger -  last modified: 16.06.2017
% 
% see also similarityFun getStability

%% Inputparseer
p = inputParser();
p.CaseSensitive = false;
p.addOptional('method',2);
p.addOptional('kappa',0.4);
p.addOptional('eta',[-fliplr(logspace(log10(1e-4),log10(2),20)),logspace(log10(1e-4),log10(2),20)]);
p.parse(varargin{:});
%%%%%%%%%%%%%%%%%%%%%%%%%%
kappa = p.Results.kappa ; 
eta = p.Results.eta ;
method = p.Results.method ; 
%%
[phiU,phiT,~,~] = similarityFun(eta);


if method ==1, % combining only 1st and last height
    U1 = [U(:,1),U(:,end)];
    Theta1 = [Theta(:,1),Theta(:,end)];
    z1 = [z(1),z(end)];
    
    dUdZ = bsxfun(@times,diff(U1,1,2),1./diff(z1));
    dTdZ = bsxfun(@times,diff(Theta1,1,2),1./diff(z1));
    
elseif method ==2,
    z1 = z;
    dUdZ = bsxfun(@times,diff(U,1,2),1./diff(z));
    dTdZ = bsxfun(@times,diff(Theta,1,2),1./diff(z));
else
    error(' ''method'' must be ''1'' or ''2'' ');
end

tiledlayout(1,2,"TileSpacing","tight")
nexttile
hold on; box on;
plot(eta,phiU,'k')
for ii=1:size(zL,1)
    plot(zL(ii,:), kappa./u_star(ii).*mean(z1).*nanmedian(dUdZ(ii,:),2),'r*')
end
xlabel('$z/L$','interpreter','latex')
ylabel('$\phi_m$','interpreter','latex')
xlim([-2,1]); ylim([0,6])
nexttile
hold on; box on;
plot(eta,phiT,'k')
for ii=1:size(zL,1)
plot(zL(ii,:), kappa./T_star(ii).*mean(z1).*nanmedian(dTdZ(ii,:),2),'r*')
end
xlim([-2,1]); ylim([0,6])
xlabel('$z/L$','interpreter','latex')
ylabel('$\phi_h$','interpreter','latex')
set(findall(gcf,'-property','FontSize'),'FontSize',12,'FontName','Times')
set(gcf,'color','w')
end

