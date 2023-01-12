function A = ttoeppen(n, a, b, c, d, e)
%TTOEPPEN Pentadiagonal Toeplitz matrix (sparse).
%   P = SMTGALLERY('TTOEPPEN',N,A,B,C,D,E) takes integer N and
%   scalar A,B,C,D,E. P is the N-by-N sparse pentadiagonal Toeplitz
%   matrix with the diagonals: P(3,1)=A, P(2,1)=B, P(1,1)=C, P(1,2)=D,
%   P(1,3)=E.
%
%   Default: (A,B,C,D,E) = (1,-10,0,10,1) (a matrix of Rutishauser).
%   This matrix has eigenvalues lying approximately on the line segment
%   2*cos(2*t) + 20*i*sin(t).
%
%   This function is written following the toeppen function of Matlab

%   The pseudospectra of the following matrices are interesting:
%   SMTGALLERY('TTOEPPEN',32,0,1,0,0,1/4)  - `triangle'
%   SMTGALLERY('TTOEPPEN',32,0,1/2,0,0,1)  - `propeller'
%   SMTGALLERY('TTOEPPEN',32,0,1/2,1,1,1)  - `fish'
%
%   References:
%   [1] R. M. Beam and R. F. Warming, The asymptotic spectra of banded
%   Toeplitz and quasi-Toeplitz matrices, SIAM J. Sci. Comput. 14 (4),
%   1993, pp. 971-1006.
%   [2] H. Rutishauser, On test matrices, Programmation en Mathematiques
%   Numeriques, Editions Centre Nat. Recherche Sci., Paris, 165, 1966,
%   pp. 349-365.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 26, 2009

if nargin<1
	error('Missing dimension.')
end

if nargin<2 || isempty(a), a = 1;   end
if nargin<3 || isempty(b), b = -10; end
if nargin<4 || isempty(c), c = 0;   end
if nargin<5 || isempty(d), d = 10;  end
if nargin<6 || isempty(e), e = 1;   end

co = spalloc(n,1,3);
ro = spalloc(n,1,3);
co(1:3) = [c b a]; 
ro(1:3) = [c d e];

A = smtoep(co,ro);
