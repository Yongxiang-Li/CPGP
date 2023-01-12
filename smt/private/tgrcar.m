function A = tgrcar(n, k)
%TGRCAR  Grcar matrix.
%   SMTGALLERY('TGRCAR',N,K) is an N-by-N Toeplitz matrix with -1s on
%   the subdiagonal, 1s on the diagonal, and K superdiagonals of 1s.
%   The default is K = 3.  The eigenvalues are sensitive.
%
%   This function is written following the grcar function of Matlab

%  References:
%    [1] J. F. Grcar, Operator coefficient methods for linear equations,
%    Report SAND89-8691, Sandia National Laboratories, Albuquerque,
%    New Mexico, 1989 (Appendix 2).
%    [2] N. M. Nachtigal, L. Reichel and L. N. Trefethen, A hybrid GMRES
%    algorithm for nonsymmetric linear systems, SIAM J. Matrix Anal.
%    Appl., 13 (1992), pp. 796-825.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if nargin<1
	error('Missing dimension.')
end

if nargin<2 || isempty(k), k = 3; end

r = tril(ones(1,n),k)';
c = [r(1) -1 zeros(1,n-2)]';

A = smtoep(c,r);
