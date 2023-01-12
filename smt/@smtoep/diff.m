function T = diff(T,n,dim)
%DIFF Difference and approximate derivative.
%   DIFF(T), for a smtoep matrix T, is the matrix of row differences,
%      [T(2:n,:) - T(1:n-1,:)].
%   DIFF(T), for an N-D array T, is the difference along the first
%      non-singleton dimension of T.
%   DIFF(T,N) is the N-th order difference along the first non-singleton 
%      dimension (denote it by DIM). If N >= size(T,DIM), DIFF takes 
%      successive differences along the next non-singleton dimension.
%   DIFF(T,N,DIM) is the Nth difference function along dimension DIM. 
%      If N >= size(T,DIM), DIFF returns an empty array.
%
%   See also sum, smtoep/sum, smtoep/prod.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised April 18, 2009

if nargin < 3,  dim = 1;  end
if nargin < 2,  n = 1;  end

if ((nargin > 2) && (n >= size(T,dim)))
   	T = smtoep([]);
	return
end

T = diffrec(T,n,dim);



function T = diffrec(T,n,dim)

if (dim > ndims(T))
   	T = smtoep([]);
	return
end

if size(T,dim) == 1
	T = diffrec(T,n-size(T,dim)+1,dim+1);
	return
end

if dim <= 0
	error('Dimension argument must be a positive integer scalar within indexing range.')
end

if n <= 0
	error('Difference order N must be a positive integer scalar.')
end

switch dim
   case 1
	T = smtoep(diff(T.t),T.dim1-1,T.dim2);
   case 2
   	T.t = diff(T.t(end:-1:1));
	T = smtoep(T.t(end:-1:1),T.dim1,T.dim2-1);
   otherwise
   	T = smtoep([]);
end

if n > 1
	T = diffrec(T,n-1,dim);
end

