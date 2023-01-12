function C = strang(T)
%STRANG Strang circulant preconditioner for a Toeplitz matrix.
%
%   C = SMTCPREC('STRANG',A) returns a smcirc matrix containing
%   the Strang preconditioner of the smtoep matrix A.

%   Reference:
%   [1] G. Strang, A proposal for Toeplitz matrix calculations, Stud. Appl.
%       Math., 74:171-176, 1986.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 25, 2009

if size(T,1) ~= size(T,2)
	error('Matrix must be square.')
end

if isa(T,'smcirc')
	C = T;
elseif isa(T,'smtoep')
	n = T.dim1;
	c = zeros(n,1);
	m = floor(n/2);
	c(1:m+1) = T.t(n:n+m);
	c(m+2:n) = T.t(m+1:n-1);
	C = smcirc(c);
else
	error('Strang preconditioner is not defined for a matrix of this class.')
end
