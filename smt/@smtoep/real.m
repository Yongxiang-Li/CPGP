function T = real(T)
%REAL   Complex real part.
%
%   REAL(T) is the real part of smtoep matrix T.
%   See I or J to enter complex numbers.
%
%   See also SMTOEP/ISREAL, SMTOEP/IMAG, SMTOEP/CONJ, 
%            SMTOEP/ANGLE, SMTOEP/ABS.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 14, 2011

T.t = real(T.t);
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end

