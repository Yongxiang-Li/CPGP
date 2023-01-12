function T = double(T)
%DOUBLE Convert to double precision.
%
%   DOUBLE(T) converts a smtoep matrix T to double precision.
%   If T is already stored in double precision, DOUBLE has no 
%   effect.
%
%   See also SMTOEP/SINGLE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

T.t = double(T.t);
T.cev = double(T.cev);



