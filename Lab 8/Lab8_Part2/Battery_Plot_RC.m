close all
clc

T001 = ScopeData.time;
Vbat001 = ScopeData.signals(1,1).values;
SOC001= ScopeData.signals(1,2).values;
Ibat001= ScopeData.signals(1,3).values;
% 
subplot(3,1,1)
 plot(T001, Ibat001,'linewidth',4)
 axis([.1 Ttotal -0.1 34])

ylabel('\itI_{bat} (A)','fontsize',32,'fontname','Times')
set(gca,'fontsize',32,'fontname','Times')
box off; grid

subplot(3,1,2)
 plot(T001, Vbat001,'linewidth',4)
axis([.1 Ttotal 11.6 13.3])

ylabel('\itV_{bat} (V)','fontsize',32,'fontname','Times')
set(gca,'fontsize',32,'fontname','Times')
box off; grid

subplot(3,1,3)
 plot(T001, SOC001*100,'linewidth',4)
 axis([.1 Ttotal 79.66 80.001])
xlabel('Time (s)','fontsize',32,'fontname','Times')
ylabel('SOC (%)','fontsize',32,'fontname','Times')
set(gca,'fontsize',32,'fontname','Times')
box off; grid

