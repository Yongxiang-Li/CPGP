function C = uminus(C)
%-  Unary minus.
%
%   -C negates the elements of the smcirc matrix C.
%
%   A = UMINUS(C) is called for the syntax '-C' when C is a
%       smcirc object.
%
%   See also SMCIRC.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

C.c = -C.c;
if smtconfig('crautoeig')
	C.ev = -eig(C);
else
	C.ev = [];
end


