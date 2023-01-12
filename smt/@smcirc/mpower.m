function C = mpower(C,D)
%^  Matrix power.
%
%   A = C^d is the smcirc matrix C to the d power if d is
%   scalar and C is a smcirc matrix.  The result is a smcirc
%   matrix.
%
%   A = c^D is c to the D power if c is scalar and D is a
%   smcirc matrix.  The result is a smcirc matrix except when 
%   D is a smcirc scalar and c is not.
%
%   Both computations involve eigenvalues and eigenvectors.
%   A = C^D, where both C and D are matrices, is an error.
%
%   A = MPOWER(C,D) is called for the syntax 'C ^ D' when 
%   C or D is a smcirc matrix.
%
%   See also SMCIRC/POWER.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 22, 2011

if ~smtvalid(C) || ~smtvalid(D)
% Check if the operands are valid.
	if ~smtvalid(C)
		c=class(C);
		isspa = issparse(C);
	else
		c=class(D);
		isspa = issparse(D);
	end
	if isspa
		error('Function ''^'' is not defined for values of class ''sparse''.')
	else
		error('Function ''^'' is not defined for values of class ''%s''.', c)
	end
end

msC = max(size(C));
msD = max(size(D));

if (msC~=1) && (msD~=1)
% Check if at least one operand is scalar.
	error('At least one operand must be scalar.')
end

if (msC+msD > 2) && ((size(C,1)~=size(C,2)) || (size(D,1)~=size(D,2)))
% Check that the sizes are valid.
	error('Matrix must be square.')
end

if msC+msD < 2
% One of the operands is a smcirc empty object and the other is a
% scalar or empty matrix.
	if msD == 0
	% Weird, but consequent with standard Matlab behaviour.
		C = [];
	else
		C = smcirc;
	end
	return
end

if (msD==1) && ( (msC==1) || ~isobject(C) )
% The exponent is scalar and the base is scalar or full array.
	D = full(D);
	if ~isobject(C)
	% The exponent is a scalar smcirc object.
	% Inserted for compability with Matlab standard behaviour.
	% The result is a full array.
		C = C^D;
	else
	% The base is a scalar smcirc object.
	% The result is a smcirc object.
		C.c = C.c^D;
		if smtconfig('crautoeig')
			C.ev = C.c;
		else
			C.ev = [];
		end
	end
	return
end

if isa(C,'smcirc') && (msD==1)
% C is a smcirc object and D is scalar.
% The result is a smcirc object.
	D = full(D);
	% Check if matrix is real and exponent is integer.
	realflag = smtconfig('convreal') && isreal(C.c) && (D==fix(D));
	if D == 0
	% The exponent is zero scalar.
	% The result is a smcirc identity matrix.
		C = smcirc([1;zeros(C.dim-1,1)]);
	else
		% Check if base is integer and exponent is positive integer.
		intflag = smtconfig('convint') && ...
			all(C.c==fix(C.c)) && all(D==fix(D)) && (D>0);
		ev = eig(C).^D;
		C.c = ifft(ev);
		if smtconfig('crautoeig')
			C.ev = ev;
		else
			C.ev = [];
		end
		if intflag
		% If base is integer and exponent is positive integer, get only
		% the integer part of the result.
			C.c = round(C.c);
		end
	end
elseif ~isobject(D)
% C is a smcirc scalar and D is full array.
% Inserted for compability with Matlab standard behaviour.
% The result is a full array.
	C = full(C)^D;
else
% C is scalar and D is an object.
	C = full(C);
	if isa(D,'smtoep')
	% D is a smtoep object.
		C = C^D;
	elseif C == 0
	% The base is zero scalar.
		% This code is unnecessary in principle.  
		% It is inteded to avoid a bug in Matlab toeplitz
		% function (try toeplitz(NaN,NaN)).
		error('Use full(x)^full(y).')
	else
	% D is a smcirc object.
	% The result is a smcirc object.
		% Check if base is positive and matrix is real.
		realflag = smtconfig('convreal') && ...
			isreal(D.c) && isreal(C) && (C>0);
		ev = C.^eig(D);
		D.c = ifft(ev);
		if smtconfig('crautoeig')
			D.ev = ev;
		else
			D.ev = [];
		end
		C = D;
	end
end

if isa(C,'smcirc') && realflag
% Get only the real part of the result.
	C.c = real(C.c);
end

