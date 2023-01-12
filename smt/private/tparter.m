function A = tparter(n)
%TPARTER Parter matrix (Toeplitz with singular values near pi).
%     C = SMTGALLERY('TPARTER',N) returns the matrix C such that
%     C(i,j) = 1/(i-j+0.5).
%     C is a Cauchy matrix and a Toeplitz matrix.
%     Most of the singular values of C are very close to pi.
%
%   This function is written following the parter function of Matlab

%   References:
%   [1] The MathWorks Newsletter, Volume 1, Issue 1, March 1986, page 2.
%   [2] S. V. Parter, On the distribution of the singular values of
%       Toeplitz matrices, Linear Algebra and Appl., 80(1986), pp. 115-130.
%   [3] E. E. Tyrtyshnikov, Cauchy-Toeplitz matrices and some applications,
%       Linear Algebra and Appl., 149 (1991), pp. 1-18.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 26, 2009

if nargin<1
	error('Missing dimension.')
end

c = ones(n,1)./((1:n)'-0.5);
r = ones(n,1)./(1.5-(1:n)');
A = smtoep(c,r);
