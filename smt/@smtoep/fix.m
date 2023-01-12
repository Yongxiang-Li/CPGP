function T = fix(T)
%FIX Round towards zero.
%
%   FIX(T) rounds the elements of T to the nearest integers
%   towards zero.
%   FIX(T) = FLOOR(T) if T is positive and CEIL(T) if T is 
%   negative.
%
%   See also SMTOEP/FLOOR, SMTOEP/ROUND, SMTOEP/CEIL 

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

T.t = fix(T.t);
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end

