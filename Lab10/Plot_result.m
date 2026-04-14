clc 
close all
Num_total = length(Simout.signals(1,5).values);
ran01 = [(round(Num_total*1/5)): round(Num_total/5*5)];
T001 = Simout.time(ran01)*1e3;
Ppv001 = Simout.signals(1,1).values(ran01);
Ppv002 = Simout.signals(1,2).values(ran01);
Vpv001 = Simout.signals(1,3).values(ran01);
Vpv002 = Simout.signals(1,4).values(ran01);
Ipv001 = Simout.signals(1,5).values(ran01);
Ipv002 = Simout.signals(1,6).values(ran01);

Vgrid = ScopeData.signals(1,1).values(ran01);
Igrid = ScopeData.signals(1,2).values(ran01);
Vdc = ScopeData.signals(1,3).values(ran01);
Imag = ScopeData.signals(1,5).values(ran01);
Pdc = ScopeData.signals(1,6).values(ran01);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linewidth = 2;
fontsize = 24;

figure(1)

subplot(4,1,1)
plot(T001, Ppv001, 'r', T001, Ppv002, '--k', 'linewidth',3)
%legend('String 1','String 2','orientation','horizon','fontsize',fontsize,1)
set(gca, 'fontname','times','fontsize',fontsize)
ylabel('p_{pv} (W)', 'fontname','times','fontsize',fontsize)
grid; box off;
subplot(4,1,2)
plot(T001, Vpv001, 'r', T001, Vpv002, '--k', 'linewidth',3)
%legend('String 1','String 2','orientation','horizon','fontsize',fontsize,1)
set(gca, 'fontname','times','fontsize',fontsize)
ylabel('v_{pv} (V)', 'fontname','times','fontsize',fontsize)
grid; box off;
subplot(4,1,3)
plot(T001, Igrid, 'r', T001, Imag, '--k', T001, -Imag, '--k','linewidth',3)
set(gca, 'fontname','times','fontsize',fontsize)
%legend('i_{grid}','I_{mag}','orientation','horizon',1)
grid; box off;
ylabel('Current (A)', 'fontname','times','fontsize',fontsize)

subplot(4,1,4)
plot(T001, Vdc, 'r', 'linewidth',3)
set(gca, 'fontname','times','fontsize',fontsize)
%legend('v_{dc}','Reference','orientation','horizon',1)
grid; box off;
ylabel('v_{dc}(V)', 'fontname','times','fontsize',fontsize)
xlabel('Time (ms)','fontname','times','fontsize',fontsize)

% 
% subplot(4,1,2)
% plot(T001, Vpv_ref001,'-.r', T001, Vpv001, 'linewidth',3)
% legend('Setpoint','\itv_p_v (V)','orientation','horizon','fontsize',fontsize,4)
% %ylabel('Voltage (V)', 'fontname','times','fontsize',fontsize)
% axis([1.76 4.99 20 43.1])
% set(gca,'ytick',[20 30 37 43])
% set(gca, 'fontname','times','fontsize',fontsize)
% 
% subplot(4,1,3)
% plot(T001, Ppv001, 'linewidth',3)
% legend('\itP_{pv} (W)', 1)
% grid; box off;axis([1.76 4.99 0 301])
% set(gca, 'fontname','times','fontsize',fontsize)
% 
% subplot(4,1,4)
% plot(T001, Duty001*100, 'linewidth',3)
% legend('PWM Duty (%)', 1)
% grid; box off;axis([1.76 4.99 -1 100])
% xlabel('Time (ms)','fontname','times','fontsize',fontsize)
% set(gca, 'fontname','times','fontsize',fontsize)
% 
% xlabel('Time (ms)','fontname','times','fontsize',fontsize)
% ylabel('Duty Cycle (%)', 'fontname','times','fontsize',fontsize)
% axis([max(T002)-5.9 max(T002) D0*100-1 (D0*100+.5)])
% grid; box off;
% %xlabel('Time (ms)','fontname','times','fontsize',fontsize)
% set(gca, 'fontname','times','fontsize',fontsize)

