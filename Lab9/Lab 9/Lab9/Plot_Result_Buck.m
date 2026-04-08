clc 

load data

T001 = ans.time;
Var01 = ans.data(:,1);
Var02 = ans.data(:,2);
Var03 = ans.data(:,3);
Var04 = ans.data(:,4);
Var05 = ans.data(:,5);
Var06 = ans.data(:,6);
Var07 = ans.data(:,7);

fontsize =24;

figure(1)
subplot(5,1,1)
plot(T001, Var03, 'linewidth',3)
set(gca, 'fontname','times','fontsize',fontsize)
legend('v_{pv} (V)', 'NorthEast')
grid; box off; axis([0.005 Ttotal 91 121])

subplot(5,1,2)
plot(T001, Var01, 'linewidth',3)
set(gca, 'fontname','times','fontsize',fontsize)
legend('p_{pv} (W)', 'SouthEast')
grid; box off;axis([0.005 Ttotal 500 3000])

subplot(5,1,3)
plot(T001, Var02, 'linewidth',3)
set(gca, 'fontname','times','fontsize',fontsize)
legend('V_{bat} (V)', 'SouthEast')
grid; box off;axis([0.005 Ttotal 51 56])

subplot(5,1,4)
plot(T001, Var07, 'linewidth',3)
set(gca, 'fontname','times','fontsize',fontsize)
legend('I_{bat} (A)', 'NorthEast')
grid; box off;axis([0.005 Ttotal min(Var07) 0])

subplot(5,1,5)
plot(T001, Var06*100, 'linewidth',3)
set(gca, 'fontname','times','fontsize',fontsize)
legend('SOC (%)', 'SouthEast')
grid; box off;axis([0.005 Ttotal min(Var06*100) max(Var06*100)])
xlabel('Time (s)','fontname','times','fontsize',fontsize)
