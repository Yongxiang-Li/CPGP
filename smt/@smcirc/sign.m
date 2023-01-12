function C = sign(C)
%SIGN   Signum function.
%
%   For each element of a smcirc matrix C, SIGN(C) returns a
%   smcirc matrix were a component is 1 if the element of C
%   is greater than zero, 0 if it equals zero and -1 if it is
%   less than zero.  For the nonzero elements of complex C,
%   SIGN(C) = C ./ ABS(C).
%
%   See also SMCIRC/ABS.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = sign(C.c);
C.ev = [];
if smtconfig('crautoeig')
	C.ev = eig(C);
end

