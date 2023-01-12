function T = reshape(T,m,n)
%RESHAPE Change size of a smtoep matrix.
%
%   RESHAPE(T,M,N) returns the M-by-N smtoep matrix having the
%   same .t field as T.  An error results if SUM(SIZE(T)) is
%   different from M+N, that is if LENGTH(T.t) is different from
%   M+N-1.
%
%   RESHAPE(T,[M N]) is the same thing.
%
%   RESHAPE(T,M,[]) or RESHAPE(T,[],N) calculates the length of
%   the dimension represented by [], such that the sum of the
%   dimensions equals SUM(SIZE(T)). You can use only one
%   occurrence of [].

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised August 11, 2011

if nargin < 2
	error('Not enough input arguments.')
end

if (nargin == 2) && (length(m)==2)
	n = m(2);
	m = m(1);
elseif (nargin ~= 3)
	error('Size vector must have exactly two elements.')
end

if isempty(m)
	m = (T.dim1+T.dim2-n);
elseif isempty(n)
	n = (T.dim1+T.dim2-m);
elseif ~isscalar(m) || ~isscalar(n)
	error('Size arguments must be integer scalars.')
end

if m+n ~= T.dim1+T.dim2
	error('To RESHAPE the number of elements must not change.')
end

T.dim1 = m;
T.dim2 = n;
T.cev = [];
if smtconfig('tpautoeig')
	T = toeprem(T);
end

