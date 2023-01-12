function S = sum(C,dim)
%SUM    Sum of elements.
%
%   S = SUM(C,dim) takes the sums along the dimension of C
%   specified by scalar dim.
%   For smcirc matrices, SUM(C) or SUM(C,1) is a row vector of  
%   column sums and SUM(C,2) is a column vector of row sums.
%
%   See also SMCIRC/PROD.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if nargin == 1 && isempty(C.c)
    % C is empty
    S = 0;
elseif nargin == 1 || dim == 1
    % If no dim parameter or dim equal to 1
    S = sum(C.c).*ones(1,C.dim);
elseif dim == 2
    % If dim equal to 2
    S = sum(C.c).*ones(C.dim,1);
elseif dim <= 0
    error('Dimension argument must be a positive integer scalar.')
else
    S = C;
end
