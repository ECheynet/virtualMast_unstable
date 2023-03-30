function plotVelocitySpectra(u,w,fs,Su,Sw,f,u_star)
% plotVelocitySpectra(u,w,fs,Su,Sw,f,u_star) plot the measured spectra
% versus the computed ones
% 
% Input: 
% u: [N x M] matrix of along-wind velocity fluctuations + mean.
% w: [N x M] matrix of vertical-wind velocity fluctuations.
% fs: [1x1]: sampling frequency
% Su: [1x Nfreq] : Target spectrum of longitudinal velocity fluctuations
% Sw: [1x Nfreq] : Target spectrum of vertical velocity fluctuations
% f: [1x Nfreq] : frequency vector associated with Su and sw
% u_star: [1x1]: friction velocity
% 
% Output
% none
% 
% Author info: 
% E. Cheynet - University of Stavanger -  last modified: 16.06.2017
% 
% see also pwelch

%% Initialisation
   
Nm = min(size(u));

if size(u,1)==Nm,   u = u';end
if size(w,1)==Nm,   w = w';end

%% Main body
clear S1 S2 S0 S3 S4 S5
kk=1;
for ii=1:10:size(u,2),
    [S0(:,kk),f1]=pwelch(detrend(u(:,ii)),[],[],[],fs);
    [S1(:,kk),f1]=pwelch(detrend(w(:,ii)'),[],[],[],fs);
    kk=kk+1;
end

S0 = mean(S0,2,'omitnan');
S1 = mean(S1,2,'omitnan');


% [S2,f2]=pwelch(x2,[],[],[],fs);

if size(Sw,1)>1,
loglog(f1,f1.*S0./mean(u_star,'omitnan').^2,'r',f1,f1.*S1./mean(u_star,'omitnan').^2,'b',mean(Sw,'omitnan'),'k--',f,mean(Su,'omitnan'),'k')
else
 loglog(f1,f1.*S0./mean(u_star,'omitnan').^2,'r',f1,f1.*S1./mean(u_star,'omitnan').^2,'b',f,Sw,'k--',f,Su,'k')   
end
grid on
grid minor
axis tight
xlabel('$f$ (Hz)','interpreter','latex')
ylabel('Normalized velocity spectra','interpreter','latex')
set(gcf,'color','w')
leg = legend('$fS_{u}/u^2_*$','$fS_{w}/u^2_*$','location','best');
set(leg,'interpreter','latex')
set(findall(gcf,'-property','FontSize'),'FontSize',12,'FontName','Times')

end

