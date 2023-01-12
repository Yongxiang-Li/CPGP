function S = mldivide(T,S)
%\  Backslash or left matrix divide.
%
%   C\D is the matrix division of C into D, which is roughly
%   the same as INV(C)*D.
%
%   A = MLDIVIDE(C,D) is called for the syntax 'C \ D' when C
%   or D is a smcirc matrix. The result is a smcirc matrix only
%   when the second argument is of class smcirc and the first is
%   either a scalar or a smcirc matrix, otherwise it is a full array.
%
%   See also SMCIRC/MRDIVIDE, SMCIRC/LDIVIDE, SMCIRC/RDIVIDE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 22, 2011

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
% One of the operands is a smcirc empty object and the other is a
% scalar or empty matrix.
	if (msT+msS==0) && (~isa(T,'smcirc') || ~isa(S,'smcirc'))
	% Weird, but consequent with standard Matlab behaviour.
		S = [];
	else
		S = smcirc;
	end
	return
end

if (msT == 1) && (msS == 1) && isobject(S)
% Both operands are scalar, ans S is an object.
% The result is a smcirc object.
	S = smcirc(full(T)\full(S));
 	return
end

if msT == 1
% T is scalar.
	S = full(T) .\ S;
	return
end

if isa(T,'smcirc')
% T is a smcirc object.
	% Check if both arrays are real.
	realflag = smtconfig('convreal') && isreal(T) && isreal(S);
	if isa(S,'smcirc')
	% Both T and S are general smcirc objects.
	% The result is a smcirc object.
		ev = eig(T) .\ eig(S);
		S.dim = T.dim;
		S.c = ifft(ev);
		if smtconfig('crautoeig')
			S.ev = ev;
		else
			S.ev = [];
		end
		if realflag
		% If both matrices are real, get only the real part
		% of the result.
			S.c = real(S.c);
		end
	else
	% T is a smcirc object and S a general array.
	% The result is a full array.
		S = full(S);
		% Apply the circulant matrix-vector multiplication via FFT.
		S = ifft(spdiags(1./eig(T),0,T.dim,T.dim) * fft(S));
		if realflag
		% If both matrices are real, get only the real part
		% of the result.
			S = real(S);
		end
	end
else
% T is not smcirc, so S is.
% The algorithm is slow and the result is a full array.
	warning('SMT:mldivide:SlowComputation',['Slow computation: ' ...
		'using full left matrix division.'])
	S = T \ full(S);
end

