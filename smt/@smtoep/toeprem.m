function [T,C] = toeprem(T)
%TOEPREM Toeplitz premultiplication.
%
%   S = TOEPREM(T) returns a smtoep object S representing the
%   same Toeplitz matrix T with, in addition, the eigenvalues
%   of the circulant matrix C in which T is embedded.
%
%   [S,C] = TOEPREM(T) returns S as in the previous case, but
%   also the circulant matrix C as a smcirc object.
%
%   Premultiplication speeds up multiplication of a smtoep
%   matrix by another array.
%
%   See also SMTOEP.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised August 11, 2011

if ~isempty(T)
	% Get the dimension of the circulant matrix for embedding T.
	immfun = smtconfig('tpemb');
	N = immfun(T.dim1,T.dim2);
	C = smcirc([T.t(T.dim2:T.dim1+T.dim2-1);zeros(N-T.dim1-T.dim2+1,1); ...
		T.t(1:T.dim2-1)]);
	v = eig(C);
	if ~isempty(T.cev)
		warning('SMT:smtoep:ExistingCevField', ...
			'The ''cev'' field of the argument is not empty.')
		if (size(v,1) ~= size(T.cev,1))
		% We should never end up here.
			error('The dimension of the ''cev'' field of the argument is wrong.')
		end
	else
		T.cev = v;
	end
else
	C=smcirc;
end

