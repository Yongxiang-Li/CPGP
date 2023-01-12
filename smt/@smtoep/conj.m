function T = conj(T)
%CONJ   Complex conjugate.
%
%   CONJ(T) is the complex conjugate of smtoep matrix T.
%   For a complex T, CONJ(T) = REAL(T) - i*IMAG(T).
%
%   See also SMTOEP/ISREAL, SMTOEP/REAL, SMTOEP/IMAG, 
%            SMTOEP/ANGLE, SMTOEP/ABS.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised April 1, 2009

if ~isreal(T.t)
	T.t = conj(T.t);
	if ~isempty(T.cev)
		T.cev = conj(T.cev([1 end:-1:2]));
	end
end
