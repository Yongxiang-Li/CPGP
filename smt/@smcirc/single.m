function C = single(C)
%SINGLE Convert to single precision.
%
%   SINGLE(C) converts a smcirc matrix C to single precision.
%   If C is already stored in single precision, SINGLE has no 
%   effect.
%
%   See also SMCIRC/DOUBLE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = single(C.c);
if smtconfig('crautoeig')
	C.ev = single(eig(C));
else
	C.ev = [];
end

