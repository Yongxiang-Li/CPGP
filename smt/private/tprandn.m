function T = tprandn(m,n,cstr)
%TPRANDN normally distributed random Toeplitz matrix.
%
%   T = SMTGALLERY('TPRANDN', N) is an N-by-N real Toeplitz
%   matrix with random entries, chosen from a normal 
%   distribution with mean zero and standard deviation one.
%   T = SMTGALLERY('TPRANDN', M, N) returns an M-by-N matrix.
%
%   T = SMTGALLERY('TPRANDN', N, 'c') and
%   T = SMTGALLERY('TPRANDN', M, N, 'c') return a complex 
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
	u = randn(m,1) + 1i*randn(m,1);
	v = randn(n,1) + 1i*randn(n,1);
else
	u = randn(m,1);
	v = randn(n,1);
end

v(1) = u(1);
T = smtoep(u,v);
