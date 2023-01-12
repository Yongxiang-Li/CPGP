function D = diag(T,offset)
%DIAG Diagonals of a smtoep matrix.
%
%   DIAG(T,K) when T is a smtoep matrix is a column vector
%   formed from the elements of the K-th diagonal of T.
%   DIAG(T) is the main diagonal of T.
%
%   See also SMTOEP/TRIU, SMTOEP/TRIL.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

mind = min(T.dim1,T.dim2);
D = [];

if nargin == 1
	offset = 0;
end

if (offset >= T.dim2) || (-offset >= T.dim1)
	return
end

if offset > 0
	nel = min(T.dim2-offset,mind);
else
	nel = min(T.dim1+offset,mind);
end

D = T.t(T.dim2-offset).*ones(nel,1);
