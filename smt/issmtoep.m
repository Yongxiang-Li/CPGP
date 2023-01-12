function is = issmtoep(A)
%ISSMTOEP True for Toeplitz matrices of class smtoep.
%
%   ISSMTOEP(A) returns 1 if the storage class of A is smtoep
%   and 0 otherwise.
%
%   See also SMTOEP.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

is = isa(A,'smtoep');
