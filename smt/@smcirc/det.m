function d = det(C)
%DET    Determinant.
%
%   DET(C) is the determinant of the circulant matrix C.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 20, 2011

d = prod(eig(C));
if isreal(C.c),  d = real(d);  end
if all(C.c==fix(C.c)),  d = round(d);  end

