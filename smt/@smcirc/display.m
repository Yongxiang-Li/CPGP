function display(C)
%DISPLAY  Display a matrix of the smcirc class.
%
%   DISPLAY(C) displays informations pertaining to the smcirc 
%   matrix C. It is called for the matrix C when the semicolon
%   is not used to terminate a statement.
%
%   Matrices may be displayed as full arrays or in compact form,
%   this can be configured by the SMTCONFIG command as follows:
%       smtconfig('display','full')
%       smtconfig('display','compact')
%
%   See also SMCIRC, SMCIRC/GET, SMTCONFIG.

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
	if isempty(C)
		fprintf('     []\n')
	else
		disp(full(C))
	end
else
	if issparse(C.c),  s = ' (sparse) ';  else  s = ' ';  end
	disp(['smcirc',s,'object with fields:'])
	disp(struct(C))
end

