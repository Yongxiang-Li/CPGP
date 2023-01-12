function D = diag(C,offset)
%DIAG Diagonals of a smcirc matrix.
%
%   DIAG(C,K) when C is a smcirc matrix is a column vector
%   formed from the elements of the K-th diagonal of C.
%   DIAG(C) is the main diagonal of C.
%
%   See also SMCIRC/TRIU, SMCIRC/TRIL.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if nargin == 1
	offset = 0;
end

D = [];
lC = length(C);

if abs(offset) >= lC
	return
end

if offset > 0
	ind = lC-offset+1;
else
	ind = abs(offset)+1;
end

D = C.c(ind).*ones(lC-abs(offset),1);
