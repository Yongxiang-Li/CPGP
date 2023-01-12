function is = isreal(C)
%ISREAL True for real array.
%
%   ISREAL(C) returns 1 if C does not have an imaginary part
%   and 0 otherwise.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

is = isreal(C.c);
