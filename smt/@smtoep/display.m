function display(T)
%DISPLAY  Display a matrix of the smtoep class.
%
%   DISPLAY(T) displays informations pertaining to the smtoep 
%   matrix T. It is called for the matrix T when the semicolon
%   is not used to terminate a statement.
%
%   Matrices may be displayed as full arrays or in compact form,
%   this can be configured by the SMTCONFIG command as follows:
%       smtconfig('display','full')
%       smtconfig('display','compact')
%
%   See also SMTOEP, SMTOEP/GET, SMTCONFIG.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised August 10, 2011

disp(' ');
disp([inputname(1),' = '])
disp(' ');
if strcmp( smtconfig('display'), 'full')
	if isempty(T)
		sprintf('     []\n')
	else
		disp(full(T))
	end
else
	if issparse(T.t),  s = ' (sparse) ';  else  s = ' ';  end
	disp(['smtoep',s,'object with fields:'])
	disp(struct(T))
end

