function validate(m,n,tau,show)
%VALIDATE Validation script for the SMToolbox.
%
%   VALIDATE checks the consistency of the computational routines
%   in SMT, by comparing the results with the corresponding
%   functions for full matrices.
%
%   VALIDATE(m,n,tau,show) allows to set some parameters: [m,n] is
%   the size of the matrices on which the test is run (def. 10),
%   tau is the tolerance used (def. 1e-8), and show is a flag to
%   display which tests are performed (def. false)
%   VALIDATE by itself used the default values.
%
%   Some tests are performed only on square matrices.
%
%   See also TESTSMCIRC, TESTSMTOEP.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 21, 2011

if nargin<4 || isempty(show),  show = 0;  end
if nargin<3 || isempty(tau),  tau = 1e-8;  end
if nargin<2 || isempty(n),  n = 10;  end
if nargin<1 || isempty(m),  m = 10;  end

Ar = @(m,n)randn(m,n);
Ac = @(m,n)randn(m,n)+1i*randn(m,n);
Cr = @(m,n)smtgallery('crrandn',n);
Cc = @(m,n)smtgallery('crrandn',n,'c');
Tr = @(m,n)smtgallery('tprandn',m,n);
Tc = @(m,n)smtgallery('tprandn',m,n,'c');

clc 
fprintf('SMT validate (m=%d,n=%d).\n\n',m,n)

state = smtconfig;
s1 = warning('off','SMT:mrdivide:SlowComputation');
s2 = warning('off','SMT:mldivide:SlowComputation');

if (m==n) && exist('tsolve','file') == 2
	fprintf('Using tsolve to solve Toeplitz linear systems.\n\n')
	smtconfig('tpsolve',@(c,r,b)tsolve(c,r,b))
else
	smtconfig('tpsolve','default')
end

err = 0;
for k = [0 1]
	smtconfig('crautoeig',k)
	smtconfig('tpautoeig',k)
	fprintf('Automatic computation of ev/cev fields')
	if k,  fprintf(' enabled.\n'),  else  fprintf(' disabled.\n'),  end
	disp('circulant-full, real')
	err = err || testsmcirc(Cr,Ar,tau,n,show);
	disp('circulant-full, complex')
	err = err || testsmcirc(Cc,Ac,tau,n,show);
	disp('circulant-circulant, real')
	err = err || testsmcirc(Cr,Cr,tau,n,show);
	disp('circulant-circulant, complex')
	err = err || testsmcirc(Cc,Cc,tau,n,show);
	disp('Toeplitz-full, real')
	err = err || testsmtoep(Tr,Ar,tau,m,n,show);
	disp('Toeplitz-full, complex')
	err = err || testsmtoep(Tc,Ac,tau,m,n,show);
	disp('Toeplitz-Toeplitz, real')
	err = err || testsmtoep(Tr,Tr,tau,m,n,show);
	disp('Toeplitz-Toeplitz, complex')
	err = err || testsmtoep(Tc,Tc,tau,m,n,show);
	if m==n
		disp('Toeplitz-circulant, real')
		err = err || testsmtoep(Tr,Cr,tau,m,n,show);
		disp('Toeplitz-circulant, complex')
		err = err || testsmtoep(Tc,Cc,tau,m,n,show);
	end
	fprintf('\n')
end

if err
	fprintf('Some errors have been found.\n\n')
else
	fprintf('The toolbox is working fine.\n\n')
end

warning(s1)
warning(s2)
smtconfig(state)

%	test da fare (reale e complesso)
% circ-toep square
% toep-full square and rectangular
% toep-toep square and rectangular

