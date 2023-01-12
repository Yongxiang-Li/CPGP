function C = smtcprec( prectype, A, options)
%SMTCPREC Construction of circulant preconditioners.
%
%   C = SMTCPREC(precname,A,options) returns a smcirc matrix 
%   containing the circulant preconditioner of matrix A, where 
%   precname is a string containing the preconditioner type:
%      strang    Strang preconditioner (only for smtoep matrices)
%      optimal   optimal preconditioner
%      superopt  superoptimal preconditioner
%   The third parameter, if present, is passed to the function 
%   which performs the computation.
%
%   For additional information, type "help private/precname".

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised February 5, 2009

if nargin < 3
	options = [];
end

if nargin < 2
	error('Too few argument.')
end

if ~isa(prectype,'char') || (length(prectype)<3)
	error('First argument must be a valid preconditioner name.')
end

if ~isfloat(A)
	error('Second argument must be a float matrix.')
end

switch lower(prectype(1:3))
case 'str'
	C = strang(A);
case 'opt'
	C = optimal(A);
case 'sup'
	C = superopt(A,options);
otherwise
	error('First argument must be a valid preconditioner name.')
end

