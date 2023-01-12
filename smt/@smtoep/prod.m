function P = prod(T,dim)
%PROD   Product of the elements.
%
%   P = prod(T,dim) takes the products along the dimension of T
%   specified by scalar dim.
%   For smtoep row or column vectors, PROD(T) is the product of 
%   the elements of T.
%   For matrices, PROD(T) or PROD(T,1) is a row vector of column 
%   products and PROD(T,2) is a column vector of row products.
%
%   See also SMTOEP/SUM.
 
%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if (nargin == 1) && any(size(T) == 1)
    % If one of the dimensions of T is 1
    P = prod(T.t);
elseif (nargin == 1) || (dim == 1)
    % If no dim parameter or dim equal to 1
    P=zeros(1,T.dim2);
    for j = 1:T.dim2
        P(j) = prod(T.t(T.dim2-j+1:T.dim2-j+T.dim1));
    end
elseif dim == 2
    % If dim equal to 2
    P=zeros(T.dim1,1);
    for i = 1:T.dim1
        P(i) = prod(T.t(i:i+T.dim2-1));
    end
elseif dim <= 0
    error('Dimension argument must be a positive integer scalar.')
else
    P = T;
end
