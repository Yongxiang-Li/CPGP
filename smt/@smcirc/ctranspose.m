function C = ctranspose(C)
%'  Complex conjugate transpose.
%
%   C' is the complex conjugate transpose of C.
%
%   A = CTRANSPOSE(C) is called for the syntax C' (complex
%   conjugate transpose) when C is a smcirc matrix.
%
%   See also SMCIRC/TRANSPOSE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 21, 2010

if isreal(C.c(1)) && all(C.c(2:C.dim) == conj(C.c(C.dim:-1:2)))
	return	% do nothing if matrix is Hermitian
end
if ~isempty(C)
	if smtconfig('crautoeig')
		C.ev = conj(eig(C));
	else
		C.ev = [];
	end
	C.c = conj(C.c([1,C.dim:-1:2]));
end

