function C = crrandn(n,cstr)
%CRRANDN normally distributed random circulant matrix.
%
%   T = SMTGALLERY('CRRANDN', N) is an N-by-N real circulant
%   matrix with random entries, chosen from a normal 
%   distribution with mean zero and standard deviation one.
%
%   T = SMTGALLERY('CRRANDN', N, 'c') returns a complex N-by-N
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
	u = randn(n,1) + 1i*randn(n,1);
else
	u = randn(n,1);
end

C = smcirc(u);
