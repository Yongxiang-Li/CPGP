function varargout = size(T,k)
%SIZE Size of a smtoep matrix.
%
%    D = SIZE(T), for M-by-N smtoep matrix T, returns the two-element
%    row vector D = [M,N] containing the number of rows and columns 
%    in the matrix.
%
%    [M,N] = SIZE(T) returns the number of rows and columns in separate
%    output variables.
%
%    M = SIZE(T,DIM) returns the length of the dimension specified by
%    the scalar DIM. For example, SIZE(T,1) returns the number of rows.
%
%    See also SMTOEP/LENGTH.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised April 18, 2009

% Determine the number of output arguments.
numOut = nargout;

if (numOut == 0)
% If zero output arguments, modify numOut to 1 so that the expression below
% evaluates without error.
	numOut = 1;
end

if nargin == 1
	if numOut == 1
		[varargout{1}] = [T.dim1 T.dim2];
	else
		[varargout{1}] = T.dim1;
		[varargout{2}] = T.dim2;
	end
else
	if ~isnumeric(k) ||  max(size(k)~=1)
		error('The second argument is not a number.')
	else
		switch k
		case 1
			varargout{1} = T.dim1;
		case 2
			varargout{1} = T.dim2;
		otherwise
			varargout{1} = 1;
		end
	end
end
