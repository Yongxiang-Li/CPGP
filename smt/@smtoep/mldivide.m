function S = mldivide(T,S)
%\  Backslash or left matrix divide.
%
%   T\S is the matrix division of T into S, which is roughly
%   the same as INV(T)*S. The result is a full array except 
%   when T is scalar and S is a smtoep matrix.
%
%   A = MLDIVIDE(T,S) is called for the syntax 'T \ S' when T
%   or S is an object.
%
%   See also SMTOEP/MRDIVIDE, SMTOEP/RDIVIDE, SMTOEP/LDIVIDE.

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
		error('Function ''\'' is not defined for values of class ''sparse''.')
	else
		error('Function ''\'' is not defined for values of class ''%s''.', c)
	end
end

msT = max(size(T));
msS = max(size(S));

if (size(T,1)~=size(S,1)) && (msT~=1)
% Check that the dimensions are valid.
	error('Matrix dimensions must agree.')
end

if msT+msS < 2
% One of the operands is a smtoep empty object and the other is a
% scalar or empty matrix.
	if (msT+msS==0) && (~isa(T,'smtoep') || ~isa(S,'smtoep'))
	% Weird, but consequent with standard Matlab behaviour.
		S = [];
	else
		S = smtoep;
	end
	return
end

if (msT == 1) && (msS == 1) && isobject(S)
% Both operands are scalar, ans S is an object.
% The result is a smtoep object.
	S = smtoep(full(T)\full(S));
 	return
end

if msT == 1
% The first argument is scalar.
	T = full(T);
	if isa(S,'smtoep')
		S.t = T \ S.t;
		if ~isempty(S.cev)
			S.cev = T \ S.cev;
		end
	else
		S = T \ S;
	end
else
% T is a smtoep object or a full array.  The result is a full array.
	if isa(T,'smtoep')
		col = T.t(T.dim2:T.dim1+T.dim2-1);
		row = T.t(T.dim2:-1:1);
		if T.dim1 == T.dim2
			tpsvfun = smtconfig('tpsolve');
			if isempty(tpsvfun)
				error('Toeplitz solver missing. See smtconfig.')
			else
				S = tpsvfun(col,row,full(S));
			end
		else
			tplsfun = smtconfig('tpsolvels');
			if isempty(tplsfun)
				error('Toeplitz solver missing. See smtconfig.')
			else
				S = tplsfun(col,row,full(S));
			end
		end
	else
		S = T \ full(S);
	end
end

