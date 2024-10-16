clear; close all; load('data.mat');
addpath('..\routine');    addpath('..\smt');

segmentLength = length(X);
figure(20); plot(X, Y)

period = (2:1:100)'; 
modelCPGP = fit_CPGP(period, Y, @regpoly1, @period_sin_gauss_cov, [0.3, 2], [0.5, 3]);
figure; plot(modelCPGP.likelihood)
Yp = predict_CPGP(modelCPGP);
figure(20); hold on; plot(X, Yp)