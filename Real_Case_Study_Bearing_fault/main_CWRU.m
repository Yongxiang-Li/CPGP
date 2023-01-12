
close all;
clear;
clc;

addpath('..\routine');
addpath('..\smt')

load('BearingSignals.mat'); % period = 461
figure;plot(signal);
l = length(signal);

for len = (2000:2000:20000)
    filename = ['CWRU_Results_SignalLen=',num2str(len),'.mat'];
    signals = [];    results = [];  
    parfor i = 1:100
        start = unidrnd(l - len); 
        cut_signal = signal(start : start+len-1);
        lob = [0.01 15];
        upb = [5 20];
        period = (1:1:1000)';
        result = struct();
        % CPGP
        modelCPGP = fit_CPGP(period, cut_signal, @regpoly0, @period_sin_gauss_cov, lob, upb);
        [~, modelCPGP.period] = max(modelCPGP.likelihood);
        % ACPGP
        modelACPGP = fit_ACPGP(period, cut_signal, @regpoly0, @period_sin_gauss_cov, lob, upb);
        [~, modelACPGP.period] = max(modelACPGP.likelihood);

        result.modelCPGP = modelCPGP;
        result.modelACPGP = modelACPGP;
        results = [results; result];
        signals = [signals cut_signal];
    end    
    save(filename, 'signals', 'results')
end   


