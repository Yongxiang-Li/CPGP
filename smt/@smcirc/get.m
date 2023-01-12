function output = get(C,fieldname)
%GET Get smcirc object fields.
%
%   GET(C) displays all field names and their current values
%   for smcirc object C.
%
%   V = GET(C) returns a structure, V, where each field name is
%   the name of a field of C and each field contains the value
%   of the corresponding field of C.
%
%   V = GET(C,'FieldName') returns the value, V, of the
%   specified field, FieldName, for smcirc object C.
%   If FieldName is a 1-by-N or N-by-1 cell array of strings
%   containing field names, GET returns a 1-by-N cell array
%   of values.
%
%   Example:
%       C = smcirc
%       get(C, {'ev','dim'})
%       out = get(C, 'c')
%       get(C)
%
%   See also SMCIRC.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 20, 2011

if (nargout == 0) && (nargin == 1)
% Case "get(C)"
	disp(' ');
	if issparse(C.c),  s = ' (sparse) ';  else  s = ' ';  end
	disp([inputname(1),' is a smcirc',s,'object with fields:'])
	disp(struct(C))
elseif (nargout == 1) && (nargin == 1)
% Case "V=get(C)"
	output = struct(C);
elseif (nargin == 2) && ~iscell(fieldname)
% Case "get(C,'PN')"
	switch fieldname
	case 'c'
		val = C.c;
	case 'dim'
		val = C.dim;
	case 'ev'
		val = C.ev;
	otherwise
		error(['There is no ''',fieldname, ...
			''' field for smcirc objects.'])
	end
	output = val;
else
% Case "get(C,{'PN',...})"
	% get field names
	len = length(fieldname);
	output = cell(1,len);
	for lcv=1:len
		field = char(fieldname(lcv));
		switch field
		case 'c'
			val = C.c;
		case 'dim'
			val = C.dim;
		case 'ev'
			val = C.ev;
		otherwise
			error(['There is no ''',field, ...
				''' field for smcirc objects.'])
		end
		output{1,lcv} = val;
	end
end

