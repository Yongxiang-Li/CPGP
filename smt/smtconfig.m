function out = smtconfig(property,value)
%SMTCONFIG SMToolbox configuration.
%
%   SMTCONFIG tunes various configuration options of the toolbox.
%
%   value=SMTCONFIG('property') returns the value of a configuration
%       property.
%   SMTCONFIG('property',value) sets a value for a property.
%   SMTCONFIG('property','default') sets the default value.
%   SMTCONFIG('default') sets the default values for all properties.
%   struc=SMTCONFIG returns a structure array containing all
%       properties.
%   struc=SMTCONFIG('property',value) returns a structure array
%       containing all properties, and then changes a property value.
%   SMTCONFIG(struc) changes all the properties contained in a
%       structure array.
%
%   Here are the properties list, the default values are marked by (DEF).
%
%   SMTCONFIG('display','full') selects full display of smt matrices (DEF).
%   SMTCONFIG('display','compact') selects compact display of smt matrices.
%
%   SMTCONFIG('convreal',true) converts the output of some functions
%       to real when the input is real (DEF).
%   SMTCONFIG('convreal',false) disables this feature.
%
%   SMTCONFIG('convint',true) converts the output of some functions
%       to integer when the input is integer (DEF).
%   SMTCONFIG('convint',false) disables this feature.
%
%   SMTCONFIG('crautoeig',true) turns on automatic computation and update 
%       of the ev field for a smcirc matrix, useful for speeding 
%       up matrix products.
%   SMTCONFIG('crautoeig',false) turns it off (DEF).
%
%   SMTCONFIG('tpautoeig',true) turns on automatic computation and update 
%       of the cev field for a smtoep matrix, useful for speeding 
%       up matrix products.
%   SMTCONFIG('tpautoeig',false) turns it off, that is the cev field must 
%       be computed and updated manually by the toeprem function (DEF).
%
%   SMTCONFIG('tpemb',function_pointer) defines the size of the circulant 
%       embedding for a smtoep matrix.  Two possible definition are:
%       @(dim1,dim2)pow2(nextpow2(dim1+dim2-1))     next power of 2 (DEF)
%       @(dim1,dim2)dim1+dim2-1                     tight embedding
%
%   SMTCONFIG('tpsolve',function_pointer) defines the function used to
%       solve Toeplitz linear systems (by matrix division).  The function
%	must take three parameters: first column of the Toeplitz matrix,
%       first row, right-hand side (DEF null pointer).
%       Example: SMTCONFIG('tpsolve',@(c,r,b)tsolve(c,r,b))
%       (if the function TSOLVE from the DRSOLVE toolbox is on the path).
%
%   SMTCONFIG('tpsolvels',function_pointer) defines the function used to
%       solve Toeplitz linear systems in the least square sense (by matrix
%       division).  The function must take three parameters: first column
%       of the Toeplitz matrix, first row, right-hand side (DEF null pointer).

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised August 10, 2011

persistent smtopts

fields = {'display','convreal','convint','crautoeig','tpautoeig','tpemb',...
	'tpsolve','tpsolvels'};
defaults = {	'full'	% display
		1	% convreal
		1	% convint
		0	% crautoeig
		0	% tpautoeig
		@(dim1,dim2)pow2(nextpow2(dim1+dim2-1))	% tpemb
		[]	% tpsolve
		[]	% tpsolvels
	   };

if isempty(smtopts) || (nargin==1 && strcmpi(property,'default'))
	for i = 1:numel(fields)
		smtopts.(fields{i}) = defaults{i};
	end
end

if (nargin > 0) && ~ischar(property) && ~isstruct(property)
	error('First argument must be a string or a structure.')
end

if nargin == 0
	if nargout,  out = smtopts;  end
elseif nargin == 1
	if isstruct(property)
		names = fieldnames(property);
		for i = 1:numel(names)
			smtconfig(names{i},property.(names{i}));
		end
		if nargout,  out = smtopts;  end
	else
		switch property
			case 'default'
				if nargout,  out = smtopts;  end
			case fields
				out = smtopts.(property);
			otherwise
				warning('SMT:smtconfig:UnknownProperty', ...
					'Unknown "%s" property.', property)
		end
	end
elseif nargin == 2
	if nargout,  out = smtopts;  end
	switch property
		case 'display'
			switch value
				case 'default'
					smtopts.(property) = defaults{1};
				case {'full','compact'}
					smtopts.(property) = value;
				otherwise
					valerror(property)
			end
		case 'convreal'
			switch value
				case 'default'
					smtopts.(property) = defaults{2};
				case {true,false}
					smtopts.(property) = value;
				otherwise
					valerror(property)
			end
		case 'convint'
			switch value
				case 'default'
					smtopts.(property) = defaults{3};
				case {true,false}
					smtopts.(property) = value;
				otherwise
					valerror(property)
			end
		case 'crautoeig'
			switch value
				case 'default'
					smtopts.(property) = defaults{4};
				case {true,false}
					smtopts.(property) = value;
				otherwise
					valerror(property)
			end
		case 'tpautoeig'
			switch value
				case 'default'
					smtopts.(property) = defaults{5};
				case {true,false}
					smtopts.(property) = value;
				otherwise
					valerror(property)
			end
		case 'tpemb'
			if strcmpi(value,'default')
				smtopts.(property) = defaults{6};
			elseif strcmpi(value,'power2')
				smtopts.(property) = ...
					@(dim1,dim2)pow2(nextpow2(dim1+dim2-1));
			elseif strcmpi(value,'tight')
				smtopts.(property) = @(dim1,dim2)dim1+dim2-1;
			elseif isa(value,'function_handle')
				smtopts.(property) = value;
			else
				valerror(property)
			end
		case 'tpsolve'
			if strcmpi(value,'default')
				smtopts.(property) = defaults{7};
			elseif isa(value,'function_handle') || isempty(value)
				smtopts.(property) = value;
			else
				valerror(property)
			end
		case 'tpsolvels'
			if strcmpi(value,'default')
				smtopts.(property) = defaults{8};
			elseif isa(value,'function_handle') || isempty(value)
				smtopts.(property) = value;
			else
				valerror(property)
			end
		otherwise
			warning('SMT:smtconfig:UnknownProperty', ...
				'Unknown "%s" property.',property)
	end
else
	error('Too many input arguments.')
end


function valerror(property)
warning('SMT:smtconfig:WrongValue', ...
	'Value not allowed for "%s" property.',property)

