function C = fix(C)
%FIX    Matrix element-wise integer part.
%
%   FIX(C) rounds the elements of C to the nearest integers
%   towards zero.
%   FIX(C) = FLOOR(C) if C is positive and CEIL(C) if C is 
%   negative.
%
%   See also SMCIRC/FLOOR, SMCIRC/ROUND, SMCIRC/CEIL 

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = fix(C.c);
C.ev = [];
if smtconfig('crautoeig')
	C.ev = eig(C);
end

