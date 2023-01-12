function T = tprkdef(m,n,ds,a,omega,phi)
%TPRKDEF rank deficient linear prediction Toeplitz matrix
%
%   T = SMTGALLERY('TPRKDEF',M,N,DS,A,OMEGA,PHI) is a M-by-N Toeplitz
%   matrix.  If OMEGA(1)~=OMEGA(2)~=k*pi, DS<<|A(1)|+|A(2)| and
%   M>=N>4 it has rank 4, i.e., it has n-4 small singular values and
%   4 of the order of DS.
%   Default values: M=122, N=7, DS=0, A=[1,.4], OMEGA=[pi/10,pi/3],
%   PHI=[0,pi/4].
%
%   This matrix is a reordering of a Hankel matrix described in
%   Section 1.4.1 of the book: 
%   P.C. Hansen, Rank-Deficient and Discrete Ill-Posed Problems:
%   Numerical Aspects of Linear Inversion, SIAM, 1998.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 23, 2011

if nargin<6,  phi = [0 pi/4];  end
if nargin<5,  omega = [pi/10 pi/3];  end
if nargin<4,  a = [1 .4];  end
if nargin<3,  ds = 0;  end
if nargin<2,  m = 122;  n = 7;  end
if nargin==1,  error('Need two dimensions.'),  end

N = m+n-1;
vi = (1:N)';
s = a(1)*sin(vi*omega(1)+phi(1)) + a(2)*sin(vi*omega(2)+phi(2));
randn('state',0)
s = s + ds*randn(N,1);
%A = hankel(s(1:m),s(m:N));	% Hansen's original matrix
%A = toeplitz(s(1:m),s(m:N));	% this is what we are constructing
T = smtoep(s,m,n);
