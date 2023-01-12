function endval = end(C,k,n)
%END Last index in an indexing expression of a smcirc matrix.
%
%   END(C,K,N) is called for indexing expressions involving the
%   matrix C when END is part of the K-th index out of N indices.

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
case {1,2}
	endval = C.dim;
otherwise
end
