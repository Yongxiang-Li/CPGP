function C = optimal(T)
%OPTIMAL optimal circulant preconditioner.
%
%   C = SMTCPREC('OPTIMAL',A) returns a smcirc matrix containing
%   the optimal preconditioner of the matrix A.
%
%   The computation is fast only if A is a smtoep matrix.
%   If A is a smcirc matrix, C is A itself.

%   Reference:
%   [1] T.F. Chan, An optimal circulant preconditioner for Toeplitz systems,
%       SIAM J. Sci. Stat. Comput., 9(4):766-771, 1988.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if size(T,1) ~= size(T,2)
	error('Matrix must be square.')
end

if isa(T,'smcirc')
	C = T;
elseif isa(T,'smtoep')
	n = T.dim1;
	c = zeros(n,1);
	c(1) = T.t(n);
	iv = (1:n-1)';
	c(iv+1) = ((n-iv).*T.t(iv+n) + iv.*T.t(iv)) / n;
	C = smcirc(c);
elseif isfloat(T)
	C = optgeneral(T);
else
	error('Optimal preconditioner is not implemented for a matrix of this class.')
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
