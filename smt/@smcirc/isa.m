function is = isa(C,str)
%ISA True if object is a given class.
%
%   ISA(OBJ,'class_name') returns 1 if OBJ is of the class
%   'class_name' and 0 otherwise.
%
%   Example:
%      C = smcirc;
%      isa(C,'smcirc') 		returns 1
%      isa(C,'float')		returns 1
%      isa(C,'double')		returns 1 if C.c is 'double'
%      isa(C,'single')		returns 1 if C.c is 'single'
%      isa(C,'other_class')	returns 0
%
%   See also SMTVALID, SMCIRC/SMTVALID.

%
%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 22, 2011

if nargin<2
	error('Not enough input arguments.')
end

if strcmp(str,'smcirc')
	is = 1;
elseif strcmp(str,'double') && isa(C.c,'double')
% weird, but necessary for running pcg correctly.
	is = 1;
elseif strcmp(str,'single') && isa(C.c,'single')
% weird, but necessary for running pcg correctly.
	is = 1;
elseif strcmp(str,'float')
% added for compatibility between Matlab 6.x and 7.x.
	is = 1;
else
	is = 0;
end

