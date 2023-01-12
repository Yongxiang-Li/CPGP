function varargout = smtgallery(matname,varargin)
%SMTGALLERY SMT test matrices.
%   [out1,out2,...] = SMTGALLERY(matname, param1, param2, ...)
%   takes matname, a string that is the name of a matrix family, and
%   the family's input parameters. See the listing below for available
%   matrix families. Most of the functions take an input argument
%   that specifies the order of the matrix, and unless otherwise
%   stated, return a single output.
%   For additional information, type "help private/matname", where matname
%   is the name of the matrix family.
%
%   crrand    uniformly distributed random circulant matrix
%   crrandn   normally distributed random circulant matrix
%
%   algdec    Toeplitz matrix with algebraic decay
%   expdec    Toeplitz matrix with exponential decay
%   gaussian  Gaussian Toeplitz matrix
%   tchow     Chow matrix -- a singular Toeplitz lower Hessenberg matrix
%   tdramadah matrix of ones and zeroes whose inverse has large integer entries
%   tgrcar    Grcar matrix -- a Toeplitz matrix with sensitive eigenvalues
%   tkms      Kac-Murdock-Szego Toeplitz matrix
%   tparter   Parter matrix -- a Toeplitz matrix with singular values near PI
%   tprkdef   rank deficient linear prediction Toeplitz matrix
%   tprand    uniformly distributed random Toeplitz matrix
%   tprandn   normally distributed random Toeplitz matrix
%   tprolate  Prolate Toeplitz matrix -- symmetric, ill-conditioned matrix
%   ttoeppd   symmetric positive definite Toeplitz matrix
%   ttoeppen  pentadiagonal Toeplitz matrix (sparse)
%   ttridiag  tridiagonal Toeplitz matrix (sparse)
%   ttriw     upper triangular Toeplitz matrix discussed by Wilkinson and others
%
%   This function is written following the gallery function of Matlab.
%
%   See also GALLERY.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 23, 2011

[varargout{1:max(nargout,1)}] = feval(matname,varargin{:});
