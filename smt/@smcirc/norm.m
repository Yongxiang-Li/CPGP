function y = norm(C,p)
%NORM   Matrix or vector norm.
%
%   For smcirc objects...
%     NORM(C) is the largest singular value of C, max(svd(C))
%                     =max(abs(eig(C))).
%     NORM(C,2) is the same as NORM(C).
%     NORM(C,1) is the 1-norm of C, the largest column sum,
%                     = max(sum(abs(C))).
%     NORM(C,inf) is the infinity norm of C, the largest row sum,
%                     = max(sum(abs(C'))).
%     NORM(C,'fro') is the Frobenius norm, sqrt(sum(diag(C'*C))).
%     NORM(C,P) is available for C only if P is 1, 2, inf or 'fro'.
%
%   See also SMCIRC/COND.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised April 17, 2009

if nargin < 2,  p = 2;  end

switch p
   case 2
   	y = max(abs(eig(C)));
   case {1,inf,'inf'}
   	y = sum(abs(C.c));
   case 'fro'
   	y = norm(C.c) * sqrt(C.dim);
   otherwise
   	error('The only matrix norms available are 1, 2, inf, and ''fro''.')
end
