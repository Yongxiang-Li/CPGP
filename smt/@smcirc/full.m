function C = full(C)
%FULL Convert smcirc matrix to a full matrix.
%
%   A = FULL(C) converts a circulant matrix C, stored as smcirc
%   object, to full storage organization.
%
%   See also SMCIRC, ISSMCIRC.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if isempty(C)
	C = [];
else
	C = toeplitz(full(C.c),full(C.c([1,C.dim:-1:2])));
end

