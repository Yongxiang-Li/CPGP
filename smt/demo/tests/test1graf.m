% test1graf

load test1

hh = loglog(vn,[sizf./sizt timsf./timst timpf./timpt]);
set(hh(1),'marker','o')
set(hh(2),'marker','x')
set(hh(3),'marker','*')
%set(hh(1),'linewidth',1.5)
%set(hh(2),'linewidth',1.5)
set(hh(2),'linestyle','--')
set(hh(3),'linestyle','-.')
set(gca,'fontsize',12)
legend('memory saving','sum speedup','product speedup',4)
grid on
grid minor

v2k = 2.^(mink:maxk)';
xlim(v2k([1 end]))
set(gca,'xtick',v2k)
set(gca,'xticklabel',num2str((mink:maxk)'))
xlabel('log of matrix dimension (n=2^k)','fontsize',12)
%ylabel('ratio','fontsize',12)

% print -depsc2 tspdup.eps

