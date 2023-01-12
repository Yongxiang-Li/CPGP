function [period, Q] = NRCPE(signal, K, gamma)

    if nargin < 3, gamma = 0.5; end
    range = (1:K)';
    Q = nan(size(range));
    for j = range'
        Q(j) = nrc(signal, j);
    end
    envlp = cummin(Q);
    [~,index] = max(Q);
    
    period = [];
    for g = gamma(:)'
        c = g*(Q(index)-Q(1))/(envlp(index)-envlp(1));
        [~,p] = max(Q - c*envlp);
        period = [period  p];
    end
end

function [ Q, C, V, S, m] = nrc( noiseSignal, N )
%NRC Summary of this function goes here
%   Detailed explanation goes here
    
    Y =  cut_signal(N,noiseSignal);
    m = size(Y,2);%  k = floor(m/n);
    Yhat = mean(Y,2)';   l = N*m;
    C = Yhat*Yhat'/length(Yhat);
    V = sum(noiseSignal(1:l).^2)/l - C;
    Q = C - V/(m-1);
    S = m*V/(m-1);
end

function [ shapeSignal ] = cut_signal( l, signal)
%CUT Summary of this function goes here
%   Detailed explanation goes here
    n = length(signal);
    if l >= n
        shapeSignal = signal;
    else
        shapeSignal = reshape(signal(1:l*floor(n/l)), l, floor(n/l));
    end
end

