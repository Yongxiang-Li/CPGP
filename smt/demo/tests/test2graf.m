% test2graf

load test2

hh = semilogy(vn,[timt timi timtf timif]);
set(hh(1),'marker','x')
set(hh(2),'marker','o')
set(hh(3),'marker','*')
set(hh(4),'marker','s')
set(hh(3),'linewidth',2)
set(hh(4),'linewidth',2)
set(hh(2),'linestyle','--')
set(hh(4),'linestyle','--')
set(gca,'fontsize',12)
legend('smt-MM','inline-MM','smt-MV','inline-MV',4)

v2k = 2.^(mink:maxk)';
xlim(v2k([1 end]))
set(gca,'xtick',v2k)
set(gca,'xticklabel',num2str((mink:maxk)'))
xlabel('log of matrix dimension (n=2^k)','fontsize',12)
ylabel('time (sec)','fontsize',12)

% ylim([.03 40])
% z=num2str([11 14:18]');
% z=[z(1,:);'  ';'  ';z(2:end,:)];
% set(gca,'xticklabel',z)
% print -depsc2 toverh.eps

