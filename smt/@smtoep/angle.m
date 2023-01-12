function T = angle(T)
%ANGLE  Phase angle.
%
%   ANGLE(T) returns the phase angles, in radians, of 
%   smtoep matrix with complex elements.
%
%   See also SMTOEP/ISREAL, SMTOEP/REAL, SMTOEP/IMAG, 
%            SMTOEP/CONJ, SMTOEP/ABS.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

T.t = angle(T.t);
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end
