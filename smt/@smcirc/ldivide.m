function T = ldivide(T,S)
%.\  Left array divide.
%
%   C.\D denotes element-by-element division. C and D must
%   have the same dimensions unless one is a scalar.
%   A scalar can be divided with anything.
%
%   A = LDIVIDE(C,D) is called for the syntax 'C .\ D' when C
%   or D is a smcirc matrix. The result is a smcirc matrix only
%   when one of the arguments is of class smcirc and the other
%   is a scalar or a smcirc matrix of dimension 1, or when both
%   arguments are smcirc matrices, otherwise it is a full array.
%
%   See also SMCIRC/RDIVIDE, SMCIRC/MLDIVIDE, SMCIRC/MRDIVIDE.

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
		error('Function ''.\'' is not defined for values of class ''sparse''.')
	else
		error('Function ''.\'' is not defined for values of class ''%s''.', c)
	end
end

msT = max(size(T));
msS = max(size(S));

if any(size(T)-size(S)) && (msT~=1) && (msS~=1)
% Check that the dimensions are valid.
	error('Matrix dimensions must agree.')
end

if msT+msS < 2
% One of the operands is a smcirc empty matrix and the other is a
% scalar or empty matrix.
	T = smcirc;
	return
end

if msT == 1
% If T is scalar, make it a smcirc object.
	T = smcirc(full(T));
end

if isa(T,'smcirc')
% T is a smcirc object.
	if msS == 1
	% If S is scalar turn it into a smcirc object.
		S = smcirc(full(S));
	elseif isa(S,'smtoep')
	% T is a smcirc object and S is a smtoep object.
	% The result is a smtoep object.
		T = smtoep(T);
		T = T .\ S;
		return
	end
	if isa(S,'smcirc')
	% Both T and S are general smcirc objects.
	% The result is a smcirc object.
		T.c = T.c .\ S.c;
		if msT == 1
		% T is a scalar smcirc object.
			if smtconfig('crautoeig')
				T.ev = eig(T) .\ eig(S);
			else
				T.ev = [];
			end
			T.dim = S.dim;
		else
			T.ev = [];
			if smtconfig('crautoeig')
				T.ev = eig(T);
			end
		end
	else
	% T is a smcirc object and S a general array.
	% The result is a full array.
		T = full(T) .\ S;
	end
else
% T is a general array, and S is a smcirc object.
% The result is a full array.
	T = T .\ full(S);
end

