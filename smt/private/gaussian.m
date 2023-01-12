function [T acond] = gaussian(n,sigma)
%GAUSSIAN Gaussian Toeplitz matrix.
%
%   T = SMTGALLERY('GAUSSIAN', N, SIGMA) is the N-by-N Toeplitz 
%   matrix such that
%      T(i,j) = sqrt(SIGMA/(2*pi)) * exp(-SIGMA/2*(i-j)^2)
%   for real positive SIGMA.  SIGMA defaults to 1.
%   The matrix is symmetric positive definite.
%
%   [T,ACOND] = SMTGALLERY('GAUSSIAN', N, SIGMA) returns also
%   the asymptotic condition number.

%   References:
%   [1] C.V.M. van der Mee and S. Seatzu, A method for generating infinite
%       positive self-adjoint test matrices and Riesz bases, SIAM J. Matr.
%       Anal. Appl. 26(4), 1132-1149 (2005).

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 9, 2011

if nargin<1
	error('Missing dimension.')
end

if nargin<2,  sigma = 1;  end

if ~isreal(sigma)
	error('Parameter must be real.')
end

if sigma <= 0
	error('Parameter must be positive.')
end

T = smtoep(sqrt(sigma/2/pi) * exp(-sigma/2*(0:n-1)'.^2));

if nargout > 1
	N = ceil(-log(eps)/sigma+.5);
	v = exp(-((1:N)'-.5)*sigma);
	acond = prod((1+v)./(1-v))^2;
end
