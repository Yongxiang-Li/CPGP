function A = tril(C,offset)
%TRIL   Extract lower triangular part.
%
%   TRIL(C) is a full matrix containing the lower triangular
%   part of the smcirc matrix C.
%   TRIL(C,K) is the elements on and below the K-th diagonal
%   of C.  K = 0 is the main diagonal, K > 0 is above the
%   main diagonal and K < 0 is below the main diagonal.
%
%   See also SMCIRC/TRIU, SMCIRC/DIAG.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if nargin == 1
	offset = 0;
end

A = tril(smtoep(C),offset);
