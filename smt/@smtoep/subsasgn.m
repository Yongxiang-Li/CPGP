function T = subsasgn(T,s,val)
%SUBSASGN Subscripted assignment for a smtoep object.
%
%   The only subscripted assignemnts allowed for a smtoep object
%   are those regarding the .t field.  Examples:
%      T.t = rand(T.dim1+T.dim2-1,1)
%      T.t(2:5) = ones(4,1)
%
%   See also SUBSASGN, SMTOEP/SUBSREF, SMTOEP/SUBSINDEX.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised August 11, 2011

if isempty(s) && strcmp(class(val),'smtoep')
	T = smtoep(T);
end

switch s(1).type

case '.'
	if s(1).subs == 't'
		% Use the built-in subsasagn for dot notation
		T = builtin('subsasgn',T,s,val);
		T.cev = [];
		if any(size(T.t) ~= [T.dim1+T.dim2-1 1])
			error('Subscripted assignment dimension mismatch.')
		elseif smtconfig('tpautoeig')
			T = toeprem(T);
		end
	else
		error('Not a supported subscripted assignment.')
	end

otherwise
	error('Not a supported subscripted assignment.')

end

