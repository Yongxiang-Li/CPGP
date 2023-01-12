function C = diff(C,n,dim)
%DIFF Difference and approximate derivative.
%   DIFF(C), for a smcirc matrix C, is the matrix of row differences,
%      [C(2:n,:) - C(1:n-1,:)].
%   DIFF(C), for an N-D array C, is the difference along the first
%      non-singleton dimension of C.
%   DIFF(C,N) is the N-th order difference along the first non-singleton 
%      dimension (denote it by DIM). If N >= size(C,DIM), DIFF takes 
%      successive differences along the next non-singleton dimension.
%   DIFF(C,N,DIM) is the Nth difference function along dimension DIM. 
%      If N >= size(C,DIM), DIFF returns an empty array.
%
%   See also sum, smcirc/sum, smcirc/prod.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised April 17, 2009

if nargin < 2,  n = 1;  end

if nargin < 3,
	C = diff(smtoep(C),n);
	return
end

C = diff(smtoep(C),n,dim);

