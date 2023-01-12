function [y,i] = max(T,S,d)
%MAX    Largest component.
%
%   MAX(T) is a row vector containing the maximum element from each column.
%
%   [Y,I] = MAX(T) returns the indices of the maximum values in vector I.
%   If the values along the first non-singleton dimension contain more
%   than one maximal element, the index of the first one is returned.
%
%   MAX(T,S) returns an array the same size as T and S with the
%   largest elements taken from T or S. Either one can be a scalar.
%
%   [Y,I] = MAX(T,[],DIM) operates along the dimension DIM. 
%
%   See also SMTOEP/MIN.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised April 14, 2009

if nargin == 2
	if nargout > 1
		error('MAX with two matrices to compare and two output arguments is not supported.')
	end
	if ~issmtoep(T)
		y = max(S,T);
		return
	elseif any(size(T)~=size(S)) && (max(size(T))~=1) && (max(size(S))~=1)
		error('Matrix dimensions must agree.')
	elseif isnumeric(S)
		if issparse(S)
			error('Cannot mix sparse and smcirc matrices.')
		end
		y = max(full(T),S);
	elseif issmcirc(S)
		y = max(T,smtoep(S));
	elseif issmtoep(S)
		y = smtoep(max(T.t,S.t),max([T.dim1,S.dim1]),max([T.dim2,S.dim2]));
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
		error('MAX with two matrices to compare and a working dimension is not supported.')
	end
	if (max(size(d)) ~= 1) || (d < 1)
		error('Dimension argument must be a positive integer scalar within indexing range.')
	end
	switch d
	   case 1
		y = zeros(1,T.dim2);
		i = zeros(1,T.dim2);
	   	[y(1) i(1)] = max(T.t(T.dim2:T.dim2+T.dim1-1));
		for j = 2:T.dim2
			[y(j) i(j)] = max(T.t(T.dim2-j+1:T.dim2+T.dim1-j));
		end
	   case 2
		y = zeros(T.dim1,1);
		i = zeros(T.dim1,1);
	   	[y(1) i(1)] = max(T.t(T.dim2:-1:1));
		for j = 2:T.dim1
			[y(j) i(j)] = max(T.t(T.dim2+j-1:-1:j));
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
