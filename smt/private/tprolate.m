function A = tprolate(n, w)
%TPROLATE Prolate Toeplitz matrix (symmetric, ill-conditioned matrix).
%
%   A = SMTGALLERY('TPROLATE',N,W) is the N-by-N prolate matrix with
%   parameter W. It is a symmetric Toeplitz matrix.
%   If 0 < W < 0.5 then
%     1. A is positive definite
%     2. The eigenvalues of A are distinct, lie in (0, 1), and tend to
%        cluster around 0 and 1.
%   W defaults to 0.25.
%
%   This function is written following the prolate function of Matlab.

%   Reference:
%   J. M. Varah. The Prolate matrix. Linear Algebra and Appl.,
%   187:269-278, 1993.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 26, 2009

if nargin<1
	error('Missing dimension.')
end

if nargin<2 || isempty(w), w = 0.25; end

a = zeros(n,1);
a(1) = 2*w;
a(2:n) = sin( 2*pi*w*(1:n-1) ) ./ ( pi*(1:n-1) );

A = smtoep(a);
