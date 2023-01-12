function result = subsref(T,S)
%SUBSREF Subscripted reference into smtoep objects.
%
%   T(I,J) is an array formed from the elements of T specified
%   by the subscript vectors I and J.  The resulting array has
%   LENGTH(I) rows and LENGTH(J) columns.  A colon used as a
%   subscript, as in T(I,:), indicates the entire column (or 
%   row).
%
%   T.FIELD returns the field value of FIELD for smtoep object
%   T. It is equivalent to get(T,'FIELD').
%
%   See also SMTOEP, SMTOEP/GET.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised January 7, 2011

switch S(1).type
case '.'
% Returns the value of the field S.subs.
	result = get(T,S(1).subs);
case '()'
% Returns the subarray T(i,j) of the Toeplitz matrix T.
	% If user asks for T(:) do the job and exit
	if (size(S(1).subs,2) == 1) && (S(1).subs{1} == ':')
		warning('SMT:subsref:UnstructuredResult',['Result of ' ...
			'subindexing is unstructured'])
		result = reshape(full(T),T.dim1*T.dim2,1);
		return
	% Check for the number of indices (they must be two!).
	elseif (length(S(1).subs) ~= 2)
		error('Uncorrect number of indices.')
	end
	i = S(1).subs{1}(:);
	j = S(1).subs{2}(:);
	% If one of the arguments is a colon, it spans the whole range.
	if i == ':',  i = (1:T.dim1)';  end
	if j == ':',  j = (1:T.dim2)';  end
	% Check consistency of arguments.
	if (min(i)<1) || (max(i)>T.dim1) || (min(j)<1) || (max(j)>T.dim2)
		error('Index exceeds matrix dimensions.')
	end
	li = size(i,1);
	lj = size(j,1);
	% If both arguments are scalar, return the entry T(i,j).
	if (li==1) && (lj==1)
		result = T.t(i-j+T.dim2);
	% If each argument is an interval of indices, the result is smtoep.
	elseif all(i==i(1)+(0:li-1)') && all(j==j(1)+(0:lj-1)')
		result = smtoep(T.t(i(1)-j(lj)+T.dim2:i(li)-j(1)+T.dim2),li,lj);
		% If an argument is a scalar, return a full vector.
		if (li==1) || (lj==1)
			result = full(result);
		end
	else
	% In the general case the result is full.
		warning('SMT:subsref:UnstructuredResult',['Result of ' ...
			'subindexing is unstructured'])
		i1 = (min(i):max(i))';
		j1 = (min(j):max(j))';
		li = size(i1,1);
		lj = size(j1,1);
		result = smtoep(T.t(i1(1)-j1(lj)+T.dim2:i1(li)-j1(1)+T.dim2),li,lj);
		result = full(result);
		result = result(i-i1(1)+1,j-j1(1)+1);
	end

end

if length(S) > 1
	result = subsref(result,S(2:end));
end

