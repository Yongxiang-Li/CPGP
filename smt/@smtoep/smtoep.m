function T = smtoep(varargin)
%SMTOEP Toeplitz matrix class constructor.
%
%   T = SMTOEP creates a default empty object.
%
%   T = SMTOEP(col) creates a smtoep object from the vector col
%       containing the first column of a square symmetric (or
%       Hermitian) Toeplitz matrix.
%
%   T = SMTOEP(col,row) creates a smtoep object from the vector
%       col containing the first column and the vector row
%       containing the first row of a Toeplitz matrix.
%
%   T = SMTOEP(t,m,n) creates a smtoep object from the vector t
%       of dimension (m+n-1) containing a (m-by-n) Toeplitz
%       matrix in TPS (Toeplitz Packed Storage or "gnomon") 
%       format.
%
%   T = SMTOEP(C) creates a smtoep object from the circulant
%       matrix contained in the smcirc object C.
%
%   See also SMTOEP/TOEPREM, SMCIRC/SMTOEP.

%Input Parameters
%    col	the first column of the Toeplitz matrix (full or sparse)
%    row  	the first row of the Toeplitz matrix (full or sparse)
%    t		Toeplitz matrix in TPS format (full or sparse)
%    m  	number of rows of the Toeplitz matrix
%    n  	number of columns of the Toeplitz matrix
%
%Description of the structure array (field names)
%    t          vector containing a Toeplitz matrix in TPS format
%    dim1       number of rows
%    dim2       number of columns
%    cev	eigenvalues of a related circulant matrix needed
%               for matrix-vector multiplication with the Toeplitz
%               matrix (this field is filled by the function TOEPREM)
%
%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 22, 2011

if nargin > 3
	error ('Too many input arguments.')
end
if (nargin == 0) || isempty(varargin{1})
	% If no input arguments, or empty vector, create a default object.
	T.t = [];
	T.dim1 = 0;
	T.dim2 = 0;
	T.cev = [];			
	T = class(T,'smtoep');
elseif isa(varargin{1},'smtoep')
	% If argument varargin{1} of class smtoep, simply return it.
	T = varargin{1};
elseif isa(varargin{1},'smcirc')
	% If argument varargin{1} of class smcirc, convert it to smtoep.
	T = varargin{1};
	T = smtoep([T.c(2:T.dim);T.c],T.dim,T.dim);
	return
elseif ~isfloat(varargin{1})
	% If argument varargin{1} is not a floating point array, then stop.
	error('The type of the first argument is not correct.')
else
	switch nargin
	case 1
	% Check for the correct types of arguments.
		if min(size(varargin{1})) ~= 1 
			error('The first argument is not a vector.')
		elseif ~isreal(varargin{1}(1)) && (max(size(varargin{1}))~=1)
			error('The first component of the vector is complex.')
		end
	% If single argument col, uses this vector as first column
	% of a Toeplitz matrix.
		varargin{1} = varargin{1}(:);
		dim1 = size(varargin{1},1);
		T.t = [conj(varargin{1}(dim1:-1:2));varargin{1}];
		T.dim1 = dim1;
		T.dim2 = dim1;
		T.cev = [];
	case 2
	% Check for the correct types of arguments.
		if (min(size(varargin{1})) ~= 1) || ...
		   (min(size(varargin{2})) ~= 1)
			error('The first or second argument is not a vector.')
		elseif ~isfloat(varargin{2})
		% If argument varargin{2} is not a floating point array, then
		% stop.
			error('The type of the second argument is not correct.')
		end
	% Create a smtoep object for a Toeplitz matrix having first column
	% varargin{1} and first row varargin{2}.
		varargin{1} = varargin{1}(:);
		varargin{2} = varargin{2}(:);
	% col and row must have the same first component.
		if varargin{1}(1) ~= varargin{2}(1)
			warning('SMT:smtoep:DiagonalConflict',['First ' ...
				'element of input column does not ' ...
				'match first element of input ' ...
				'\nrow. Column wins diagonal conflict.'])
		end
		dim1 = size(varargin{1},1);
		dim2 = size(varargin{2},1);
		T.t = [varargin{2}(dim2:-1:2);varargin{1}];
		T.dim1 = dim1;
		T.dim2 = dim2;
		T.cev = [];
	case 3
	% Check for the correct types of arguments.
		if min(size(varargin{1})) ~= 1
			error('The first argument is not a vector.')
		elseif ~isnumeric(varargin{2}) || ...
		   ~isnumeric(varargin{3}) || ...
		   (max(size(varargin{2})) ~= 1) || ...
		   (max(size(varargin{3})) ~= 1)
			error('The second or third argument is not a number.')
		end
	% Create a smtoep object for a (m-by-n) Toeplitz matrix stored
	% in TPS format.
		varargin{1} = varargin{1}(:);
		if (size(varargin{1},1) ~= (varargin{2}+varargin{3}-1)) || ...
		   any([varargin{2} varargin{3}]<=0)
			error('Dimensions do not agree.')
		end
		T.t = varargin{1};
		T.dim1 = varargin{2};
		T.dim2 = varargin{3};
		T.cev = [];
	end
	T = class(T,'smtoep');
end
if smtconfig('tpautoeig')
	T = toeprem(T);
end

