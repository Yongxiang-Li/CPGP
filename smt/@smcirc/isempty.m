function is = isempty(C)
%ISEMPTY True for an empty smcirc matrix.
%
%   ISEMPTY(C) returns 1 if A is an empty object of the smcirc
%   class and 0 otherwise. An empty smcirc matrix has no
%   elements, that is prod(size(C))==0.

%
%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if C.dim == 0
	is = 1;
else
	is = 0;
end
