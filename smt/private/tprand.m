function T = tprand(m,n,cstr)
%TPRAND uniformly distributed random Toeplitz matrix.
%
%   T = SMTGALLERY('TPRAND', N) is an N-by-N real Toeplitz
%   matrix with random entries, chosen from a uniform
%   distribution on the interval (0.0,1.0).
%   T = SMTGALLERY('TPRAND', M, N) returns an M-by-N matrix.
%
%   T = SMTGALLERY('TPRAND', N, 'c') and
%   T = SMTGALLERY('TPRAND', M, N, 'c') return a complex 
%   Toeplitz matrix whose entries have random real and
%   immaginary part.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if nargin<1
	error('Missing dimension.')
end

if ((nargin==2) && ischar(n) && (n(1)=='c')) || ...
		((nargin>2) && ischar(cstr) && (cstr(1)=='c'))
	flag = 1;
else
	flag = 0;
end

if (nargin<2) || ~isnumeric(n)
	n = m;
end

if flag
	u = rand(m,1) + 1i*rand(m,1);
	v = rand(n,1) + 1i*rand(n,1);
else
	u = rand(m,1);
	v = rand(n,1);
end

v(1) = u(1);
T = smtoep(u,v);
