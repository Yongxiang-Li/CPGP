function T = plus(T,S)
%+  Plus.
%
%   C + D adds matrices C and D. C and D must have the same
%   dimensions unless one is a scalar. A scalar can be added
%   to anything.
%
%   A = PLUS(C,D) is called for the syntax 'C + D' when C or D
%   is a smcirc object. The result is a smcirc matrix only when
%   one of the arguments is of class smcirc and the other is a
%   scalar or a smcirc matrix of dimension 1, or when both
%   arguments are smcirc matrices, otherwise it is a full array.
%
%   See also SMCIRC/MINUS.

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
		error('Function ''+'' is not defined for values of class ''sparse''.')
	else
		error('Function ''+'' is not defined for values of class ''%s''.', c)
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

if (msT==1) && (msS==1)
% Both operands are scalar.
% The result is a smcirc object.
	T = smcirc(full(T)+full(S));
	return
end

if (msT == 1) && issmcirc(T)
% T is scalar.
% The result is of the same kind as S.
	T = full(T) + S;
	return
end

if isa(T,'smcirc')
% T is a smcirc object.
	if msS == 1
	% T is a smcirc object and S a scalar.
	% The result is a smcirc object.
		S = full(S);
		T.c = T.c + S;
		if smtconfig('crautoeig')
			ev = eig(T);
			ev(1) = ev(1) + T.dim*S;
			T.ev = ev;
		else
			T.ev = [];
		end
	elseif isa(S,'smtoep')
	% T is a smcirc object and S is a smtoep object.
	% The result is a smtoep object.
		T = smtoep(T.c([2:T.dim 1:T.dim])+S.t,S.dim1,S.dim2);
	elseif isa(S,'smcirc')
	% Both T and S are general smcirc objects.
	% The result is a smcirc object.
		T.c = T.c + S.c;
		if smtconfig('crautoeig')
			T.ev = eig(T) + eig(S);
		else
			T.ev = [];
		end
	else
	% T is a smcirc object and S a full array.
	% The result is a full array.
		T = full(T) + S;
	end
else
% T is not smcirc, so S is.
	if msT == 1
	% T is a scalar and S is a smcirc object.
	% The result is a smcirc object.
		S.c = T + S.c;
		if smtconfig('crautoeig')
			ev = eig(S);
			ev(1) = S.dim*T + ev(1);
			S.ev = ev;
		else
			S.ev = [];
		end
		T = S;
	else
	% S is a smcirc object and T a full array.
	% The result is a full array.
		T = T + full(S);
	end
end

