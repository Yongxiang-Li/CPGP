function is = smtvalid(A)
%SMTVALID Determine if an object is a valid operand.
%
%   SMTVALID(A) returns 1 if the storage class of A is smcirc
%   and 0 otherwise.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

is = isa(A,'smcirc');
