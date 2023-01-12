function C = abs(C)
%ABS    Absolute value.
%
%   ABS(C) is the absolute value of the elements of smcirm
%   matrix C. When C is complex, ABS(C) is the complex 
%   modulus (magnitude) of the elements of C.
%
%   See also SMCIRC/SIGN, SMCIRC/ANGLE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = abs(C.c);
C.ev = [];
if smtconfig('crautoeig')
	C.ev = eig(C);
end

