function A = ttoeppd(n, m, w, theta)
%TTOEPPD Symmetric positive definite Toeplitz matrix.
%   SMTGALLERY('TTOEPPD',N,M,W,THETA) is an N-by-N symmetric positive
%   semi-definite (SPD) Toeplitz matrix. It is composed of the sum of
%   M rank 2 (or, for certain THETA rank 1) SPD Toeplitz matrices.
%   Specifically,
%      T = W(1)*T(THETA(1)) + ... + W(M)*T(THETA(M)),
%   where T(THETA(k)) has (i,j) element COS(2*PI*THETA(k)*(i-j)).
%
%   Defaults: M = N, W = RAND(M,1), THETA = RAND(M,1).
%
%   This function is written following the toeppd function of Matlab

%   Reference:
%   G. Cybenko and C. F. Van Loan, Computing the minimum eigenvalue of
%   a symmetric positive definite Toeplitz matrix, SIAM J. Sci. Stat.
%   Comput., 7 (1986), pp. 123-131.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 26, 2009

if nargin<1
	error('Missing dimension.')
end

if nargin<2 || isempty(m), m = n; end
if nargin<3 || isempty(w), w = rand(m,1); end
if nargin<4 || isempty(theta), theta = rand(m,1); end

if length(w) ~= m || length(theta) ~= m
	error('Arguments W and THETA must be vectors of length M.')
end

% OLD

%T = zeros(n);
%e = (1:n);
%E = e(ones(n,1),:);
%E = 2*pi*(E' - E)

%for i=1:m
%    T = T + w(i) * cos( theta(i)*E );
%end

% NEW

c = zeros(n,1); 
co = 2*pi*(0:n-1)';

for i=1:m
	c = c + w(i) * cos(theta(i)*co);
end
r = c;

A = smtoep(c,r);
