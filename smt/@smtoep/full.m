function T = full(T)
%FULL Convert smtoep matrix to a full matrix.
%
%   A = FULL(T) converts a Toeplitz matrix T, stored as smtoep
%   object, to full storage organization.
%
%   See also SMTOEP, ISSMTOEP.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if isempty(T)
	T = [];
else
	T = toeplitz(full(T.t(T.dim2:T.dim2+T.dim1-1)),full(T.t(T.dim2:-1:1)));
end

