function C = subsasgn(C,s,val)
%SUBSASGN Subscripted assignment for a smcirc object.
%
%   The only subscripted assignemnts allowed for a smcirc object
%   are those regarding the .c field.  Examples:
%      C.c = rand(C.dim,1)
%      C.c(2:5) = ones(4,1)
%
%   See also SUBSASGN, SMCIRC/SUBSREF, SMCIRC/SUBSINDEX.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised August 11, 2011

if isempty(s) && strcmp(class(val),'smcirc')
	C = smcirc(C);
end

switch s(1).type

case '.'
	if s(1).subs == 'c'
		% Use the built-in subsasagn for dot notation
		C = builtin('subsasgn',C,s,val);
		C.ev = [];
		if any(size(C.c) ~= [C.dim 1])
			error('Subscripted assignment dimension mismatch.')
		elseif smtconfig('crautoeig')
			C.ev = eig(C);
		end
	else
		error('Not a supported subscripted assignment.')
	end

otherwise
	error('Not a supported subscripted assignment.')

end

