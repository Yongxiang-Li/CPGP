function T = power(T,S)
%.^  Array power.
%
%   C.^D denotes element-by-element powers. C and D
%   must have the same dimensions unless one is a scalar.
%   A scalar can operate into anything.
%
%   A = POWER(C,D) is called for the syntax 'C .^ D' when C or
%   D is a smcirc object. The result is a smcirc matrix only
%   when one of the arguments is of class smcirc and the other
%   is a scalar or a smcirc matrix of dimension 1, or when both
%   arguments are smcirc matrices, otherwise it is a full array.
%
%   See also SMCIRC/MPOWER.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

if ~smtvalid(T) || ~smtvalid(S)
% Check if the operands are valid.
	if ~smtvalid(T)
		c=class(T);
		isspa = issparse(T);
	else
		c=class(S);
		isspa = issparse(S);
	end
	if isspa
		error('Function ''.^'' is not defined for values of class ''sparse''.')
	else
		error('Function ''.^'' is not defined for values of class ''%s''.', c)
	end
end

msT = max(size(T));
msS = max(size(S));

if any(size(T)-size(S)) && (msT~=1) && (msS~=1)
% Check that the dimensions are valid.
	error('Matrix dimensions must agree.')
end

if msT+msS < 2
% One of the operands is a smcirc empty object and the other is a
% scalar or empty matrix.
	T = smcirc;
	return
end

if isa(T,'smcirc')	
% T is a smcirc object.
	if msS == 1
		S = full(S);
	elseif isa(S,'smtoep')
	% T is a smcirc object and S is a smtoep object.
	% The result is a smtoep object.
		T = smtoep(T);
		T = T .^ S;
		return
	end
	if isa(S,'smcirc')
	% Both T and S are general smcirc objects.
	% The result is a smcirc object.
		T.c = T.c .^ S.c;
		T.dim = max(T.dim,S.dim);
		T.ev = [];
		if smtconfig('crautoeig')
			T.ev = eig(T);
		end
	elseif msS == 1
	% T is a smcirc object and S a scalar.
	% The result is a smcirc object.
		T.c = T.c .^ S;
		T.ev = [];
		if smtconfig('crautoeig')
			T.ev = eig(T);
		end
	else
	% T is a smcirc object and S a general float array.
	% The result is a full array.
		T = full(T) .^ S;
	end
else
% T is not smcirc, so S is.
	if msT == 1
	% T is a scalar and S is a smcirc object.
	% The result is a smcirc object.
		S.c = T .^ S.c;
		S.ev = [];
		if smtconfig('crautoeig')
			S.ev = eig(S);
		end
		T = S;
	else
	% S is a smcirc object and T a general float array.
	% The result is a full array.
		T = T .^ full(S);
	end
end

