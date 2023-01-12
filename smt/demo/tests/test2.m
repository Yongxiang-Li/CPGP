% test on the overhead caused by the toolbox
%
% this file creates a .mat file, test2graf.m displays the graph
% see Figure 2 in the paper

mink = 10;  maxk = 14;
%mink = 11;  maxk = 18;	% parameters used in the paper

mindim = 2^mink;	% minimum dimension
maxdim = 2^maxk;	% maximum dimension
ntests = 100;		% number of tests

graphicoutput = 1;	% visualize waitbar

vn = 2.^(mink:maxk)';
num = length(vn);

timt = zeros(size(vn));
timi = zeros(size(vn));
timtf = zeros(size(vn));
timif = zeros(size(vn));

fprintf('\n\n')
fprintf('Test on the overhead caused by the toolbox w.r.t. inline code')
fprintf('\n\n')
fprintf('dimension of matrix: powers of 2 in [%d,%d]\n',mindim,maxdim)
fprintf('number of tests for each dimension: %d\n\n',ntests);
if graphicoutput
	hw = waitbar(0,'Please wait...');
else
	fprintf('test going on:')
end

smtstate = smtconfig('tpautoeig',1);
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
	b1 = T*x;
	timt(i) = toc;	% stop
	tic		% start
	for k = 1:ntests
		b1 = T*x(:,k);
	end
	timtf(i) = toc;	% stop
	N = size(T.cev,1);
	tic		% start
	b2 = ifft(spdiags(T.cev,0,N,N) * fft([x;zeros(N-size(x,1),ntests)]));
	b2 = b2(1:T.dim1,:);
	b2 = real(b2);
	timi(i) = toc;	% stop
	tic		% start
	for k = 1:ntests
		b2 = ifft(spdiags(T.cev,0,N,N) * fft([x(:,k);zeros(N-size(x,1),1)]));
		b2 = b2(1:T.dim1,:);
		b2 = real(b2);
	end
	timif(i) = toc;	% stop
end

smtconfig( smtstate)
save test2 mink maxk vn timt timi timtf timif
if graphicoutput,  close(hw),  test2graf,  else,  fprintf('\n'),  end

