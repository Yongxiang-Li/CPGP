function [Yp] = predict_CPGP(model, X) 
% BLUP for double check
%         r = dmodel.corr(delta, theta, p, 1, (1:n)'); 
%         r(1) = r(1) + delta^2;    S = toep_chol(r);
%         gamma = S' \ (S \ (dmodel.Y-dmodel.F*dmodel.betahat));
%         Cr = dmodel.corr(delta, theta, p, X, (1:n)');
%         Yhat = f*dmodel.betahat + Cr*gamma;
    n = length(model.Y);    q = size(model.F,2);
    if nargin<2, X = (1:n)'; end
  	T = model.period;    p = str2num(regexprep(rats(T, 30),'/.*', '')); % decimal period
    k = floor(n/p);    p1 = n - p*k;
    model.F = model.regr((1:n)'/n);
    theta = model.thetahat(2);   beta = model.betahat;
    Y = model.Y(1:p*k);    Yb = mean(reshape(Y, p, k), 2);    Ys = model.Y(1+p*k:end);
    G = model.F(1:p*k,:);   Gb = zeros(p,q);    Gs = model.F(1+p*k:end,:);
    for j = 1 : q
        Gb(:,j) = mean(reshape(G(:,j), p, k), 2);
    end
    
    delta = model.thetahat(1);
    if p > n
        r = model.corr(delta, theta, T, 1, (1:n)'); 
        r(1) = r(1) + delta^2;    S = toep_chol(r);
        gamma = S' \ (S \ (model.Y-model.F*beta));
        Rx = model.corr(delta, theta, T, X, (1:n)');
        Zb =  Rx*gamma;
    else
        R0.c = model.corr(delta, theta, T, (1:p)', 1);    R0.eig = abs(fft(R0.c))+eps;
        Rd.c = k*R0.c/delta^2 + eye(p,1);    Rd.eig = real(fft(Rd.c));
        RRd.eig = (k/delta^2) * (R0.eig ./ Rd.eig);    RRd.c = ifft(RRd.eig);
        RRdGb = ifft(RRd.eig .* fft(Gb));    RRdYb = ifft(RRd.eig .* fft(Yb));
        Zb = RRdYb - RRdGb*beta;
        if p1>0
            Yd = Ys - RRdYb(1:p1); % Y dot
            Gd = Gs - RRdGb(1:p1,:); % Gamma dot
            rpi = R0.c - ifft(RRd.eig .* R0.eig) + delta^2*eye(p,1);
            ri = eye(p,1) - RRd.c; % Idot matrix
            rird = ifft(R0.eig .* fft(ri)); % Idot \times R
            IdRd = toeplitz(rird, rird(1:p1));
            [Ydll, ~, ~, ~] = cpcg(rpi, Yd, 1e-6, p1);
            [Gdll, ~, ~, ~] = cpcg(rpi, Gd, 1e-6, p1);
            Zb = Zb + (IdRd * (Ydll - Gdll*beta ));
        end
    end
    Z = repmat(Zb, k+1, 1);    Z = Z(1:n);
    beta = (model.F'*model.F) \ (model.F' * (model.Y-Z));
    Yp = model.F*beta + Z;
end

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

end
