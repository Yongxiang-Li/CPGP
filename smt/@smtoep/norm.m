function y = norm(T,p)
%NORM   Matrix or vector norm.
%
%   For smtoep objects...
%     NORM(T,1) is the 1-norm of T, the largest column sum,
%                     = max(sum(abs(T))).
%     NORM(T,inf) is the infinity norm of T, the largest row sum,
%                     = max(sum(abs(T'))).
%     NORM(T,'fro') is the Frobenius norm, sqrt(sum(diag(T'*T))).
%     NORM(T,2) is not implemented yet.
%     NORM(T,P) is available for T only if P is 1, inf or 'fro'.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised April 17, 2009

if nargin < 2,
	error('You must supply P = 1, inf or ''fro''.')
end

switch p
   case 2
	error('Not yet implemented, use norm(full(T),2) instead.')
   case 1
   	y = max(sum(abs(T)));
   case {inf,'inf'}
   	y = max(sum(abs(T')));
   case 'fro'
   	k = min([T.dim1 T.dim2]);
	y = sqrt([1:k k*ones(1,abs(T.dim1-T.dim2)) k-1:-1:1] * abs(T.t).^2);
   otherwise
   	error('The only matrix norms available are 1, inf, and ''fro''.')
end
