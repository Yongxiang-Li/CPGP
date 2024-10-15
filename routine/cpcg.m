function [x, error, iter, flag] = cpcg(a, b, tol, max_it)

%CPCG -CIRCULANT PRECONDITIONED CONJUGATE GRADIENT METHOD.
%  [x, error, iter, flag] = cpcg(a, b, tol, max_it, c, x0)
%  [x, error, iter, flag] = cpcg(a, b, c)
%  [x, error, iter, flag] = cpcg(a, b)
%
% tol, max_it, c, x0 can be replaced by [] and default vaules will be used.
%
% cpcg.m solves the symmetric positive definite Toeplitz linear system Ax=b 
% using the Conjugate Gradient method with a circulant preconditioner C. 
%
% Both matrices A and C have to be SYMMETRIC POSITIVE DEFINITE.
%
% input   a        REAL FIRST COLUMN of symmetric positive definite matrix
%         b        REAL right hand side vecto
%         tol      REAL error tolerance
%         max_it   INTEGER maximum number of iteration
%         c        REAL FIRST COLUMN of CIRCULANT preconditioner matrix
%         x0       REAL initial guess vector
%
% output  x        REAL solution vector
%         error    REAL error norm
%         iter     INTEGER number of iterations performed
%         flag     INTEGER: 0 = solution found to tolerance
%                           1 = no convergence given max_it

  % setup inputs
  n = length(a);    [p, q] = size(b);
  x = zeros(size(b)); 
  if nargin<=2
     tol = 1e-6;    
     max_it = length(b);   
  end
  
  % initialization  
  flag = 0;                                
  iter = 0;
  bnrm2 = norm( b );
  if  ( bnrm2 == 0.0 ), bnrm2 = 1.0; end  
  
  % NEW definition for the SAME varibles
  % tol is now the relative tolerance
  tol = tol * bnrm2;
  % a (of size 2n) is now the Fourier transfrom of the first column
  % of the circulant matrix [A X;X A]
  a = fft(a);
  
  % Compute Toeplitz matrix-vector product by fft
  w = [x; zeros(n-p,q)];
  Aw = real( ifft( a .* fft(w) ) );
  r = b - Aw(1:p,:);
  
  error = norm( r );
  if ( error < tol ), return, end
  for iter = 1:max_it                       % begin iteration
     z  = real( ifft( fft(r) ) );
     rho = sum(r.*z);
     if ( iter > 1 )                      % direction vector
        beta = rho / rho_1;
        wd = z + beta*wd;
     else
        wd = z;
     end
     w = [wd; zeros(n-p,q)];
     Aw = real( ifft( a .* fft(w) ) );
     alpha = rho ./ sum(wd.*Aw(1:p,:));
     x = x + alpha .* wd;                    % update approximation vector
     r = r - alpha .* Aw(1:p,:);        	% compute residual
     error = norm( r );                    % check convergence
     if ( error <= tol ), break, end 
     rho_1 = rho;
  end                         

% END pccg.m
