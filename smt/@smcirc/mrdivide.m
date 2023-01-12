function T = mrdivide(T,S)
%/  Slash or right matrix divide.
%
%   C/D is the matrix division of D into C, which is roughly
%   the same as C*INV(D).
%
%   A = MRDIVIDE(C,D) is called for the syntax 'C / D' when C
%   or D is a smcirc matrix. The result is a smcirc matrix only
%   when the first argument is of class smcirc and the second is
%   either a scalar or a smcirc matrix, otherwise it is a full array.
%
%   See also SMCIRC/MLDIVIDE, SMCIRC/RDIVIDE, SMCIRC/LDIVIDE.

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
% One of the operands is a smcirc empty object and the other is a
% scalar or empty matrix.
	if (msT+msS==0) && (~isa(T,'smcirc') || ~isa(S,'smcirc'))
	% Weird, but consequent with standard Matlab behaviour.
		T = [];
	else
		T = smcirc;
	end
	return
end

if msS == 1
% S is scalar.
	T = T ./ full(S);
	return
end

if isa(S,'smcirc')
% S is a smcirc object.
	% Check if both arrays are real.
	realflag = smtconfig('convreal') && isreal(T) && isreal(S);
	if isa(T,'smcirc')
	% Both T and S are general smcirc objects.
	% The result is a smcirc object.
		ev = eig(T) ./ eig(S);
		T.dim = S.dim;
		T.c = ifft(ev);
		if smtconfig('crautoeig')
			T.ev = ev;
		else
			T.ev = [];
		end
		if realflag
		% If both matrices are real, get only the real part
		% of the result.
			T.c = real(T.c);
		end
	else
	% S is a smcirc object and T a general array.
	% The result is a full array.
		T = full(T);
		% Apply the circulant matrix-vector multiplication via FFT.
		T = ifft(spdiags(1./conj(eig(S)),0,S.dim,S.dim) * fft(T'));
		T = T';
		if realflag
		% If both matrices are real, get only the real part
		% of the result.
			T = real(T);
		end
	end
else
% T is a smcirc object and S is not.
% The algorithm may be slow and the result is a full array.
	if ~isobject(S)
		warning('SMT:mrdivide:SlowComputation',['Slow computation: ' ...
			'using full right matrix division.'])
	end
	T = full(T) / S;
end

