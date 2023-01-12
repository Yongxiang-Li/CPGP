% test on iterative methods for linear systems
%
% this file creates a .mat file, test4tab.m displays the table
% see Table 6 in the paper

mink = 9;  maxk = 13;  maxfk = 11;
%mink = 12;  maxk = 20;  maxfk = 14;	% parameters used in the paper

mindim = 2^mink;	% minimum dimension
maxdim = 2^maxk;	% maximum dimension
ntests = 1;		% number of tests
maxn = 2^maxfk;		% max size for full matrices
sigma = .8;		% parameter of Gaussian matrix
reps = 1;		% repetitions

graphicoutput = 1;	% visualize waitbar

vn = 2.^(mink:maxk)';
num = length(vn);

itf = zeros(size(vn));
timf = zeros(size(vn));
itt = zeros(size(vn));
timt = zeros(size(vn));
itts = zeros(size(vn));
timts = zeros(size(vn));
itto = zeros(size(vn));
timto = zeros(size(vn));
ittt = zeros(size(vn));
timtt = zeros(size(vn));
ittnt = zeros(size(vn));
timtnt = zeros(size(vn));

fprintf('\n\n')
fprintf('Test on iterative methods for linear systems')
fprintf('\n\n')
fprintf('dimension of matrix: powers of 2 in [%d,%d]\n',mindim,maxdim)
fprintf('number of tests for each dimension: %d\n',ntests);
fprintf('tests on full matrices are performed for n <= %d\n\n',maxn);
if graphicoutput
	hw = waitbar(0,'Please wait...');
else
	fprintf('test going on:')
end

smtstate = smtconfig;
for i = 1:num
	n = vn(i);
	if graphicoutput
		waitbar(i/num,hw,sprintf('n = %d',n))
	else
		fprintf(' %d', n)
	end

	smtconfig('tpautoeig',0)

	T = smtgallery('gaussian',n,sigma);
	b = T*ones(n,1);
	tic
	for rep = 1:reps
		[~, ~, ~, iter] = pcg(T,b,1e-8,100);
	end
	timtnt(i) = toc/reps;  ittnt(i) = iter;

	smtconfig('tpautoeig',1)

	T = smtgallery('gaussian',n,sigma);
	b = T*ones(n,1);
	tic
	for rep = 1:reps
		[~, ~, ~, iter] = pcg(T,b,1e-8,100);
	end
	timt(i) = toc/reps;  itt(i) = iter;

	if n <= maxn
		A = full(T);
		tic
		for rep = 1:reps
			[~, ~, ~, iter] = pcg(A,b,1e-8,100);
		end
		timf(i) = toc/reps;  itf(i) = iter;
        clear A
	end

	S = smtcprec('strang',T);
	tic
	for rep = 1:reps
		[~, ~, ~, iter] = pcg(T,b,1e-8,100,S);
	end
	timts(i) = toc/reps;  itts(i) = iter;

	O = smtcprec('optimal',T);
	tic
	for rep = 1:reps
		[~, ~, ~, iter] = pcg(T,b,1e-8,100,O);
	end
	timto(i) = toc/reps;  itto(i) = iter;

	SO = smtcprec('superoptimal',T);
	tic
	for rep = 1:reps
		[~, ~, ~, iter] = pcg(T,b,1e-8,100,SO);
	end
	timtt(i) = toc/reps;  ittt(i) = iter;

end

%format short e, [vn itf timf itt timt], [vn itts timts itto timto ittt timtt]
smtconfig( smtstate)
save test4 vn itf timf itt timt itts timts itto timto ittt timtt ittnt timtnt
if graphicoutput,  close(hw),  test4tab,  else,  fprintf('\n'),  end