% figure(1)
% subplot(5,1,1)
% plot(T001, D001, 'linewidth',linewidth)
% %legend('I-V',Legend_IV_MPP,'fontsize',fontsize,3)
% %xlabel('Time (s)','fontname','times','fontsize',fontsize)
% ylabel('PWM', 'fontname','times','fontsize',fontsize)
% %legend boxoff
% grid; box off;
% axis tight
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% 
% subplot(5,1,2)
% plot(T001, I_L001, 'linewidth',linewidth)
% %axis([0 max(Vpv)*Ns 0 max(Ppv)*1.05*Ns*Np]);
% 
% ylabel('\iti_L (A)', 'fontname','times','fontsize',fontsize)
% %legend boxoff
% axis tight
% grid; box off;
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% 
% 
% subplot(5,1,3)
% plot(T001, Vpv001, 'linewidth',linewidth)
% axis([min(T001) max(T001) (Vmpp_array-0.15) (Vmpp_array + 0.15)]);
% 
% 

% 
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% subplot(5,1,4)
% plot(T001, Ipv001, 'linewidth',linewidth)
% %axis([0 max(Vpv)*Ns 0 max(Ppv)*1.05*Ns*Np]);
% %xlabel('Time (s)','fontname','times','fontsize',fontsize)
% ylabel('\iti_p_v (A)', 'fontname','times','fontsize',fontsize)
% %legend boxoff
% 
% grid; box off;
% axis tight
% set(gca,'yTick',[(Impp_array-0.01) Impp_array (Impp_array+0.01)])
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% 
% subplot(5,1,5)
% plot(T001, Vpv001.*Ipv001, 'linewidth',linewidth)
% %axis tight
% %axis([0 max(Vpv)*Ns 0 max(Ppv)*1.05*Ns*Np]);
% %xlabel('Time (s)','fontname','times','fontsize',fontsize)
% %ylabel('\itp_p_v (W)', 'fontname','times','fontsize',fontsize)
% 
% legend('\itP_p_v (W)',1); legend boxoff;
% axis([min(T001) max(T001) (Pmpp_model-0.02) (Pmpp_model + 0.03)]);
% grid; box off;
% xlabel('Time (ms)','fontname','times','fontsize',fontsize)
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% 
% figure(2)
% 
% 
% subplot(4,1,1)
% plot(T002, I_L002, 'linewidth',linewidth)
% ylabel('\iti_L (A)', 'fontname','times','fontsize',fontsize)
% grid; box off;
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% 
% 
% subplot(4,1,2)
% plot(T002, Vpv002, 'linewidth',linewidth)
% ylabel('\itv_p_v (V)', 'fontname','times','fontsize',fontsize)
% %legend boxoff
% grid; box off;
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% 
% subplot(4,1,3)
% plot(T002, Ipv002, 'linewidth',linewidth)
% %axis([0 max(Vpv)*Ns 0 max(Ppv)*1.05*Ns*Np]);
% %xlabel('Time (s)','fontname','times','fontsize',fontsize)
% ylabel('\iti_p_v (A)', 'fontname','times','fontsize',fontsize)
% %legend boxoff
% 
% grid; box off;
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% 
% subplot(4,1,4)
% plot(T002, Vpv002.*Ipv002, 'linewidth',linewidth)
% %axis tight
% %axis([0 max(Vpv)*Ns 0 max(Ppv)*1.05*Ns*Np]);
% %xlabel('Time (s)','fontname','times','fontsize',fontsize)
% ylabel('\itp_p_v (W)', 'fontname','times','fontsize',fontsize)
% 
% grid; box off;
% xlabel('Time (ms)','fontname','times','fontsize',fontsize)
% set(gca, 'fontname','times','fontsize',fontsize)
% orient tall
% 
% 
% linewidth = 2;
% fontsize = 32;
% figure(3)
% 
