function S = mtimes(T,S)
%*  Matrix multiply.
%
%   T*S is the matrix product of T and S. Any scalar (a 1-by-1
%   matrix) may multiply anything. Otherwise, the number of
%   columns of T must equal the number of rows of S.
%
%   A = MTIMES(T,S) is called for the syntax 'T * S' when T or
%   S is an smtoep matrix. The result is a smtoep matrix only
%   when one of the argument is of class smtoep and the other
%   is a scalar or a smtoep matrix of dimension 1, otherwise 
%   it is a full array.
%
%   When the same matrix T must be successively multiplied by
%   many different arrays, the execution time can be reduced
%   by 1/3 by calling T = TOEPREM(T), which precomputes the
%   eigenvalues of the circulant matrix in which T is embedded.
%
%   See also SMTOEP/TIMES, TOEPREM.

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
% One of the operands is a smtoep empty object and the other is a
% scalar or empty matrix.
	if (msT+msS==0) && (~isa(T,'smtoep') || ~isa(S,'smtoep'))
	% weird, but consequent with standard Matlab behaviour.
		S = [];
	else
		S = smtoep;
	end
	return
end

if isa(T,'smtoep') && isa(S,'smtoep')
% Both T and S are smtoep objects.
	if size(T,1) < size(S,2)
	% For optimizing the computation choose the adequate order.
		S = (S'*T')';	
		return
	else
		S = full(S);
	end
end

% Check if both matrices are real.
realflag = smtconfig('convreal') && isreal(T) && isreal(S);

if isa(T,'smtoep')	
% T is a smtoep object.
	if msS == 1
	% T is a smtoep object and S is scalar.
	% The result is a smtoep object.
		S = full(S);
		T.t = T.t * S;
		if ~isempty(T.cev)
			T.cev = T.cev * S;
		end
		S = T;
	elseif isa(S,'smcirc') 
	% T is a smtoep object and S is a smcirc object.
	% For computational reasons we call the smcirc multiply.
	% The result is a full array.
		S = full(T) * S;
	else
	% T is a smtoep object and S a general float array.
	% The result is a full array.
		if msT == 1
			S = full(T) * S;
		else
			% Check if both matrices are integer.
			intflag = smtconfig('convint') && ...
				all(T.t==fix(T.t)) && all(S(:)==fix(S(:)));
			% Apply the Toeplitz matrix-vector product via FFT.
			if isempty(T.cev)
			% The following inline code is faster than calling
			% 	T = toeprem(T);
				immfun = smtconfig('tpemb');
				N = immfun(T.dim1,T.dim2);
				T.cev = fft([...
					full(T.t(T.dim2:T.dim1+T.dim2-1));...
					zeros(N-T.dim1-T.dim2+1,1); ...
					full(T.t(1:T.dim2-1))]);
			end
			n = size(T.cev,1);
			% Apply the circulant matrix-vector product via FFT.
			S = ifft(spdiags(T.cev,0,n,n) * ...
				fft([S;zeros(n-size(S,1),size(S,2))]));
			S = S(1:T.dim1,:);
			if realflag
			% If both matrices are real, get only the 
			% real part of the result.
				S = real(S);
			end
			if intflag
			% If both matrices are integer, get only the 
			% integer part of the result.
				S = round(S);
			end
		end
	end
else
% T is not smtoep, so S is.
	if msT == 1
	% T is a scalar and S is a smtoep object.
	% The result is a smtoep object.
		S.t = T * S.t;
		if ~isempty(S.cev)
			S.cev = T * S.cev;
		end
	else
	% T is a full array, and S is a smtoep object.
	% The result is a full array.
		if msS == 1
		% S is scalar.
			S = T * full(S);
		else
			% Check if both matrices are integer.
			intflag = smtconfig('convint') && ...
				all(T(:)==fix(T(:))) && all(S.t==fix(S.t));
			% Apply the Toeplitz matrix-vector product via FFT.
			if isempty(S.cev)
			% The following inline code is faster than calling
			% 	S = toeprem(S);
				immfun = smtconfig('tpemb');
				N = immfun(S.dim1,S.dim2);
				S.cev = fft([...
					full(S.t(S.dim2:S.dim1+S.dim2-1));...
					zeros(N-S.dim1-S.dim2+1,1); ...
					full(S.t(1:S.dim2-1))]);
			end
			n = size(S.cev,1);
			% Apply the circulant matrix-vector product via FFT.
			T = ifft(spdiags(conj(S.cev),0,n,n) * ...
				fft([T';zeros(n-size(T,2),size(T,1))]));
			S = T(1:S.dim2,:)';
			if realflag
			% If both matrices are real, get only the 
			% real part of the result.
				S = real(S);
			end
			if intflag
			% If both matrices are integer, get only the 
			% integer part of the result.
				S = round(S);
			end
		end
	end
end
