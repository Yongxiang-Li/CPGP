function S = mtimes(T,S)
%*  Matrix multiply.
%
%   C*D is the matrix product of C and D. Any scalar (a 1-by-1
%   matrix) may multiply anything. Otherwise, the number of
%   columns of C must equal the number of rows of D.
%
%   A = MTIMES(C,D) is called for the syntax 'C * D' when C or
%   D is an smcirc matrix. The result is a smcirc matrix only
%   when one of the argument is of class smcirc and the other
%   is a scalar or a smcirc matrix, otherwise it is a full array.
%
%   See also SMCIRC/TIMES.

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
		error('Function ''*'' is not defined for values of class ''sparse''.')
	else
		error('Function ''*'' is not defined for values of class ''%s''.', c)
	end
end

msT = max(size(T));
msS = max(size(S));

if (size(T,2)~=size(S,1)) && (msT~=1) && (msS~=1)
% Check that the dimensions are valid.
	error('Inner matrix dimensions must agree.')
end

if msT+msS < 2
% One of the operands is a smcirc empty object and the other is a
% scalar or empty matrix.
	if (msT+msS==0) && (~isa(T,'smcirc') || ~isa(S,'smcirc'))
	% weird, but consequent with standard Matlab behaviour.
		S = [];
	else
		S = smcirc;
	end
	return
end

% Check if both matrices are real.
realflag = smtconfig('convreal') && isreal(T) && isreal(S);

if msT == 1
% If T is scalar, make it a smcirc object.
	T = smcirc(full(T));
end

if isa(T,'smcirc')	
% T is a smcirc object.
	if msS == 1
	% If S is scalar turn it into a smcirc object.
		S = smcirc(full(S));
	end
	if isa(S,'smcirc')
	% Both T and S are general smcirc objects.
	% The result is a smcirc object.
		ev = eig(T) .* eig(S);
		if smtconfig('crautoeig')
			S.ev = ev;
		else
			S.ev = [];
		end
		if (msT==1) || (msS==1)
		% T or S is scalar 
			S.dim = max(T.dim,S.dim);
			S.c = T.c * S.c;
		else
		% Both T and S are general smcirc objects.
			% Check if both matrices are integer.
			intflag = smtconfig('convint') && ...
				all(T.c==fix(T.c)) && all(S.c==fix(S.c));
			S.c = ifft(ev);
			if realflag
			% If both matrices are real, get only the
			% real part of the result.
				S.c = real(S.c);
			end
			if intflag
			% if both matrices are integer, get only the 
			% integer part of the result.
				S.c = round(S.c);
			end
		end
	else
	% T is a smcirc object and S a general array.
	% The result is a full array.
		if msT == 1
			S = full(T) * S;
		else
			% Check if both matrices are integer.
			intflag = smtconfig('convint') && ...
				all(T.c==fix(T.c)) && all(S(:)==fix(S(:)));
			S = full(S);
			% Apply the circulant matrix-vector product via FFT.
			S = ifft(spdiags(eig(T),0,T.dim,T.dim) * fft(S));
			if realflag
			% If both matrices are real, get only the 
			% real part of the result.
				S = real(S);
			end
			if intflag
			% if both matrices are integer, get only the 
			% integer part of the result.
				S = round(S);
			end
		end
	end
else
% T is a full array, and S is a smcirc object.
% The result is a full array.
	if msS == 1
	% S is scalar.
		S = T * full(S);
	else
		% Check if both matrices are integer.
		intflag = smtconfig('convint') && ...
			all(T(:)==fix(T(:))) && all(S.c==fix(S.c));
		T = full(T);
		% Apply the circulant matrix-vector product via FFT.
		S = ifft(spdiags(conj(eig(S)),0,S.dim,S.dim) * fft(T'));
		S = S';
		if realflag
		% If both matrices are real, get only the real part
		% of the result.
			S = real(S);
		end
		if intflag
		% if both matrices are integer, get only the 
		% integer part of the result.
			S = round(S);
		end
	end
end

