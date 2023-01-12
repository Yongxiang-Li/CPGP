% test on speedup and memory saving
%
% this file creates a .mat file, test1graf.m displays the graph
% see Figure 1 in the paper

mink = 9;  maxk = 12;
%mink = 9;  maxk = 14; % parameters used in the paper

mindim = 2^mink;	% minimum dimension
maxdim = 2^maxk;	% maximum dimension
ntests = 5;		% number of tests

graphicoutput = 1;	% visualize waitbar

vn = 2.^(mink:maxk)';
num = length(vn);

sizt = zeros(size(vn));
sizf = zeros(size(vn));
timst = zeros(size(vn));
timsf = zeros(size(vn));
timpt = zeros(size(vn));
timpf = zeros(size(vn));

fprintf('\n\n')
fprintf('Test on the speedup and memory saving')
fprintf('\n\n')
fprintf('dimension of matrix: powers of 2 in [%d,%d]\n',mindim,maxdim)
fprintf('number of tests for each dimension: %d\n\n',ntests);
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
	x = rand(n,1);
	wh = whos('T');
	sizt(i) = wh.bytes;
	A = full(T);
	wh = whos('A');
	sizf(i) = wh.bytes;
	clear S B y z
	tic		% start
	for k = 1:ntests
		S = T+T;
	end
	timst(i) = toc;	% stop
	tic		% start
	for k = 1:ntests
		B = A+A;
	end
	timsf(i) = toc;	% stop
	tic		% start
	for k = 1:ntests
		y = T*x;
	end
	timpt(i) = toc;	% stop
	tic		% start
	for k = 1:ntests
		z = A*x;
	end
	timpf(i) = toc;	% stop
end

%format short e, [sizt sizf timst timsf timpt timpf]
save test1 mink maxk vn sizt sizf timst timsf timpt timpf
if graphicoutput,  close(hw),  test1graf,  else,  fprintf('\n'),  end

