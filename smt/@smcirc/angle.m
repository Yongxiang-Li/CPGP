function C = angle(C)
%ANGLE  Phase angle.
%
%   ANGLE(C) returns the phase angles, in radians, of 
%   smcirc matrix with complex elements.
%
%   See also SMCIRC/ISREAL, SMCIRC/REAL, SMCIRC/IMAG, 
%            SMCIRC/CONJ, SMCIRC/ABS.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = angle(C.c); 
C.ev = [];
if smtconfig('crautoeig')
	C.ev = eig(C);
end

