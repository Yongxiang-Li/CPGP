function C = imag(C)
%IMAG   Complex imaginary part.
%
%   IMAG(C) is the imaginary part of smcirc matrix C.
%   See I or J to enter complex numbers.
%
%   See also SMCIRC/ISREAL, SMCIRC/REAL, SMCIRC/CONJ, 
%            SMCIRC/ANGLE, SMCIRC/ABS.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = imag(C.c);
C.ev = [];
if smtconfig('crautoeig')
	C.ev = eig(C);
end

