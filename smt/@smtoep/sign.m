function T = sign(T)
%SIGN   Signum function.
%   For each element of a smtoep matrix T, SIGN(T) returns a
%   smtoep matrix were a component is 1 if the element of T
%   is greater than zero, 0 if it equals zero and -1 if it is
%   less than zero.  For the nonzero elements of complex T,
%   SIGN(T) = T ./ ABS(T).
%
%   See also SMTOEP/ABS.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

T.t = sign(T.t);
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end

