function is = isa(T,str)
%ISA True if object is a given class.
%
%   ISA(OBJ,'class_name') returns 1 if OBJ is of the class 
%   'class_name' and 0 otherwise.
%
%   Example:
%      T = smtoep;
%      isa(T,'smtoep') 		returns 1
%      isa(T,'float')		returns 1
%      isa(T,'double')		returns 1 if T.t is 'double'
%      isa(T,'single')		returns 1 if T.t is 'single'
%      isa(T,'other_class')	returns 0
%
%   See also SMTVALID, SMTOEP/SMTVALID.

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

if strcmp(str,'smtoep')
	is = 1;
elseif strcmp(str,'double') && isa(T.t,'double')
% weird, but necessary for running pcg correctly.
	is = 1;
elseif strcmp(str,'single') && isa(T.t,'single')
% weird, but necessary for running pcg correctly.
	is = 1;
elseif strcmp(str,'float')
% added for compatibility between Matlab 6.x and 7.x.
	is = 1;
else
	is = 0;
end

