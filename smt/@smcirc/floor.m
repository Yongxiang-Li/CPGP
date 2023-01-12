function C = floor(C)
%FLOOR  Matrix element-wise floor.
%
%   FLOOR(C) rounds the elements of C to the nearest integers
%   towards minus infinity.
%
%   See also SMCIRC/ROUND, SMCIRC/CEIL, SMCIRC/FIX 

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = floor(C.c);
C.ev = [];
if smtconfig('crautoeig')
	C.ev = eig(C);
end

