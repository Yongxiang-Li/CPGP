function C = superopt(T,method)
%SUPEROPT superoptimal circulant preconditioner.
%
%   C = SMTCPREC('SUPEROPT',A,method) returns a smcirc matrix 
%   containing the superoptimal preconditioner of the matrix A.
%
%   The computation is fast only if A is a smtoep matrix.
%   In this case, if method=0 or the parameter is omitted the 
%   computation is performed by the Chan/Tismenestky algorithm.
%   If method=1 the Tyrtyshnikov algorithm is used.
%
%   If A is a smcirc matrix, C is A itself.

%   References:
%   [1] R.H. Chan, X.Q. Jin, and M.C. Yeung, The circulant operator in the
%       Banach algebra of matrices, Linear Algebra Appl., 149:41-53, 1991.
%   [2] M. Tismenetsky, A decomposition of Toeplitz matrices and optimal
%       circulant preconditioning, Linear Algebra Appl., 154/156:105-121, 1991.
%   [3] E.E. Tyrtyshnikov, Optimal and superoptimal circulant preconditioners,
%       SIAM J. Matrix Anal. Appl., 13(2):459-473, 1992.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if (nargin < 2) || isempty(method)
	method = 0;
end

if size(T,1) ~= size(T,2)
	error('Matrix must be square.')
end

if isa(T,'smcirc')
	C = T;
elseif isa(T,'smtoep')
	switch method
	case 0
		C = chantis(T);
	case 1
		C = tyrty(T);
	otherwise
		error('Unknown method.')
	end
elseif isfloat(T)
	C = supgeneral(T);
else
	error('Superoptimal preconditioner is not implemented for an object of this class.')
end


function C = chantis(T)
% Chan/Tismenetsky algorithm for the construction of superoptimal
% preconditioner.
% This implementation is described in:
% [1] C.V.M. van der Mee, G. Rodriguez, and S. Seatzu, Computing two-level
%     circulant preconditioners, submitted.
n = T.dim1;
eta = exp(2*pi*sqrt(-1)/n);
omega = exp(pi*sqrt(-1)/n);
omegavet = omega.^(0:-1:-n+1).';
d0 = fft(full([T.t(n)/2; (T.t(n+1:2*n-1)+T.t(1:n-1))/2]));
c1omega = full([T.t(n)/2; (T.t(n+1:2*n-1)-T.t(1:n-1))/2]) .* omegavet;
d1 = fft(c1omega);
e = 2 ./ (n * (1-omega*eta.^(0:-1:-n+1).'));
m = e .* conj(e);
% these instructions ...
%	mh = fft(m);
%	gam1 = ifft(mh.*fft(d1));
%	gam = d0.*conj(d0) + 2*real(d0.*conj(gam1)) ...
%		+ ifft(mh.*fft(d1.*conj(d1)));
% ... have been modified to reduce the number of fft's
mhi = ifft(m);
gam1 = n*fft(mhi.*c1omega);
gam = d0.*conj(d0) + 2*real(d0.*conj(gam1)) + n*fft(mhi.*ifft(d1.*conj(d1)));
%
gam = gam ./ conj(d0 + gam1);
col = ifft(gam);
if isreal(T)
	col = real(col);
end
C = smcirc(col,gam,'eigenvalues');


function C = tyrty(A)
% Tyrtyshnikov algorithm for the construction of superoptimal preconditioner.
% This implementation is described in:
% [1] C.V.M. van der Mee, G. Rodriguez, and S. Seatzu, Computing two-level
%     circulant preconditioners, submitted.
n = A.dim1;
if isequal(A,A')
% The matrix is Hermitian.
	L = smtoep([A.t(n)/2;A.t(n+1:2*n-1)],[A.t(n)/2;zeros(n-1,1)]);
	L = toeprem(L);
	c1 = L*((1:n)'.*conj(L.t(2*n-1:-1:n)));
	c1 = ( [0;c1(1:n-1)] + L'*((n:-1:1)'.*L.t(n:2*n-1)) ) / n;
	t = L * L(:,1);
	T = smtoep(t,[t(1);zeros(n-1,1)]);
	T = T + T';
	% compute C0=optimal(T) directly, saving one fft.
	c0 = zeros(n,1);
	c0(1) = T.t(n);
	iv = (1:n-1)';
	c0(iv+1) = ((n-iv).*T.t(iv+n) + iv.*T.t(iv)) / n;
	CAA = smcirc(c0 + 2*c1);
	C = optimal(A') \ CAA;
else
% General case.
	L = smtoep([A.t(n)/2;A.t(n+1:2*n-1)],[A.t(n)/2;zeros(n-1,1)]);
	U = smtoep([A.t(n)/2;zeros(n-1,1)],[A.t(n)/2;A.t(n-1:-1:1)]);
	L = toeprem(L);
	U = toeprem(U);
	c1 = L*((1:n)'.*conj(full(L.t(2*n-1:-1:n))));
	c1 = ( [0;c1(1:n-1)] + L'*((n:-1:1)'.*full(L.t(n:2*n-1))) ) / n;
	c2 = U'*((1:n)'.*full(U.t(1:n)));
	c2 = ( [0;c2(1:n-1)] + U*((n:-1:1)'.*conj(full(U.t(n:-1:1)))) ) / n;
	t = L * (U(1,:)');
	T = smtoep(t,[t(1);zeros(n-1,1)]);
	T = T + T';
	% compute C0=optimal(T) directly, saving one fft.
	c0 = zeros(n,1);
	c0(1) = T.t(n);
	iv = (1:n-1)';
	c0(iv+1) = ((n-iv).*T.t(iv+n) + iv.*T.t(iv)) / n;
	CAA = smcirc(c0 + c1 + c2);
	C = optimal(A') \ CAA;
end


function C = optgeneral(A)
% Construction of optimal circulant preconditioner for a full or sparse matrix.
n = size(A,1);
c = zeros(n,1);
[D d] = spdiags(A);
sumdiag = D.' * ones(size(D,1),1);
kpos = find(d>=0);
kneg = find(d<0);
c(d(kpos)+1) = sumdiag(kpos);
c(d(kneg)+n+1) = c(d(kneg)+n+1) + sumdiag(kneg);
C = smcirc(c([1,end:-1:2])/n);


function C = supgeneral(A)
% Construction of superoptimal preconditioner for a full or sparse matrix.
CAA = optgeneral(A*A');
CAS = optgeneral(A');
C = CAS \ CAA;
