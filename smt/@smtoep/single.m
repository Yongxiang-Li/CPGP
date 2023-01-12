function T = single(T)
%SINGLE Convert to single precision.
%
%   SINGLE(T) converts a smtoep matrix T to single precision.
%   If T is already stored in single precision, SINGLE has no 
%   effect.
%
%   See also SMTOEP/DOUBLE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

T.t = single(T.t);
T.cev = single(T.cev);

