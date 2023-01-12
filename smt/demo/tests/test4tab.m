% test4tab

load test4

expo = log2(vn);

fprintf('\n\nThe table shows, for each size, iterations n./exec. time\n\n')
fprintf('size     full-nop    smt-nop     smt-str     smt-opt     smt-sopt   autoeig-off\n')
fprintf('-------------------------------------------------------------------------------\n')
for i = 1:size(vn,1)
	fprintf( '2^(%2d)  %2d/%6.2fs  ', expo(i), itf(i), timf(i))
	fprintf( '%2d/%6.2fs  ', itt(i), timt(i))
	fprintf( '%2d/%6.2fs  ', itts(i), timts(i))
	fprintf( '%2d/%6.2fs  ', itto(i), timto(i))
	fprintf( '%2d/%6.2fs  ', ittt(i), timtt(i))
	fprintf( '%2d/%6.2fs\n', ittnt(i), timtnt(i))
end

