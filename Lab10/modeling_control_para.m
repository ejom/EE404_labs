clc
close all
Temp02 = Vocs/VT_STC;
Iss_STC = Iscs/(exp(Temp02/A_0)-1);     %saturation current of cell at STC
Vpv = [0:0.002:(Vocs+0.01)];
Ipv= double(Iscs-Iss_STC*(exp(Vpv/A_0/VT_STC)-1));  % produce the cell Ipv according to Vpv series
Ppv =Vpv.*Ipv;              % Ppv of PV cell
Gpvs = -Iss_STC/A_0/VT_STC*exp(Vpv/A_0/VT_STC);      %conductance of cell    
Gpv = Gpvs*Np/Ns/Nss;               %conductance at array level
Rpv =1./Gpv;        %dynamic resistance at array level

Ind_MPP = find(Ppv >= max(Ppv));        %locate MPP
Vmpp_model = Vpv(Ind_MPP)*Ns*Nss;              % Vmpp
Impp_model = Ipv(Ind_MPP)*Np;        
Pmpp_model = Vmpp_model*Impp_model;
Gpv_mpp_model = Gpv(Ind_MPP);
Rpv_mpp_model=1/Gpv_mpp_model;
%%%%%%%%%%%% number to string for plot %%%%%%%%%%%%%%%%55
V_MPP = num2str(Vmpp_model,3);
I_MPP = num2str(Impp_model,3);
P_MPP = num2str(Vmpp_model*Impp_model,4);
Gpv_MPP = num2str(Gpv_mpp_model,3);
Rpv_MPP = num2str(Rpv_mpp_model,3);
Legend_IV_MPP = strcat('MPP ','(',V_MPP,'V,', I_MPP,'A)');
Legend_PV_MPP = strcat('MPP ','(',V_MPP,'V, ', P_MPP,'W)');
Legend_Gpv_MPP = strcat('at MPP ','(',V_MPP,'V, ', Gpv_MPP,'S)');
Legend_Rpv_MPP = strcat('at MPP ','(',V_MPP,'V, ', Rpv_MPP,'\Omega)');

%%%%%%%%%%%%% dynamic model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
A00 = [0 1/L; -1/Cin 1/Rpv_mpp_model/Cin];
B00 = [(Vo_nom/L); 0];
C00 = [0 1];
D00 = 0;
G0 = ss(A00, B00, C00, D00);
% 
[Num00, Den00]= ss2tf(A00, B00,C00,D00)
[Wn,zeta] = damp(G0)

%%%% verification of the transfer function derived in the book
G0_tf = tf([-Vo_nom/L/Cin], [ 1 -1/Rpv_mpp_model/Cin 1/L/Cin])
Wn0_tf = 1/sqrt(L*Cin)
damp0_tf = -1/Rpv_mpp_model/Cin/Wn0_tf/2
K0 =-Vo_nom/L/Cin
DC_gain = K0/Wn0_tf^2
perturb_D = -1/100;
perturb_Vpv = perturb_D * DC_gain
%%%% closed loop design by affine parameterization %%%%%%%%%%%%

Wcl0 = Wn0_tf *4;                       % desired undamped natural frequency in closed loop
damp_cl0 = 0.7;                         % desired damping factor in closed loop
alpha_2 = 1/Wcl0^2                      % alpha2 transformation
alpha_1 = 2*damp_cl0/1/Wcl0             % alpha1 transformation

C_fb = tf(Den00, [K0*alpha_2 K0*alpha_1 0])     %controller

C_fb_z = c2d(C_fb, 1e-6,'tustin')
%margin(C_fb*G0)

%
% Wn0_tf*damp0_tf
% alpha0 = 1/damp0_tf/Wn0_tf/2
% 
% 
Tau_d0 = alpha_2/alpha_1;
Ki0 = Wn0_tf^2/K0/alpha_1;
Kp0 = (2*Wn0_tf*damp0_tf*alpha_1-Wn0_tf^2*alpha_2)/K0/alpha_1^2
Kd0 = (alpha_1^2-2*Wn0_tf*damp0_tf*alpha_1*alpha_2+Wn0_tf^2*alpha_2^2)/K0/(alpha_1^3)


%MPPT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmpp = 2e3;
fmpp_pd = 100;
x_init = round(Voc_array*.9);
delta_x = 1;


%%%%%%%%%%% DC  link modeling and control %%%%%%%%%%%%%%%

K0 = -Vmag/2/Cdc/Vdc_ref %DC gain for the small signal model
Kp = -10;

%%%%%%%%% Simulation parameters  --------------------------
Ttotal = 1e-1;
Tsample = 1/200e3;


%%%%%%%%%%%%%%%%%% relative stability analysis
[re_pid,im_pid]=nyquist(C_fb*G0);
re_pid = squeeze(re_pid);
im_pid = squeeze(im_pid);
T0_pid = feedback(C_fb*G0,1);
S0_pid = 1 - T0_pid;
[mag, phi] = bode(S0_pid);
re_mag = squeeze(mag);
S0_pid_peak = max(re_mag)
S0_pid_peak_dB = 20*log10(S0_pid_peak)
[Gm,Pm,Wcg,Wcp] = margin(C_fb*G0)
W00 = [1:1e4];
[mag00, phi00] = bode(C_fb*G0, W00);
Rmargin = 1/S0_pid_peak
x0 = [-1:0.01:0];
y0 = -sqrt(1-x0.^2);
x1 = [-1:0.01:(-1+Rmargin)];
y1 = -sqrt(Rmargin^2 - (x1+1).^2);
Gain_m = 1/Gm;
x2 = [-Gain_m:Gain_m/10:0];
x3 = -1:0.1:0;
y3 = x3*(tan(Pm*pi/180));

%%%%%% time domain performance %%%%%%%%%%%%%%%%
T0 = feedback(G0_tf*C_fb,1);
stepinfo(T0)

%%plotting---------------------------------------------------------
fontsize00 = 24; linewidth00 = 3;linewidth01 = 2;
margin(C_fb*G0)

figure(2)
plot(re_pid,im_pid,'k',-1, 0, 's', 0,0,'O', 'linewidth',linewidth00)
ylabel('Im','fontsize',fontsize00)
xlabel('Re','fontsize',fontsize00)
%title('Z-N Tuning Results in Freq Domain','fontsize',16)
grid

%legend('C(j\omega)G_0(j\omega)','Critical point (-1, 0)','Origin (0, 0)',3)
set(gca,'xtick',[-1 -.5 0])
set(gca,'ytick',[-1 -.5 0])
hold on
plot(x1,y1,'--',x0,y0,'--',x3,y3,'-.', 'linewidth',linewidth00)

hold off
%legend('Robustness circuit','Unit circle',3)
axis([-1.2 0.2 -1.4 0.2])

legend boxoff
set(gca,'fontname','times','fontsize',fontsize00)

figure(3)
bodemag(S0_pid)
grid
xlabel('Frequency','Units','pixels','FontSize',fontsize00);
ylabel('Magnitude','Units','pixels','FontSize',fontsize00);
title('')
set(gca,'fontsize',fontsize00)