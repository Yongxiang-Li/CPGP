function A = tchow(n, alpha, delta)
%TCHOW Chow matrix (singular Toeplitz lower Hessenberg matrix).
%   A = SMTGALLERY('TCHOW',N,ALPHA,DELTA) returns A such that
%      A = H(ALPHA) + DELTA*EYE, where H(i,j) = ALPHA^(i-j+1).
%   H(ALPHA) has p = FLOOR(N/2) zero eigenvalues, the rest being
%   4*ALPHA*COS( k*PI/(N+2) )^2, k=1:N-p.
%   Defaults: ALPHA = 1, DELTA = 0.
%
%   This function is written following the chow function of Matlab.

%   References:
%   [1] T. S. Chow, A class of Hessenberg matrices with known eigenvalues
%       and inverses, SIAM Review, 11 (1969), pp. 391-395.
%   [2] G. Fairweather, On the eigenvalues and eigenvectors of a class of
%       Hessenberg matrices, SIAM Review, 13 (1971), pp. 220-221.
%   [3] I. Singh, G. Poole and T. Boullion, A class of Hessenberg matrices
%       with known pseudoinverse and Drazin inverse, Math. Comp., 29 (1975),
%       pp. 615-619.
%   [4] N. J. Higham. The Test Matrix Toolbox for MATLAB (version 3.0).
%       Numerical Analysis Report No. 276, Manchester Centre for Computational
%       Mathematics, Manchester, England, September 1995.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 26, 2009

if nargin<1
	error('Missing dimension.')
end

if nargin<3 || isempty(delta), delta = 0; end
if nargin<2 || isempty(alpha), alpha = 1; end

c = alpha.^(1:n);
c(1) = alpha+delta;
r = [c(1) 1 zeros(1,n-2)];

A = smtoep(c,r);
