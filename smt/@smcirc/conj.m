function C = conj(C)
%CONJ   Complex conjugate.
%
%   CONJ(C) is the complex conjugate of smtoep matrix T.
%   For a complex C, CONJ(C) = REAL(C) - i*IMAG(C).
%
%   See also SMCIRC/ISREAL, SMCIRC/REAL, SMCIRC/IMAG, 
%            SMCIRC/ANGLE, SMCIRC/ABS.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

if ~isreal(C.c)
	if smtconfig('crautoeig')
		ev = eig(C);
		C.ev = conj(ev([1 end:-1:2]));
	else
		C.ev = [];
	end
	C.c = conj(C.c);
end

