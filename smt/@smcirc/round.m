function C = round(C)
%ROUND  Matrix element-wise round.
%
%   ROUND(C) rounds the elements of C to the nearest integers.
%
%   See also SMCIRC/FLOOR, SMCIRC/CEIL, SMCIRC/FIX 

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = round(C.c);
C.ev = [];
if smtconfig('crautoeig')
	C.ev = eig(C);
end

