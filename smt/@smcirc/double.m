function C = double(C)
%DOUBLE Convert to double precision.
%
%   DOUBLE(C) converts a smcirc matrix C to double precision.
%   If C is already stored in double precision, DOUBLE has no 
%   effect.
%
%   See also SMCIRC/SINGLE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = double(C.c);
if smtconfig('crautoeig')
	C.ev = double(eig(C));
else
	C.ev = [];
end
