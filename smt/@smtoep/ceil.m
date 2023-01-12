function T = ceil(T)
%CEIL   Matrix element-wise ceiling.
%
%   CEIL(T) rounds the elements of T to the nearest integers
%   towards infinity.
%
%   See also SMTOEP/FLOOR, SMTOEP/ROUND, SMTOEP/FIX 

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

T.t = ceil(T.t);
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end

