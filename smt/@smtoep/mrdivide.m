function T = mrdivide(T,S)
%/  Slash or right matrix divide.
%
%   T/S is the matrix division of S into T, which is roughly
%   the same as T*INV(S).The result is a full array except
%   when S is scalar and T is a smtoep matrix.
%
%   A = MRDIVIDE(T,S) is called for the syntax 'T / S' when T
%   or S is an object.
%
%   See also SMTOEP/MLDIVIDE, SMTOEP/RDIVIDE, SMTOEP/LDIVIDE.

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
		error('Function ''/'' is not defined for values of class ''sparse''.')
	else
		error('Function ''/'' is not defined for values of class ''%s''.', c)
	end
end

msT = max(size(T));
msS = max(size(S));

if (size(T,2)~=size(S,2)) && (msS~=1)
% Check that the dimensions are valid.
	error('Matrix dimensions must agree.')
end

if msT+msS < 2
% One of the operands is a smtoep empty object and the other is a
% scalar or empty matrix.
	if (msT+msS==0) && (~isa(T,'smtoep') || ~isa(S,'smtoep'))
	% Weird, but consequent with standard Matlab behaviour.
		T = [];
	else
		T = smtoep;
	end
	return
end

if msS == 1
% The second argument is scalar.
	S = full(S);
	if isa(T,'smtoep')
		T.t = T.t / S;
		if ~isempty(T.cev)
			T.cev = T.cev / S;
		end
	else
		T = T / S;
	end
else
% T and S can be both objects or one is an object and the other is a full array.
% The algorithm may be slow and the result is a full array.
	%if ~isobject(S) || isa(S,'smtoep')
	%	warning('SMT:mrdivide:SlowComputation',['Slow computation: ' ...
	%		'using full right matrix division.'])
	%end
	if isa(S,'smtoep')
		col = S.t(S.dim2:S.dim1+S.dim2-1);
		row = S.t(S.dim2:-1:1);
		if S.dim1 == S.dim2
			tpsvfun = smtconfig('tpsolve');
			if isempty(tpsvfun)
				error('Toeplitz solver missing. See smtconfig.')
			else
				T = tpsvfun(conj(row),conj(col),full(T'))';
			end
		else
			tplsfun = smtconfig('tpsolvels');
			if isempty(tplsfun)
				error('Toeplitz solver missing. See smtconfig.')
			else
				T = tplsfun(conj(row),conj(col),full(T'))';
			end
		end
	else
		T = full(T) / S;
	end
end

