function A = ttridiag(n, c, d, e)
%TRIDIAG Tridiagonal Toeplitz matrix (sparse).
%
%   SMTGALLERY('TTRIDIAG',N,C,D,E), where C, D, and E are all scalars,
%   yields the Toeplitz (sparse) tridiagonal matrix of order N with 
%   subdiagonal elements C, diagonal elements D, and superdiagonal 
%   elements E. This matrix has eigenvalues: 
%   D + 2*SQRT(C*E)*COS(k*PI/(N+1)), k=1:N.
%   If C and/or D and/or E are missing or empty, then C=E=-1, D=2.
%
%   SMTGALLERY('TTRIDIAG',N) is the same as SMTGALLERY('TTRIDIAG',N,-1,2,-1),
%   which is a symmetric positive definite M-matrix (the negative of the
%   second difference matrix).
%
%   This function is written following the tridiag function of Matlab

%   References:
%   [1] J. Todd, Basic Numerical Mathematics, Vol 2: Numerical Algebra,
%       Birkhauser, Basel, and Academic Press, New York, 1977, p. 155.
%   [2] D. E. Rutherford, Some continuant determinants arising in
%       physics and chemistry---II, Proc. Royal Soc. Edin., 63,
%       A (1952), pp. 232-241.
%   [3] N. J. Higham. The Test Matrix Toolbox for MATLAB (version 3.0).
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

if nargin<4 || isempty(c) || isempty(d) || isempty(e)
	c = -1; d = 2; e = -1; 
end

if max( [ size(c) size(d) size(e) ] ) ~= 1
	error('Arguments must be scalars.')
end   

co = spalloc(n,1,2);
ro = spalloc(n,1,2);
co(1:2) = [d c]; 
ro(1:2) = [d e];

A = smtoep(co,ro);
