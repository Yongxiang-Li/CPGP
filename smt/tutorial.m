%TUTORIAL SMToolbox tutorial.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

if ~exist('smcirc','file')
	error('the directory SMT is not in the path')
end
clear all

% DECREASE THIS VALUE IF YOUR COMPUTER IS SLOW OR YOUR RAM IS SMALL
n = 2000;

clc
echo on
    
% CREATING CIRCULANT MATRICES
C = smcirc([5 4 3 2 1])
pause % press a key

D = smcirc(6:10)
whos C D
pause % press a key

% STRUCTURE OF SMCIRC OBJECTS
smtconfig display compact
C
smtconfig display full

pause % press a key

% FIRST COLUMN OF THE CIRCULANT MATRIX
C.c
pause % press a key

% CREATING TOEPLITZ MATRICES
A = smtoep(5:-1:1,5:9)
pause % press a key

B = smtoep([5 4 3 2 1])
whos A B
pause % press a key

% STRUCTURE OF SMTOEP OBJECTS
smtconfig display compact
B
smtconfig display full

pause % press a key

% THE TOEPLITZ MATRIX DATA
B.t
pause % press a key

% OPERATORS AND TYPE OF THE RESULTS
E = A + B
whos A B E
pause % press a key

F = A .* B
whos A B F
pause % press a key

G = A * B
whos A B G
pause % press a key

H = A + C
whos A C H
pause % press a key

% NOT ALL OPERATIONS ARE DEFINED
inv(C)
% INV(A) PRODUCES THE ERROR:
%
% ??? Error using ==> smtoep.inv at 14
% Not yet implemented, use inv(full(T)) instead.

pause % press a key

% ONLINE HELP IS AVAILABLE FOR ALL FUNCTIONS
% help smtoep ...
%
pause % press a key

help smtoep
pause % press a key

% help smtoep/mtimes ...
%
pause % press a key

help smtoep/mtimes
pause % press a key

% FOR A LIST OF AVAILABLE FUNCTIONS, TRY:
% help smt
% help smcirc/Contents
% help smtoep/Contents
%
pause % press a key

% MEMORY STORAGE
v = rand(n,1);
R = toeplitz(v);   % THIS IS A FULL MATRIX
S = smtoep(v);     % THIS IS A SMTOEP MATRIX
whos R S
pause % press a key

% TEST ON THE SPEED OF COMPUTATION:
% PERFORM 200 MATRIX-VECTOR PRODUCTS
x = rand(n,1);

tic, for i=1:200, y=R*x; end, toc % R IS A FULL MATRIX (WAIT A BIT ...)

tic, for i=1:200, y=S*x; end, toc % S IS A SMTOEP MATRIX

pause % press a key

% TEST FOR A VERY LARGE DIMENSION:
% MATRIX-VECTOR PRODUCT
w = rand(100000,1);
S = smtoep(w);
whos S

x = rand(100000,1);
tic, y=S*x; toc

pause % press a key

% SUBINDEXING IS ALLOWED
% THE OUTPUT IS STRUCTURED WHEN POSSIBLE
C = smcirc(rand(5,1))
pause % press a key

T = C(2:5,1:4)

whos C T
pause % press a key

M = C([1 3 5],1:5);

whos C M
pause % press a key

% THE SMTGALLERY SUITE
%
% help smtgallery
%
pause % press a key

help smtgallery
pause % press a key

help private/gaussian
pause % press a key

T = smtgallery('gaussian',1000);
T(1:5,1:5)
pause % press a key

get(T)
pause % press a key

% THE SMTCPREC SUITE
%
help smtcprec
pause % press a key

help private/optimal
pause % press a key

A = smtgallery('gaussian',1000);
S = smtcprec('strang',A);         % STRANG PRECONDITIONER
O = smtcprec('optimal',A);        % OPTIMAL PRECONDITIONER
T = smtcprec('superoptimal',A);   % SUPEROPTIMAL PRECONDITIONER
whos A S O T
pause % press a key

% CONJUGATE GRADIENT TEST
S = smtgallery('gaussian',n);   % SMTOEP MATRIX
R = full(S);                    % FULL MATRIX
b = S*ones(n,1);

% CONJUGATE GRADIENT - FULL MATRIX
tic, [x flag res iter] = pcg(R,b,1e-8,100); toc, iter
% CONJUGATE GRADIENT - SMTOEP MATRIX
tic, [x flag res iter] = pcg(S,b,1e-8,100); toc, iter
pause % press a key

% CONJUGATE GRADIENT WITH OPTIMAL PRECONDITIONING
C = smtcprec('optimal',S);
whos C

% PCG WITH FULL MATRIX
tic, [x flag res iter] = pcg(R,b,1e-8,100,C); toc, iter
% PCG WITH SMTOEP MATRIX
tic, [x flag res iter] = pcg(S,b,1e-8,100,C); toc, iter
pause % press a key

% A LARGER TEST
S = smtgallery('gaussian',50000);
b = S*ones(50000,1);
C = smtcprec('optimal',S);
whos S C
tic, [x flag res iter] = pcg(S,b,1e-8,100,C); toc, iter
pause % press a key

% GMRES TEST
T = smtgallery('tparter',5000);
b = T*ones(5000,1);

% NO PRECONDITIONING
tic, [x flag res iter] = gmres(T,b,[],1e-8,100); toc, iter
% STRANG PRECONDITIONING
C = smtcprec('strang',T);
tic, [x flag res iter] = gmres(T,b,[],1e-8,100,C); toc, iter
pause % press a key

echo off, return

