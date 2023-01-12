function C = crrand(n,cstr)
%CRRAND uniformly distributed random circulant matrix.
%
%   T = SMTGALLERY('CRRAND', N) is an N-by-N real circulant
%   matrix with random entries, chosen from a uniform
%   distribution on the interval (0.0,1.0).
%
%   T = SMTGALLERY('CRRAND', N, 'c') returns a complex N-by-N
%   circulant matrix whose entries have random real and
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

if (nargin>1) && ischar(cstr) && (cstr(1)=='c')
	flag = 1;
else
	flag = 0;
end

if flag
	u = rand(n,1) + 1i*rand(n,1);
else
	u = rand(n,1);
end

C = smcirc(u);
