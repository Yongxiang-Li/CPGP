function T = abs(T)
%ABS    Absolute value.
%
%   ABS(T) is the absolute value of the elements of smtoep
%   matrix T. When T is complex, ABS(T) is the complex 
%   modulus (magnitude) of the elements of T.
%
%   See also SMTOEP/SIGN, SMTOEP/ANGLE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

T.t = abs(T.t);
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end

