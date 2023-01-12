function y = cond(C,p)
%COND   Condition number with respect to inversion.
%
%   COND(C) returns the 2-norm condition number (the ratio of the
%   largest singular value of C to the smallest) for the smcirc
%   object C.
%   Large condition numbers indicate a nearly singular matrix.
%
%   COND(C,P) returns the condition number of C in P-norm:
%
%      NORM(C,P) * NORM(INV(C),P). 
%
%   where P = 1, 2, inf, or 'fro'. 
%
%   Class support for input C:
%      float: double, single
%
%   See also smcirc/norm.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised October 20, 2010

if nargin < 2,  p = 2;  end

switch p
   case 2
	if isempty(C.ev)
		C.ev = eig(C);
	end
   	y = max(abs(C.ev)) / min(abs(C.ev));
   case {1,inf,'inf','fro'}
   	y = norm(C,p) * norm(inv(C),p);
   otherwise
   	error('The only matrix norms available are 1, 2, inf, and ''fro''.')
end
