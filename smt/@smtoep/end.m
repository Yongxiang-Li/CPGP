function endval = end(T,k,n)
%END Last index in an indexing expression of a smtoep matrix.
%
%   END(T,K,N) is called for indexing expressions involving the
%   matrix T when END is part of the K-th index out of N indices.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if n ~= 2
	error('Uncorrect number of indices.')
end

switch k
case 1
	endval = T.dim1;
case 2
	endval = T.dim2;
otherwise
	error('Uncorrect number of indices.')
end
