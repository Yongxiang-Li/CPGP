function [T acond] = algdec(n,sigma)
%ALGDEC Toeplitz matrix with algebraic decay.
%
%   T = SMTGALLERY('ALGDEC', N, SIGMA) is the N-by-N Toeplitz 
%   matrix such that
%      T(i,j) = 2*pi / (sigma*(4*sigma^2+(i-j)^2))
%   for real positive SIGMA.  SIGMA defaults to 1.
%   The matrix is symmetric positive definite.
%
%   [T,ACOND] = SMTGALLERY('ALGDEC', N, SIGMA) returns also
%   the asymptotic condition number.

%   References:
%   [1] C.V.M. van der Mee, Z.M. Nashed and S. Seatzu, Sampling expansions in
%       unitarily translation invariant reproducing kernel Hilbert spaces, Adv.
%       Comput. Math. 19(4):355-372 (2003).
%   [2] C.V.M. van der Mee and S. Seatzu, A method for generating infinite
%       positive self-adjoint test matrices and Riesz bases, SIAM J. Matr.
%       Anal. Appl. 26(4), 1132-1149 (2005).

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

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

T = smtoep(2*pi./(sigma*(4*sigma^2+(0:n-1)'.^2)));

if nargout > 1
	acond = cosh(2*pi*sigma);
end
