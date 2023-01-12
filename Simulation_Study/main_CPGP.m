close all;
clear;
clc;
rng('default');

addpath('..\routine');
addpath('..\smt');
fs = 200;
f0 = 11;
zeta0 = 0.01;
T0 = 1; % true period
S = 100;    % number of simulations

N = 5000;
for SNR = -25:-11
    filename = ['PGP_SimulationResults(N=',num2str(N),';SNR=',num2str(SNR),').mat'];
    if exist(filename, 'file')
        continue;
    end
    signals = [];    results = [];
    save(filename,'signals','results')
    for s = 1 : S
        % generate signal
        [originSignal, t] = get_normal_transient_signal(N, f0, zeta0, T0, fs, 0.0001); % get signal
        noise = randn(size(originSignal));
        noise = noise*rms(originSignal)/rms(noise)/10^(SNR/20); % 20*log10(rms(originSignal)/rms(noise))
        noiseSignal = originSignal + noise;
        signal = struct('SNR',SNR,'N',N,'noiseSignal',noiseSignal,'orginSignal',originSignal);
        % init analysis
        result = struct();
        period = (1:1:fs*2.5*T0)';
        result.Searchingperiod = period;
        % CPGP
        lob = [2 1];
        upb = [20 30];
        tic
        modelCPGP = fit_CPGP(period, noiseSignal, @regpoly0, @period_sin_gauss_cov, lob, upb);
        toc
        [~, modelCPGP.period] = max(modelCPGP.likelihood);
        modelCPGP.time = toc;
        % ACPGP
        lob = [2 1];
        upb = [20 30];
        tic
        modelACPGP = fit_ACPGP(period, noiseSignal, @regpoly0, @period_sin_gauss_cov, lob, upb);
        ACPGPtime = toc;
        modelACPGP.time = ACPGPtime;

        result.modelCPGP = modelCPGP;
        result.modelACPGP = modelACPGP;
        results = [results; result];
        signals = [signals signal];
    end
    save(filename,'signals','results')
end
