function C = inv(C)
%INV smcirc matrix inverse.
%
%   INV(C) is the inverse of the circulant matrix C.
%   A warning message is printed if C is badly scaled or
%   nearly singular.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

C = C^(-1);

