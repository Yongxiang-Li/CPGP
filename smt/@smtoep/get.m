function output = get(T,fieldname)
%GET Get smtoep object fields.
%
%   GET(T) displays all field names and their current values
%   for smtoep object T.
%
%   V = GET(T) returns a structure, V, where each field name is
%   the name of a field of T and each field contains the value
%   of the corresponding field of T.
%
%   V = GET(T,'FieldName') returns the value, V, of the
%   specified field, FieldName, for smtoep object T.
%   If FieldName is a 1-by-N or N-by-1 cell array of strings
%   containing field names, GET returns a 1-by-N cell array
%   of values.
%
%   Example:
%       T = smtoep
%       get(T, {'dim1','dim2'})
%       out = get(T, 't')
%       get(T)
%
%   See also SMTOEP.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 20, 2011

if (nargout == 0) && (nargin == 1)
% Case "get(T)"
	disp(' ');
	if issparse(T.t),  s = ' (sparse) ';  else  s = ' ';  end
	disp([inputname(1),' is a smtoep',s,'object with fields:'])
	disp(struct(T))
elseif (nargout == 1) && (nargin == 1)
% Case "V=get(T)"
	output = struct(T);
elseif (nargin == 2) && ~iscell(fieldname)
% Case "get(T,'PN')"
	switch fieldname
	case 't'
		val = T.t;
	case 'dim1'
		val = T.dim1;
	case 'dim2'
		val = T.dim2;
	case 'cev'
		val = T.cev;
	otherwise
		error(['There is no ''',fieldname, ...
			''' field for smtoep objects.'])
	end
	output = val;
else
% Case "get(T,{'PN',...})"
	% get field names
	len = length(fieldname);
	output = cell(1,len);
	for lcv=1:len
		field = char(fieldname(lcv));
		switch field
		case 't'
			val = T.t;
		case 'dim1'
			val = T.dim1;
		case 'dim2'
			val = T.dim2;
		case 'cev'
			val = T.cev;
		otherwise
			error(['There is no ''',field, ...
				''' field for smtoep objects.'])
		end
		output{1,lcv} = val;
	end
end

