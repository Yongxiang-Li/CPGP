close all; 
addpath('..\routine');    
addpath('..\smt');

% load the mono speech signal
[signal, samplingFreq] = audioread('roy.wav');
nData = length(signal);

% set up
segmentTime = 0.025; % seconds
segmentLength = round(segmentTime*samplingFreq); % signal length
nSegments = floor(nData/segmentLength); % segments
period = (2:0.2:100)'; % searching grids

if ~exist('HPGPModels', 'var') 
    CPGPModels = [];
    for i = 1:nSegments
        disp(['Processing segment ', num2str(i), ' of ', num2str(nSegments)]);
        idx = 1:segmentLength;
        speechSegment = signal(idx+(i-1)*segmentLength);
        % CPGP
        upb = [0.5, 3];    lob = [0.3, 2];
        modelCPGP = fit_CPGP(period, speechSegment, @regpoly0, @period_sin_gauss_cov, lob, upb);
        CPGPModels = [CPGPModels; modelCPGP];
    end
end
timeVector = (1:nSegments)*segmentTime-segmentTime/2;

%% compute the spectrogram of the signal
window = gausswin(segmentLength);
nOverlap = round(3*segmentLength/4);
nDft = 2048;
[stft, stftFreqVector, stftTimeVector] = ...
    spectrogram(signal, window, nOverlap, nDft, samplingFreq);
powerSpectrum = abs(stft).^2;

%% plot the results

maxDynamicRange = 60; % dB
SPGPEstimates = samplingFreq./[CPGPModels(:).period];
figure; imagesc(stftTimeVector, stftFreqVector, ...
    10*log10(dynamicRangeLimiting(powerSpectrum, maxDynamicRange)));
set(gca,'YDir','normal')
hold on
plot(timeVector, SPGPEstimates, 'r.')
plot(timeVector, SPGPEstimates, 'r.')
hold off
colorbar
xlabel('time [s]')
ylabel('frequency [Hz]')
title('Roy?')


