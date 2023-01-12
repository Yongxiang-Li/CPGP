function T = round(T)
%ROUND  Matrix element-wise round.
%
%   ROUND(T) rounds the elements of T to the nearest integers.
%
%   See also SMTOEP/FLOOR, SMTOEP/CEIL, SMTOEP/FIX 

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

T.t = round(T.t);
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end

