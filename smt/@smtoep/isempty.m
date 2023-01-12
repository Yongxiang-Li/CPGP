function is = isempty(T)
%ISEMPTY True for an empty smtoep matrix.
%
%   ISEMPTY(T) returns 1 if T is an empty object of the smtoep
%   class and 0 otherwise. An empty smtoep matrix has no
%   elements, that is prod(size(T))==0.

%
%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if max([T.dim1;T.dim2]) == 0
	is = 1;
else
	is = 0;
end
