function out = testsmcirc(op1,op2,tau,n,show)
%TESTSMCIRC performs some tests on smcirc matrices.
%
%   TESTSMCIRC is called by VALIDATE.
%
%   See also VALIDATE.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 21, 2011

if (nargin<5) || isempty(show),  show = 1;  end
if (nargin<4) || isempty(n),  n = 10;  end
if (nargin<3) || isempty(tau),  tau = 1e-8;  end

out = 0;

A = {op1(n,n) op2(n,n) op1(1,1) op2(1,1)};
B = {'A' 'B' 'a' 'b'};

unary = {'+' '-'};
transp = {'''' '.'''};
matop = {'+' '-' '*'};
mpow = {'^'};
dotop = {'.*' './' '.\' '.^'};
divop = {'/' '\'};
funs = {'abs' 'angle' 'ceil' 'conj' 'diff' 'double' 'fix' 'floor' 'imag' ...
	'length' 'max' 'min' 'prod' 'real' 'round' 'sign' 'single' 'size' ...
	'sum'};
isfuns = {'isa' 'isempty' 'isequal' 'isfloat' 'isreal'};
normf = {'norm' 'cond'};
linal = {'det' 'eig' 'inv' 'tril' 'triu' 'diag'};
%special = {'get' 'max' 'min' 'prod' 'reshape' 'sum'};

% unary
for i = 1:numel(unary)
	for j = [1 3]
		strres = eval([unary{i} 'A{j}']);
		fulres = eval([unary{i} 'full(A{j})']);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s%s', unary{i}, B{j});
		if normerr > tau
			fprintf('%s\t\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\t\tok\n', str)
		end
	end
end

% transp
for i = 1:numel(transp)
	for j = [1 3]
		strres = eval(['A{j}' transp{i}]);
		fulres = eval(['full(A{j})' transp{i}]);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s%s', B{j}, transp{i});
		if normerr > tau
			fprintf('%s\t\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\t\tok\n', str)
		end
	end
end

% matop
for i = 1:numel(matop)
	for j = 1:4
	for k = 1:4
		strres = eval(['A{j}' matop{i} 'A{k}']);
		fulres = eval(['full(A{j})' matop{i} 'full(A{k})']);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s %s %s', B{j}, matop{i}, B{k});
		if normerr > tau
			fprintf('%s\t\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\t\tok\n', str)
		end
	end
	end
end

% mpow
for i = 1:numel(mpow)
	for j = 1:2
	for k = 3:4
		strres = eval(['A{j}' mpow{i} 'A{k}']);
		fulres = eval(['full(A{j})' mpow{i} 'full(A{k})']);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s %s %s', B{j}, mpow{i}, B{k});
		if normerr > tau
			fprintf('%s\t\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\t\tok\n', str)
		end
	end
	end
	for j = 3:4
	for k = 1:2
		strres = eval(['A{j}' mpow{i} 'A{k}']);
		fulres = eval(['full(A{j})' mpow{i} 'full(A{k})']);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s %s %s', B{j}, mpow{i}, B{k});
		if normerr > tau
			fprintf('%s\t\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\t\tok\n', str)
		end
	end
	end
end

% dotop
for i = 1:numel(dotop)
	for j = 1:4
	for k = 1:4
		strres = eval(['A{j}' dotop{i} 'A{k}']);
		fulres = eval(['full(A{j})' dotop{i} 'full(A{k})']);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s %s %s', B{j}, dotop{i}, B{k});
		if normerr > tau
			fprintf('%s\t\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\t\tok\n', str)
		end
	end
	end
end

% divop
for i = 1:numel(divop)
	for j = 1:2
	for k = 1:2
		strres = eval(['A{j}' divop{i} 'A{k}']);
		fulres = eval(['full(A{j})' divop{i} 'full(A{k})']);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s %s %s', B{j}, divop{i}, B{k});
		if normerr > tau
			fprintf('%s\t\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\t\tok\n', str)
		end
	end
	end
end

% funs
for i = 1:numel(funs)
	for j = [1 3]
		strres = eval([funs{i} '(A{j})']);
		fulres = eval([funs{i} '(full(A{j}))']);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s(%s)    ', funs{i}, B{j});
		if normerr > tau
			fprintf('%s\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\tok\n', str)
		end
	end
end

% isfuns
for i = 1:numel(isfuns)
	for j = [1 3]
		switch isfuns{i}
		case 'isa'
			strres = eval([isfuns{i} '(A{j},''smcirc'')']);
			fulres = 1;
			str = sprintf('%s(%s,%s)', isfuns{i}, B{j}, B{j});
		case 'isequal'
			strres = eval([isfuns{i} '(A{j},A{j})']);
			fulres = 1;
			str = sprintf('%s(%s,%s)', isfuns{i}, B{j}, B{j});
		otherwise
			strres = eval([isfuns{i} '(A{j})']);
			fulres = eval([isfuns{i} '(full(A{j}))']);
			str = sprintf('%s(%s)    ', isfuns{i}, B{j});
		end
		err = full(strres-fulres);
		normerr = norm(err(:), inf);
		if normerr > tau
			fprintf('%s\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\tok\n', str)
		end
	end
end

% normf
pvet = {'fro', 1, 2, inf};
for i = 1:numel(normf)
	for j = 1:numel(pvet)
		strres = eval([normf{i} '(A{1},pvet{j})']);
		fulres = eval([normf{i} '(full(A{1}),pvet{j})']);
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		if j==1
			str = sprintf('%s(%s,''%s'')', normf{i}, B{1}, pvet{j});
		else
			str = sprintf('%s(%s,%g)', normf{i}, B{1}, pvet{j});
		end
		if normerr > tau
			fprintf('%s\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\tok\n', str)
		end
	end
end

% linal
for i = 1:numel(linal)
	for j = 1
		switch linal{i}
		case 'eig'
			strres = sort(eval([linal{i} '(A{j})']));
			fulres = sort(eval([linal{i} '(full(A{j}))']));
			[V D] = eig(A{j});
			[V1 D1] = eig(full(A{j}));
			err = full(V*D*V'-A{j});
			err = err + full(V1*D1*V1'-full(A{j}));
			strres = strres + norm( err(:), inf);
		case {'tril','triu','diag'}
			strres = eval([linal{i} '(A{j},-1)']);
			fulres = eval([linal{i} '(full(A{j}),-1)']);
		otherwise
			strres = eval([linal{i} '(A{j})']);
			fulres = eval([linal{i} '(full(A{j}))']);
		end
		err = full(strres-fulres);
		normerr = norm(err(:), inf) / norm(fulres(:), inf);
		str = sprintf('%s(%s)    ', linal{i}, B{j});
		if normerr > tau
			fprintf('%s\terr=%g\n', str, normerr)
			out = 1;
		elseif show
			fprintf('%s\tok\n', str)
		end
	end
end

