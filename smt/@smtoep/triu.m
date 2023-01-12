function S = triu(T,offset)
%TRIU   Extract upper triangular part.
%
%   TRIU(T) is a smtoep matrix containing the upper triangular 
%   part of the smtoep matrix T.
%   TRIU(T,K) is the elements on and above the K-th diagonal of
%   T.  K = 0 is the main diagonal, K > 0 is above the main
%   diagonal and K < 0 is below the main diagonal.
%
%   See also SMTOEP/TRIL, SMTOEP/DIAG.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if nargin == 1 
	offset = 0; 
end

if -offset >= T.dim1-1 
	S = T;
	return
end

if offset >= T.dim2
	S = smtoep(zeros(length(T.t),1),T.dim1,T.dim2);
	return
end

S = smtoep([T.t(1:T.dim2-offset);zeros(T.dim1+offset-1,1)],T.dim1,T.dim2);

