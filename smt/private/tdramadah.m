function A = tdramadah(n, k)
%TDRAMADAH Matrix of zeros and ones with large determinant or inverse.
%   A = SMTGALLERY('TDRAMADAH',N,K) is an N-by-N (0,1) matrix for which
%   MU(A) = NORM(INV(A),'FRO') or DET(A) is relatively large.
%
%   K = 1: (default)
%      A is Toeplitz, with ABS(DET(A)) = 1, and MU(A) > c(1.75)^N,
%      where c is a constant. INV(A) has integer entries.
%   K = 2:
%      A is upper triangular and Toeplitz. INV(A) has integer entries.
%   K = 3:
%      A has maximal determinant among (0,1) lower Hessenberg matrices.
%      DET(A) = the n'th Fibonacci number. A is Toeplitz.
%      The eigenvalues have an interesting distribution in the complex
%      plane.
%
%   An anti-Hadamard matrix A is a matrix with elements 0 or 1 for
%   which MU(A) = NORM(INV(A),'FRO') is maximal.  For K = 1,2 this function
%   returns matrices with MU(A) relatively large, though not necessarily
%   maximal.
%
%   This function is written following the dramadah function of Matlab

%   References:
%   [1] R. L. Graham and N. J. A. Sloane, Anti-Hadamard matrices,
%       Linear Algebra and Appl., 62 (1984), pp. 113-137.
%   [2] L. Ching, The maximum determinant of an nxn lower Hessenberg
%       (0,1) matrix, Linear Algebra and Appl., 183 (1993), pp. 147-153.
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

if nargin<2 || isempty(k), k=1; end

if k == 1  % Toeplitz

	c = ones(n,1);
	for i=2:4:n
		m = min(1,n-i);
		c(i:i+m) = zeros(m+1,1);
	end
	r = zeros(n,1);
	r(1:4) = [1 1 0 1];
	if n < 4, r = r(1:n); end
	A = smtoep(c,r);

elseif k == 2  % Upper triangular and Toeplitz

	c = zeros(n,1);
	c(1) = 1;
	r = ones(n,1);
	for i=3:2:n
		r(i) = 0;
	end
	A = smtoep(c,r);

elseif k == 3  % Lower Hessenberg.

	c = ones(n,1);
	for i=2:2:n, c(i)=0; end;
	A = smtoep(c, [1 1 zeros(1,n-2)]);

end
