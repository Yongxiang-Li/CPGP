function [V,D] = eig(C)
%EIG Eigenvalues and eigenvectors of a smcirc matrix.
%
%   E = EIG(C) is a vector containing the eigenvalues of the smcirc
%   matrix C.
%
%   [V,D] = EIG(C) produces a diagonal matrix D of eigenvalues and a
%   full matrix V whose columns are the corresponding eigenvectors so
%   that C*V = V*D.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised October 20, 2010

if nargin > 1
	error('Computation of generalized eigenvalues still not implemented.')
end

if isempty(C.ev)
	V = fft(full(C.c));
else
	V = C.ev;
end

if nargout > 1
	D = diag(V);
	V = sqrt(C.dim) * ifft(eye(C.dim));
end

