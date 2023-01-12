function out = length(C)
%LENGTH Length of a smcirc matrix.
%
%    LENGTH(C) returns the length of the smcirc matrix C. It is
%    equivalent to MAX(SIZE(C)) if C is a non-empty matrix,
%    and 0 for empty ones.
%
%    See also SMCIRC/SIZE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

% Determine the length
out = max(size(C));
