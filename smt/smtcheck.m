function out = smtcheck(dis)
%SMTCHECK Check SMToolbox installation.
%
%   SMTCONFIG checks for potential problems in the installation
%   of SMToolbox.  Returns 0 if everything is fine.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if nargin < 1,  dis = 1;  end	% display messages only if dis is nonzero

if nargout > 0,  out = 0;  end

if isempty(strfind(matlabpath,'smt'))
	if dis
		disp(' ')
		disp('Looks like the directory ''smt'' is not in the path.')
		disp('Add it with the command')
		disp(['	addpath ' pwd])
		disp(' ')
	end
	if nargout > 0,  out = 1;  end
	return
end

if ~(exist('isfloat','builtin') || exist('isfloat','file'))
	if dis
		disp(' ')
		disp('The function ''isfloat'' is missing in this version of Matlab.')
		disp('Rename the file ''isfloat.m.no'' to ''isfloat.m''')
		disp('in the directory ''smt''.')
		disp(' ')
	end
	if nargout > 0,  out = 2;  end
	return
end

if dis
	disp(' ')
	disp('Everything is OK.')
	disp(' ')
end
