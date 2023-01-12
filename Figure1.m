close all;    clear;    clc;
rng('default');
addpath('routine');    addpath('smt');

fs = 200;
f0 = 11;
zeta0 = 0.01;
T0 = 1; % true period
N = 4000; % number of simulations
SNR = -18; % signal to noise ratio
 % generate signal
[originSignal, t] = get_normal_transient_signal(N, f0, zeta0, T0, fs, 0.0001); % get signal
noise = randn(size(originSignal));
noise = noise*rms(originSignal)/rms(noise)/10^(SNR/20); % 20*log10(rms(originSignal)/rms(noise))
noiseSignal = originSignal + noise;
% init analysis
period = (1:1:fs*2.5*T0)';

%%
theta0 = [5, 20]; % specify the value of theta0 without optimization
% CPGP
modelCPGP = fit_CPGP(period, noiseSignal, @regpoly0, @period_sin_gauss_cov, [], [], theta0);
% CPGP with L1 only
modelCPGP_L1only = fit_CPGP_L1only(period, noiseSignal, @regpoly0, @period_sin_gauss_cov, [], [], theta0);
% CPGP with normalized L1
modelACPGP = fit_ACPGP(period, noiseSignal, @regpoly0, @period_sin_gauss_cov, [], [], theta0);

figure; % Fig
subplot(3,1,1); plot(modelCPGP.likelihood); xlabel('$p$','Interpreter','latex'); ylabel('$\ell$','Interpreter','latex'); 
title('Full Log-likelihood $\ell$','Interpreter','latex');axis tight;
subplot(3,1,2); plot(modelCPGP_L1only.likelihood); xlabel('$p$','Interpreter','latex'); ylabel('$\ell_1$','Interpreter','latex'); 
title('Composite Log-likelihood $\ell_1$','Interpreter','latex');axis tight;
subplot(3,1,3); plot(modelACPGP.likelihood); xlabel('$p$','Interpreter','latex'); ylabel('$\ell_1/(kp)$','Interpreter','LaTex'); 
title('Normalized Composite Log-likelihood $\ell_1$','Interpreter','latex');axis tight;

%% grid search of theta0 before using an optimization
lob = [1 0.1];
upb = [10 30];
% CPGP
modelCPGP = fit_CPGP(period, noiseSignal, @regpoly0, @period_sin_gauss_cov, lob, upb);
% CPGP with L1 only
modelCPGP_L1only = fit_CPGP_L1only(period, noiseSignal, @regpoly0, @period_sin_gauss_cov, lob, upb);
% CPGP with normalized L1
modelACPGP = fit_ACPGP(period, noiseSignal, @regpoly0, @period_sin_gauss_cov, lob, upb);


figure; % Fig
subplot(3,1,1); plot(modelCPGP.likelihood); xlabel('$p$','Interpreter','latex'); ylabel('$\ell$','Interpreter','latex'); 
title('Full Log-likelihood $\ell$','Interpreter','latex');axis tight;
subplot(3,1,2); plot(modelCPGP_L1only.likelihood); xlabel('$p$','Interpreter','latex'); ylabel('$\ell_1$','Interpreter','latex'); 
title('Composite Log-likelihood $\ell_1$','Interpreter','latex');axis tight;
subplot(3,1,3); plot(modelACPGP.likelihood); xlabel('$p$','Interpreter','latex'); ylabel('$\ell_1/(kp)$','Interpreter','LaTex'); 
title('Normalized Composite Log-likelihood $\ell_1$','Interpreter','latex');axis tight;set(gca,'ytick',[-2.302,-2.298,-2.294])

