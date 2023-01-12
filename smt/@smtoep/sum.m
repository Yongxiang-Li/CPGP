function S = sum(T,dim)
%SUM    Sum of elements.
%
%   S = SUM(T,dim) takes the sums along the dimension of T
%   specified by scalar dim.
%   For smtoep row or column vectors, SUM(T) is the sum of 
%   the elements of T.
%   For matrices, SUM(T) or SUM(T,1) is a row vector of column 
%   sums and SUM(T,2) is a column vector of row sums.
%
%   See also SMTOEP/PROD.
 
%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if nargin == 1 && isempty(T.t)
    % T is empty
    S = 0;
elseif nargin == 1 && any(size(T) == 1)
    % If one of the dimensions of T is 1
    S = sum(T.t);
elseif nargin == 1 || dim == 1
    % If no dim parameter or dim equal to 1
    S = ones(1,T.dim1)*T;
elseif dim == 2
    % If dim equal to 2
    S = T*ones(T.dim2,1);
elseif dim <= 0
    error('Dimension argument must be a positive integer scalar.')
else
    S = T;
end
