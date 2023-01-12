function T = transpose(T)
%.' Transpose.
%
%   T.' is the non-conjugate transpose of T.
%
%   A = TRANSPOSE(T) is called for the syntax T.' when T is a 
%   smtoep matrix.
%
%   See also SMTOEP/CTRANSPOSE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 22, 2011

if ~isempty(T)
	if (T.dim1 == T.dim2) && all(T.t == T.t(T.dim1+T.dim2-1:-1:1))
		return	% do nothing if matrix is symmetric
	end
	T.t = T.t(T.dim1+T.dim2-1:-1:1);
	tmp = T.dim1;
	T.dim1 = T.dim2;
	T.dim2 = tmp;
	if ~isempty(T.cev)
		T.cev = T.cev([1 end:-1:2]);
	end
end

