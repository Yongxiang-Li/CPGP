function T = ctranspose(T)
%'  Complex conjugate transpose.
%
%   T' is the complex conjugate transpose of T.
%
%   A = CTRANSPOSE(T) is called for the syntax T' (complex
%   conjugate transpose) when T is a smtoep matrix.
%
%   See also SMTOEP/TRANSPOSE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 21, 2011

if ~isempty(T)
	if (T.dim1 == T.dim2) && all(T.t == conj(T.t(T.dim1+T.dim2-1:-1:1)))
		return	% do nothing if matrix is Hermitian
	end
	T.t = conj(T.t(T.dim1+T.dim2-1:-1:1));
	tmp = T.dim1;
	T.dim1 = T.dim2;
	T.dim2 = tmp;
	T.cev = conj(T.cev);
end

