addpath('..\routine');    addpath('..\smt');
rng('default')

fs = 1; % sampling frequency
f0 = 0.055; % natural frequency
zeta0 = 0.01; % damping ratio
T0 = 200; % true period
N = 40097; % signal length

[orginSignal, t] = get_normal_transient_signal(N, f0, zeta0, T0, fs, 0.000); % get signal
noise = randn(size(orginSignal));
noise = noise*rms(orginSignal)/rms(noise)/10^(-23/20); % -23db
signal = orginSignal + noise;

figure(1); plot(orginSignal(1:1:fs*5*T0)); 
title('orignal signal'); xlabel('time [s]'); ylabel('Amplitude');


lob = [0.1 1];
upb = [10 30];
period = (1:fs*4*T0)';
[nrc.period, nrc.Q] = NRCPE( signal, period(end)); 
figure;plot(nrc.Q); 
title('NRCPE'); xlabel('time [s]'); ylabel('Autocorrelation');
disp(['The period calculated by NRCPE is ' num2str(nrc.period) ' seconds'])

tic;
modelGP = fit_CPGP(period, signal, @regpoly0, @period_sin_gauss_cov, lob, upb);
toc;
figure;plot(modelGP.P, modelGP.likelihood);
title('CPGP'); xlabel('time [s]'); ylabel('Likelihood');
disp(['The period calculated by CPGP is ' num2str(nrc.period) ' seconds'])




