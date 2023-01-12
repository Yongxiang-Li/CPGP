function T = uminus(T)
%-  Unary minus.
%
%   -T negates the elements of the smtoep matrix T.
%
%   A = UMINUS(T) is called for the syntax '-T' when T is a
%       smtoep object.
%
%   See also SMTOEP.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised June 9, 2006

T.t = -T.t;
T.cev = -T.cev;


