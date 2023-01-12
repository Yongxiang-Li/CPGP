function A = mpower(T,S)
%^  Matrix power.
%
%   A = T^k is the smtoep matrix T to the k power when k is a
%   scalar and T is square. k must be a nonnegative integer,
%   and the power is computed by repeated matrix multiplications.
%   The result is a full array except when k is zero or T is a
%   scalar smtoep matrix.
%
%   A = MPOWER(T,k) is called for the syntax 'T ^ k' when T is
%   a smtoep square matrix and k a nonnegative integer.
%
%   See also SMTOEP/POWER.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

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
		error('Function ''^'' is not defined for values of class ''sparse''.')
	else
		error('Function ''^'' is not defined for values of class ''%s''.', c)
	end
end

msT = max(size(T));
msS = max(size(S));

if (msT~=1) && (msS~=1)
% Check if at least one operand is scalar.
	error('At least one operand must be scalar.')
end

if (msT+msS > 2) && ((size(T,1)~=size(T,2)) || (size(S,1)~=size(S,2)))
% Check that the sizes are valid.
	error('Matrix must be square.')
end

if msT+msS < 2
% One of the operands is a smtoep empty object and the other is a
% scalar or empty matrix.
	if msS == 0
	% Weird, but consequent with standard Matlab behaviour.
		A = [];
	else
		A = smtoep;
	end
	return
end

if (msS==1) && ( (msT==1) || ~isobject(T) )
% The exponent is scalar and the base is scalar or full array.
	S = full(S);
	if ~isobject(T)
	% The exponent is a scalar smtoep object.
	% Inserted for compability with Matlab standard behaviour.
	% The result is a full array.
		A = T^S;
	else
	% The base is a scalar smtoep object.
	% The result is a smtoep object.
		T.t = T.t^S;
		if ~isempty(T.cev)
			T.cev = T.t;
		else
			T.cev = [];
			if smtconfig('tpautoeig')
				T = toeprem(T);
			end
		end
		A = T;
	end
	return
end

if isa(T,'smtoep') && (msS==1)
% T is a smtoep object and S is scalar.
	S = full(S);
	if S == 0
	% The exponent is zero scalar.
	% The result is a smtoep identity matrix.
		A = smtoep([1;zeros(T.dim1-1,1)],[1;zeros(T.dim2-1,1)]);
	elseif S < 0
	% Check the exponent.
		error('The exponent must be a non negative integer.')
	elseif S ~= fix(S)
	% Check if the exponent is integer.
		error('The exponent must be an integer.')
	else
	% Compute the power by repeated matrix multiplications.
	% The result is a full array.
		A = T;
		for i=1:S-1
			A = T*A;
		end
	end
elseif ~isobject(S)
% T is a smtoep scalar and S is full array.
% Inserted for compability with Matlab standard behaviour.
% The result is a full array.
	A = full(T)^S;
else
% T is scalar and S is an object.
	if isa(S,'smcirc')
	% S is a smcirc object, the result is a smcirc object.
		A = full(T)^S;
	else
	% S is a smtoep object.
	% Not yet implemented.
		error('Use full(x)^full(y).')
	end
end

