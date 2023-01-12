function C = smcirc(col,ev,str)
%SMCIRC Circulant matrix class constructor.
%
%   C = SMCIRC creates a default empty object.
%
%   C = SMCIRC(col) creates a smcirc object from the vector col
%       containing the first column of a circulant matrix.
%
%   C = SMCIRC(col,ev,'eigenvalues') allows to pass also the
%       eigenvalues of the matrix.  This is useful, when they
%       are available from previous computations, since it saves
%       one fft.

%Input Parameters
%    col	the first column of the circulant matrix
%		(can be full or sparse)
%
%Description of the structure array (field names)
%    c		vector containing the first column of the 
%               circulant matrix
%    dim	dimension of the matrix
%    ev		eigenvalues of the circulant matrix
%
%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised August 10, 2011

if nargin < 3
	str = '';
end

if (nargin > 1) && ~strcmp(str,'eigenvalues')
	error ('Wrong input arguments.')
end
if (nargin == 0) || isempty(col)
	% If no input arguments, or empty vector, create a default object.
	C.c = [];
	C.dim = 0;
	C.ev = [];
	C = class(C,'smcirc');
elseif isa(col,'smcirc')
	% If argument col is of class smcirc, simply return it.
	C = col;
	% Compute eigenvalues.
	if isempty(C.ev) && smtconfig('crautoeig')
		C.ev = eig(C);
	end
elseif  ~isfloat(col)
	% If argument col is not a floating point array, then stop.
	error('The type of the argument is not correct.')
else
	% Check for the correct types of argument.
	if min(size(col)) == 1;
		col = col(:);
	else
		error('The argument is not a vector.')
	end
	% If the argument col is correct use this vector as
	% first column of a circulant matrix.
	C.c = col;
	C.dim = size(col,1);
	% Compute eigenvalues, unless they are supplied by the user.
	if nargin == 1
		C.ev = [];
		% To compute eigenvalues by the 'eig' smcirc method, we must
		% wait to declare C of class smcirc.
	else
		if min(size(ev)) == 1;
			ev = ev(:);
		else
			error('The second argument is not a vector.')
		end
		if length(ev) ~= C.dim
			error('The size of the arguments must be the same.')
		end
		C.ev = ev;
	end
	C = class(C,'smcirc');
	% Compute eigenvalues, finally.
	if isempty(C.ev) && smtconfig('crautoeig')
		C.ev = eig(C);
	end
end

