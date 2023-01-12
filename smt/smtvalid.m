function flag = smtvalid(A)
%SMTVALID Determine if an object is a valid operand.
%
%   SMTVALID(A) returns 1 if A is float and not sparse.
%
%   See also SMTOEP/SMTVALID

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

flag = isfloat(A) && ~issparse(A);
