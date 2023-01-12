function P = prod(C,dim)
%PROD   Product of elements.
%
%   P = prod(C,dim) takes the products along the dimension of C
%   specified by scalar dim.
%   For smcirc matrices, PROD(C) or PROD(C,1) is a row vector of  
%   column products and PROD(C,2) is a column vector of row products.
%
%   See also SMCIRC/SUM.
 
%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if nargin == 1 && isempty(C.c)
    % C is empty
    P = 1;
elseif nargin == 1 || dim == 1
    % If no dim parameter or dim equal to 1
    P = prod(C.c).*ones(1,C.dim);
elseif dim == 2
    % If dim equal to 2
    P = prod(C.c).*ones(C.dim,1);
elseif dim <= 0
    error('Dimension argument must be a positive integer scalar.')
else
    P = C;
end
