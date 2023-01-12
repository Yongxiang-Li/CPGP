function T = ttriw(n, alpha, k)
%TTRIW   Upper triangular matrix discussed by Wilkinson and others.
%   SMTGALLERY('TTRIW',N,ALPHA,K) is the upper triangular matrix with
%   ones on the diagonal and ALPHAs on the first K >= 0 superdiagonals.
%   N may be a 2-vector, in which case the matrix is N(1)-by-N(2)
%   and upper trapezoidal.
%   The defaults are ALPHA = -1, and K = N - 1. This yields the full
%   upper triangular matrix discussed by Kahan, Golub and Wilkinson.
%
%   Notes:
%   Ostrowski [3] shows that
%     COND(TTRIW(N,2)) = COT(PI/(4*N))^2,
%   and for large ABS(ALPHA),
%     COND(TTRIW(N,ALPHA)) is approx. ABS(ALPHA)^N*SIN(PI/(4*N-2)).
%
%   Adding -2^(2-N) to the (N,1) element makes TTRIW(N) singular,
%   as does adding -2^(1-N) to all elements in the first column.
%
%   This function is written following the triw function of Matlab

%   References:
%   [1] G. H. Golub and J. H. Wilkinson, Ill-conditioned eigensystems and
%       the computation of the Jordan canonical form, SIAM Review,
%       18(4), 1976, pp. 578-619.
%   [2] W. Kahan, Numerical linear algebra, Canadian Math. Bulletin,
%       9 (1966), pp. 757-801.
%   [3] A. M. Ostrowski, On the spectrum of a one-parametric family of
%       matrices, J. Reine Angew. Math., 193 (3/4), 1954, pp. 143-160.
%   [4] J. H. Wilkinson, Singular-value decomposition---basic aspects,
%       in D.A.H. Jacobs, ed., Numerical Software---Needs and Availability,
%       Academic Press, London, 1978, pp. 109-135.
%   [5] N. J. Higham. The Test Matrix Toolbox for MATLAB (version 3.0).
%       Numerical Analysis Report No. 276, Manchester Centre for Computational
%       Mathematics, Manchester, England, September 1995.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 28, 2009

if nargin<1
    error('Missing dimension.')
end

if length(n)>2
    error('n must be at most a 2-vector')
end

m = n(1);              % Parameter n specifies dimension: m-by-n.
n = n(length(n));

if nargin<3 || isempty(k), k = n-1; end
if nargin<2 || isempty(alpha), alpha = -1; end

c = zeros(m,1);
r = zeros(n,1);
if k>=0
    c(1) = 1;
    r = [1 alpha.*ones(1,min(k,n-1)) zeros(1,n-k-1)];
end

T = smtoep(c,r);
