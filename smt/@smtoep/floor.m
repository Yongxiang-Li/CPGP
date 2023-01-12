function T = floor(T)
%FLOOR  Matrix element-wise floor.
%
%   FLOOR(T) rounds the elements of T to the nearest integers
%   towards minus infinity.
%
%   See also SMTOEP/ROUND, SMTOEP/CEIL, SMTOEP/FIX 

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

T.t = floor(T.t);
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end

