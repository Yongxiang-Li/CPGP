function T = plus(T,S)
%+  Plus.
%
%   T + S adds matrices T and S. T and S must have the same
%   dimensions unless one is a scalar. A scalar can be added
%   to anything.
%
%   A = PLUS(T,S) is called for the syntax 'T + S' when T or S
%   is a smtoep object. The result is a smtoep matrix only when
%   one of the arguments is of class smtoep and the other is a
%   scalar or a smtoep matrix of dimension 1, or when both
%   arguments are smtoep matrices, otherwise it is a full array.
%
%   See also SMTOEP/MINUS.

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
% One of the operands is a smtoep empty object and the other is a
% scalar or empty matrix.
	T = smtoep;
	return
end

if (msT==1) && (msS==1)
% Both operands are scalar.
% The result is a smtoep object.
	T = smtoep(full(T)+full(S));
	return
end

if (msT == 1) && issmtoep(T)
% T is scalar.
% The result is of the same kind as S.
	T = full(T) + S;
	return
end

if isa(T,'smtoep')
% T is a smtoep object.
	if msS == 1
	% T is a smtoep object and S a scalar.
	% The result is a smtoep object.
		S = full(S);
		T.t = T.t + S;
		T.cev = [];
		if smtconfig('tpautoeig')
			T = toeprem(T);
		end
	elseif isa(S,'smcirc')
	% T is a smtoep object and S is a smcirc object.
	% The result is a smtoep object.
		T.t = T.t + S.c([2:S.dim 1:S.dim]);
		T.cev = [];
		if smtconfig('tpautoeig')
			T = toeprem(T);
		end
	elseif isa(S,'smtoep')
	% Both T and S are general smtoep objects.
	% The result is a smtoep object.
		T.t = T.t + S.t;
		if isempty(T.cev) || isempty(S.cev)
			T.cev = [];
			if smtconfig('tpautoeig')
				T = toeprem(T);
			end
		else
			T.cev = T.cev + S.cev;
		end
	else
	% T is a smtoep object and S a full array.
	% The result is a full array.
		T = full(T) + S;
	end
else
% T is not smtoep, so S is.
	if msT == 1
	% T is a scalar and S is a smtoep object.
	% The result is a smtoep object.
		S.t = T + S.t;
		S.cev = [];
		T = S;
		if smtconfig('tpautoeig')
			T = toeprem(T);
		end
	else
	% S is a smtoep object and T a full array.
	% The result is a full array.
		T = T + full(S);
	end
end

