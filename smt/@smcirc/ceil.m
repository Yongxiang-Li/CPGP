function C = ceil(C)
%CEIL   Matrix element-wise ceiling.
%
%   CEIL(C) rounds the elements of C to the nearest integers
%   towards infinity.
%
%   See also SMCIRC/FLOOR, SMCIRC/ROUND, SMCIRC/FIX 

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = ceil(C.c);
C.ev = [];
if smtconfig('crautoeig')
	C.ev = eig(C);
end

