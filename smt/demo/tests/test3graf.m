% test3graf

load test3

hh = semilogy(vn,[timt tim2]);
set(hh(1),'marker','.')
set(hh(2),'marker','d')
set(hh(1),'linestyle','none')
set(hh(2),'linestyle','none')
set(gca,'fontsize',12)
legend('tight','next 2^k',4)

v2k = 2.^(mink:maxk)';
xlim(v2k([1 end]))
set(gca,'xtick',v2k)
set(gca,'xticklabel',num2str((mink:maxk)'))
xlabel('log of matrix dimension (n=2^k)','fontsize',12)
ylabel('time (sec)','fontsize',12)

% print -depsc2 tembed.eps

