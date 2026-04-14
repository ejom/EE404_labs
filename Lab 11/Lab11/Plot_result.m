clc 


Num_total = length(simout.time);
ran01 = [(round(Num_total/4)+6): (Num_total-10)];
T001 = simout.time(ran01)*1e3;
Igrid_0106 = simout.signals(1,1).values(ran01);
Igrid_0712 = simout.signals(1,2).values(ran01);
Igrid_1318 = simout.signals(1,3).values(ran01);
Igrid_1924 = simout.signals(1,4).values(ran01);

Ee_0106 = simout1.signals(1,1).values(ran01);
Ee_0712 = simout1.signals(1,2).values(ran01);
Ee_1318 = simout1.signals(1,3).values(ran01);
Ee_1924 = simout1.signals(1,4).values(ran01);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fontsize = 24;

figure(1)

subplot(4,1,1)
plot( T001, Ee_0106,'--k',T001, Igrid_0106,'r','linewidth',4)
legend('Ee (kW/m^2)','i_{grid} (A)')
grid; box off;;axis tight
set(gca, 'fontname','times','fontsize',fontsize)

subplot(4,1,2)
plot( T001, Ee_0712,'--k',T001, Igrid_0712,'r','linewidth',4)
legend('Ee (kW/m^2)','i_{grid} (A)')
grid; box off;;axis tight
set(gca, 'fontname','times','fontsize',fontsize)

subplot(4,1,3)
plot( T001, Ee_1318,'--k',T001, Igrid_1318,'r','linewidth',4)
legend('Ee (kW/m^2)','i_{grid} (A)')
grid; box off;;axis tight
set(gca, 'fontname','times','fontsize',fontsize)

subplot(4,1,4)
plot( T001, Ee_1924,'--k',T001, Igrid_1924,'r','linewidth',4)
legend('Ee (kW/m^2)','i_{grid} (A)')
grid; box off;;axis tight
set(gca, 'fontname','times','fontsize',fontsize)
xlabel('Time (ms)','fontname','times','fontsize',fontsize)