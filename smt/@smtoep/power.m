function T = power(T,S)
%.^  Array power.
%
%   T.^S denotes element-by-element powers. T and S
%   must have the same dimensions unless one is a scalar.
%   A scalar can operate into anything.
%
%   A = POWER(T,S) is called for the syntax 'T .^ S' when T or
%   S is a smtoep object. The result is a smtoep matrix only
%   when one of the arguments is of class smtoep and the other
%   is a scalar or a smtoep matrix of dimension 1, or when both
%   arguments are smtoep matrices, otherwise it is a full array.
%
%   See also SMTOEP/MPOWER.

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
% One of the operands is a smtoep empty object and the other is a
% scalar or empty matrix.
	T = smtoep;
	return
end

if isa(T,'smtoep')	
% T is a smtoep object.
	if msS == 1
		S = full(S);
	elseif isa(S,'smcirc') && (msT~=1)
	% T is a smtoep object and S is a smcirc object.
	% The result must be a smtoep object.
		S = smtoep(S);
	end
	if isa(S,'smtoep')
	% Both T and S are general smtoep objects.
	% The result is a smtoep object.
		T.t = T.t .^ S.t;
		T.dim1 = max(T.dim1,S.dim1);
		T.dim2 = max(T.dim2,S.dim2);
		T.cev = [];
		if smtconfig('tpautoeig')
			T = toeprem(T);
		end
	elseif msS == 1
	% T is a smtoep object and S a scalar.
	% The result is a smtoep object.
		T.t = T.t .^ S;
		T.cev = [];
		if smtconfig('tpautoeig')
			T = toeprem(T);
		end
	else
	% T is a smtoep object and S a general float array.
	% The result is a full array.
		T = full(T) .^ S;
	end
else
% T is not smtoep, so S is.
	if msT == 1
	% T is a scalar and S is a smtoep object.
	% The result is a smtoep object.
		S.t = T .^ S.t;
		S.cev = [];
		T = S;
		if smtconfig('tpautoeig')
			T = toeprem(T);
		end
	else
	% S is a smtoep object and T a general float array.
	% The result is a full array.
		T = T .^ full(S);
	end
end


