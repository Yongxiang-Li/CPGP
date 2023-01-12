function out = length(T)
%LENGTH Length of a smtoep matrix.
%
%    LENGTH(T) returns the length of the smtoep matrix T. It is
%    equivalent to MAX(SIZE(T)) if T is a non-empty matrix, 
%    and 0 for empty ones.
%
%    See also SMTOEP/SIZE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

% Determine the length
out = max(size(T));
