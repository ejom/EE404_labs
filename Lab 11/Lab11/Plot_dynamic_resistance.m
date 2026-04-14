Temp02 = Vocs/VT_STC;
Iss_STC = Iscs/(exp(Temp02/A_0)-1);
Vpv = [0:0.001: Vocs];
Ipv= double(Iscs-Iss_STC*(exp(Vpv/A_0/VT_STC)-1));
Ppv =Vpv.*Ipv;

Gpvs = Iss_STC/A_0/VT_STC*exp(Vpv/A_0/VT_STC);
Gpv = Gpvs*Np/Ns
Rpv =1./Gpv;

Ind_MPP = find(Ppv >= max(Ppv));
Vmpp_model = Vpv(Ind_MPP);
Impp_model = Ipv(Ind_MPP);
Gpv_mpp_model = Gpv(Ind_MPP);
Rpv_mpp_model=1/Gpv_mpp_model;

V_MPP = num2str(Vmpp_model*Ns,3);
I_MPP = num2str(Impp_model*Np,3);
Gpv_MPP = num2str(Gpv_mpp_model,3);
Rpv_MPP = num2str(Rpv_mpp_model,3);
P_MPP = num2str(Vmpp_model*Impp_model*Ns*Np,4);
Legend_IV_MPP = strcat('MPP ','(',V_MPP,'V,', I_MPP,'A)');
Legend_PV_MPP = strcat('MPP ','(',V_MPP,'V, ', P_MPP,'W)');
Legend_Gpv_MPP = strcat('MPP ','(',V_MPP,'V, ', Gpv_MPP,'S)');
Legend_Rpv_MPP = strcat('MPP ','(',V_MPP,'V, ', Rpv_MPP,'\Omega)');
R = Vmpp_model*Ns/Impp_model/Np;


%%%%%%%%%%%%% plotting------------------------
linewidth = 3;
fontsize = 18;
figure(1)
subplot(4,1,1)
plot(Vpv*Ns, Ipv*Np, Vpv(Ind_MPP)*Ns, Ipv(Ind_MPP)*Np,'sr','linewidth',linewidth)
axis([0 max(Vpv)*Ns 0 max(Ipv)*Np*1.05]);
legend('I-V',Legend_IV_MPP,'fontsize',fontsize)
ylabel('\iti_P_V (A)','fontname','times','fontsize',fontsize)
xlabel('\itv_P_V (V)', 'fontname','times','fontsize',fontsize)
%legend boxoff
grid

set(gca, 'fontname','times','fontsize',fontsize)

subplot(4,1,2)
plot(Vpv*Ns, Ppv*Ns*Np, Vpv(Ind_MPP)*Ns, Ppv(Ind_MPP)*Ns*Np,'sr','linewidth',linewidth)
axis([0 max(Vpv)*Ns 0 max(Ppv)*1.05*Ns*Np]);
legend('P-V',Legend_PV_MPP,'fontsize',fontsize)
ylabel('\itp_P_V (W)','fontname','times','fontsize',fontsize)
xlabel('\itv_P_V (V)', 'fontname','times','fontsize',fontsize)
%legend boxoff
grid

set(gca, 'fontname','times','fontsize',fontsize)

subplot(4,1,3)
plot(Vpv*Ns, Gpv, Vpv(Ind_MPP)*Ns, Gpv(Ind_MPP),'sr','linewidth',linewidth)
 axis([0 max(Vpv)*Ns 0 max(Gpv)*1.05]);
legend('G_P_V',Legend_Gpv_MPP,'fontsize',fontsize)
ylabel('\itG_P_V (W)','fontname','times','fontsize',fontsize)
xlabel('\itv_P_V (V)', 'fontname','times','fontsize',fontsize)
%legend boxoff
grid

set(gca, 'fontname','times','fontsize',fontsize)

subplot(4,1,4)
plot(Vpv*Ns, Rpv, Vpv(Ind_MPP)*Ns, Rpv(Ind_MPP),'sr','linewidth',linewidth)
 axis([0 max(Vpv)*Ns 0 200]);
legend('R_P_V',Legend_Rpv_MPP,'fontsize',fontsize)
ylabel('\itR_P_V (W)','fontname','times','fontsize',fontsize)
xlabel('\itv_P_V (V)', 'fontname','times','fontsize',fontsize)
%legend boxoff
grid

set(gca, 'fontname','times','fontsize',fontsize)

figure(2)
subplot(2,1,1)
plot(Vpv*Ns, Ipv*Np, Vpv(Ind_MPP)*Ns, Ipv(Ind_MPP)*Np,'sr','linewidth',linewidth)
axis([0 max(Vpv)*Ns*1.05 0 max(Ipv)*Np*1.05]);
legend('I-V',Legend_IV_MPP,'fontsize',fontsize)
ylabel('\iti_P_V (A)','fontname','times','fontsize',fontsize)
xlabel('\itv_P_V (V)', 'fontname','times','fontsize',fontsize)
%legend boxoff
grid

set(gca, 'fontname','times','fontsize',fontsize)

subplot(2,1,2)
plot(Vpv*Ns, Ppv*Ns*Np, Vpv(Ind_MPP)*Ns, Ppv(Ind_MPP)*Ns*Np,'sr','linewidth',linewidth)
axis([0 max(Vpv)*Ns*1.05 0 max(Ppv)*1.05*Ns*Np]);
legend('P-V',Legend_PV_MPP,'fontsize',fontsize)
ylabel('\itp_P_V (W)','fontname','times','fontsize',fontsize)
xlabel('\itv_P_V (V)', 'fontname','times','fontsize',fontsize)
%legend boxoff
grid

set(gca, 'fontname','times','fontsize',fontsize)

