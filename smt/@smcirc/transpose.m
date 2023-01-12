function C = transpose(C)
%.' Transpose.
%
%   C.' is the non-conjugate transpose of C.
%
%   A = TRANSPOSE(C) is called for the syntax C.' when C is a
%   smcirc matrix.
%
%   See also SMCIRC/CTRANSPOSE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 22, 2011

if ~isempty(C)
	if all(C.c(2:C.dim) == C.c(C.dim:-1:2))
		return	% do nothing if matrix is symmetric
	end
	if smtconfig('crautoeig')
		ev = eig(C);
		C.ev = ev([1 C.dim:-1:2]);
	else
		C.ev = [];
	end
	C.c(2:C.dim) = C.c(C.dim:-1:2);
end


