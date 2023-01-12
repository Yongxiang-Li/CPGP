function [y,i] = min(C,D,d)
%MIN   Smallest component.
%
%   MIN(C) is a row vector containing the smallest element from each column.
%
%   [Y,I] = MIN(C) returns the indices of the minimum values in vector I.
%   If the values along the first non-singleton dimension contain more
%   than one minimal element, the index of the first one is returned.
%
%   MIN(C,D) returns an array the same size as C and D with the
%   smallest elements taken from C or D. Either one can be a scalar.
%
%   [Y,I] = MIN(C,[],DIM) operates along the dimension DIM. 
%
%   See also SMCIRC/MAX.

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
	if ~issmcirc(C)
		y = min(D,C);
		return
	elseif any(size(C)~=size(D)) && (max(size(C))~=1) && (max(size(D))~=1)
		error('Matrix dimensions must agree.')
	elseif isnumeric(D)
		if issparse(D)
			error('Cannot mix sparse and smcirc matrices.')
		end
		y = min(full(C),D);
	elseif issmtoep(D)
		y = min(smtoep(C),D);
	elseif issmcirc(D)
		y = smcirc(min(C.c,D.c));
	end
elseif any(nargin == [1 3])
	if nargin == 1
		D = [];
		d = 1;
	end
	if ~issmcirc(C)
		error('One of the parameters is of the wrong type.')
	end
	if ~isempty(D)
		error('MIN with two matrices to compare and a working dimension is not supported.')
	end
	if (max(size(d)) ~= 1) || (d < 1)
		error('Dimension argument must be a positive integer scalar within indexing range.')
	end
	switch d
	   case 1
	   	[y k] = min(C.c);
		y = y * ones(1,C.dim);
		if nargout > 1
			vi = 1:C.dim;
			i = vi([k:end 1:k-1]);
			v = find(C.c == y(1));
			for j = 2:size(v,1)
				i = min(i,vi([v(j):end 1:v(j)-1]));
			end
		end
	   case 2
	   	[y k] = min(C.c([1 end:-1:1]));
		y = y * ones(C.dim,1);
		if nargout > 1
			vi = (1:C.dim)';
			i = vi([k:end 1:k-1]);
			v = find(C.c([1 end:-1:1]) == y(1));
			for j = 2:size(v,1)
				i = min(i,vi([v(j):end 1:v(j)-1]));
			end
		end
	   otherwise
	   	y = C;
		if nargout > 1
			i = ones(size(C));
		end
	end
else
	error('Too many input arguments.')
end
