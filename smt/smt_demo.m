addpath('..\routine');

p = 10;
r = period_sin_gauss_cov(1, 2, p, 1,(1:p)');
r(1) = r(1) + 1;
a = (1:p)';
C = smcirc(r);
mldivide(C, a(:));
tic; inv(C); toc;
M = full(C); 
tic; inv(M); toc;



T = smtoep(r);
mldivide(T, a(:));
