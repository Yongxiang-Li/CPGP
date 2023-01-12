function A = tkms(n, rho)
%TKMS Kac-Murdock-Szego Toeplitz matrix.
%   A = SMTGALLERY('TKMS', N, RHO) is the N-by-N Kac-Murdock-Szego
%   Toeplitz matrix such that
%      A(i,j) = RHO^(ABS(i-j)), for real RHO.
%   For complex RHO, the same formula holds except that elements
%   below the diagonal are conjugated. RHO defaults to 0.5.
% 
%   Properties:
%     A has an LDL' factorization with
%       L = INV(GALLERY('TRIW',N,-RHO,1))', and
%       D(i,i) = (1-ABS(RHO)^2)*EYE(N),
%     except D(1,1) = 1.
%     A is positive definite if and only if 0 < ABS(RHO) < 1.
%     INV(A) is tridiagonal.
%
%   This function is written following the kms function of Matlab.

%   Reference:
%   [1] W. F. Trench, Numerical solution of the eigenvalue problem
%       for Hermitian Toeplitz matrices, SIAM J. Matrix Analysis
%       and Appl., 10 (1989), pp. 135-146.
%   [2] N. J. Higham. The Test Matrix Toolbox for MATLAB (version 3.0).
%       Numerical Analysis Report No. 276, Manchester Centre for Computational
%       Mathematics, Manchester, England, September 1995.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if nargin<1
	error('Missing dimension.')
end

if nargin<2 || isempty(rho), rho = 0.5; end

r = rho.^(0:n-1).';
if imag(rho)
	c = conj(r);
else
	c = r;
end

A = smtoep(c,r);

