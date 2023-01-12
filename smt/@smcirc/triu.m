function A = triu(C,offset)
%TRIU   Extract upper triangular part.
%
%   TRIU(C) is a full matrix containing the upper triangular
%   part of the smcirc matrix C.
%   TRIU(C,K) is the elements on and above the K-th diagonal of
%   C.  K = 0 is the main diagonal, K > 0 is above the main
%   diagonal and K < 0 is below the main diagonal.
%
%   See also SMCIRC/TRIL, SMCIRC/DIAG.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if nargin == 1
	offset = 0;
end

A = triu(smtoep(C),offset);
