% test on embedding of a Toeplitz matrix into a circulant
%
% this file creates a .mat file, test3graf.m displays the graph
% see Figure 3 in the paper

mink = 10;  maxk = 12;
%mink = 11;  maxk = 16;	% parameters used in the paper

mindim = 2^mink;	% minimum dimension
maxdim = 2^maxk;	% maximum dimension
ntests = 10;		% number of tests

graphicoutput = 1;	% visualize waitbar

vn = primes(maxdim)';
vn = vn(vn>=mindim);
num = length(vn);

tim2 = zeros(size(vn));
timt = zeros(size(vn));

fprintf('\n\n')
fprintf('Test on the effect of embedding on Toeplitz matrix-vector product')
fprintf('\n\n')
fprintf('dimension of matrix: prime numbers in [%d,%d]\n',mindim,maxdim)
fprintf('number of tests for each dimension: %d\n\n',ntests);

smtstate = smtconfig( 'tpemb', @(dim1,dim2)pow2(nextpow2(dim1+dim2-1)));
fprintf('testing matrix product on %d matrices with power-2 embedding\n',num)
if graphicoutput
	hw = waitbar(0,'Please wait...');
else
	fprintf('test going on:')
end
for i = 1:num
	n = vn(i);
	if graphicoutput
		waitbar(i/num,hw,sprintf('n = %d',n))
	else
		fprintf(' %d', n)
	end
	T = smtgallery('tprand',n);
	x = rand(n,ntests);
	tic		% start
	b = T*x;
	tim2(i) = toc;	% stop
end
if graphicoutput,  close(hw),  else,  fprintf('\n'), end
fprintf('\n')

smtconfig( 'tpemb', @(dim1,dim2)dim1+dim2-1);
fprintf('testing matrix product on %d matrices with tight embedding\n',num)
if graphicoutput
	hw = waitbar(0,'Please wait...');
else
	fprintf('test going on:')
end
for i = 1:num
	n = vn(i);
	if graphicoutput
		waitbar(i/num,hw,sprintf('n = %d',n))
	else
		fprintf(' %d', n)
	end
	T = smtgallery('tprand',n);
	x = rand(n,ntests);
	tic		% start
	b = T*x;
	timt(i) = toc;	% stop
end

smtconfig( smtstate)
save test3 mink maxk vn tim2 timt
if graphicoutput,  close(hw),  test3graf,  else,  fprintf('\n'),  end

