function is = isequal(varargin)
%ISEQUAL True if smcirc objects are numerically equal.
%
%   ISEQUAL(A,B) is 1 if both arguments are smcirc objects, are
%   the same size and contain the same values, and 0 otherwise.
%   The 'ev' field of the two objects is not checked.
%
%   ISEQUAL(A,B,C,...) is 1 if all the input arguments are
%   numerically equal.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

if nargin < 2
	error('Not enough input arguments.')
end

is = 1;
if isa(varargin{1},'smcirc')
	k = 1;
	while is && (k<nargin)
		k = k + 1;
		if ~(isa(varargin{k},'smcirc') && ...
		    isequal(varargin{1}.c,varargin{k}.c) && ...
		    isequal(varargin{1}.dim,varargin{k}.dim))
			is = 0;
		end
	end
else
	is = 0;
end

