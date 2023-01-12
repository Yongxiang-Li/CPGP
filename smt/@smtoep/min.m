function [y,i] = min(T,S,d)
%MIN   Smallest component.
%
%   MIN(T) is a row vector containing the smallest element from each column.
%
%   [Y,I] = MIN(T) returns the indices of the minimum values in vector I.
%   If the values along the first non-singleton dimension contain more
%   than one minimal element, the index of the first one is returned.
%
%   MIN(T,S) returns an array the same size as T and S with the
%   smallest elements taken from T or S. Either one can be a scalar.
%
%   [Y,I] = MIN(T,[],DIM) operates along the dimension DIM. 
%
%   See also SMTOEP/MAX.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised April 14, 2009

if nargin == 2
	if nargout > 1
		error('MIN with two matrices to compare and two output arguments is not supported.')
	end
	if ~issmtoep(T)
		y = min(S,T);
		return
	elseif any(size(T)~=size(S)) && (max(size(T))~=1) && (max(size(S))~=1)
		error('Matrix dimensions must agree.')
	elseif isnumeric(S)
		if issparse(S)
			error('Cannot mix sparse and smtoep matrices.')
		end
		y = min(full(T),S);
	elseif issmcirc(S)
		y = min(T,smtoep(S));
	elseif issmtoep(S)
		y = smtoep(min(T.t,S.t),max([T.dim1,S.dim1]),max([T.dim2,S.dim2]));
	end
elseif any(nargin == [1 3])
	if nargin == 1
		S = [];
		d = 1;
	end
	if ~issmtoep(T)
		error('One of the parameters is of the wrong type.')
	end
	if ~isempty(S)
		error('MIN with two matrices to compare and a working dimension is not supported.')
	end
	if (max(size(d)) ~= 1) || (d < 1)
		error('Dimension argument must be a positive integer scalar within indexing range.')
	end
	switch d
	   case 1
		y = zeros(1,T.dim2);
		i = zeros(1,T.dim2);
	   	[y(1) i(1)] = min(T.t(T.dim2:T.dim2+T.dim1-1));
		for j = 2:T.dim2
			[y(j) i(j)] = min(T.t(T.dim2-j+1:T.dim2+T.dim1-j));
		end
	   case 2
		y = zeros(T.dim1,1);
		i = zeros(T.dim1,1);
	   	[y(1) i(1)] = min(T.t(T.dim2:-1:1));
		for j = 2:T.dim1
			[y(j) i(j)] = min(T.t(T.dim2+j-1:-1:j));
		end
	   otherwise
	   	y = T;
		if nargout > 1
			i = ones(size(T));
		end
	end
else
	error('Too many input arguments.')
end
