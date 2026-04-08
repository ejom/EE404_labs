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
Vmpp_model = Vpv(Ind_MPP)*Ns;              % Vmpp
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

%%%%%%%%%%%%% dynamic model from the state space %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
 I_L_avg = Impp_model/D0;
A00 = [0 D0/L; -D0/Cin 1/Rpv_mpp_model/Cin];
B00 = [(Vmpp_model/L); -I_L_avg/Cin];
C00 = [0 1];
D00 = 0;
G0 = ss(A00, B00, C00, D00);

[Num00, Den00]= ss2tf(A00, B00,C00,D00);
[Wn0,Z0] = damp(G0)

%%%% verification of the transfer function derived in the book
G0_tf = tf([-I_L_avg/Cin -D0*Vmpp_model/L/Cin], [ 1 -1/Rpv_mpp_model/Cin D0^2/L/Cin]);
Wn0_tf = D0/sqrt(L*Cin)
damp0_tf = -1/2/D0/Rpv_mpp_model*sqrt(L/Cin)
K00 =-D0*Vmpp_model/L/Cin
beta0 = I_L_avg*L/D0/Vmpp_model
Wn0_tf*damp0_tf


%%%%%%% controller design %%%%%%%%%%%%%%%%%%%%%
Nf = 10;
alpha0 = 1/damp0_tf/Wn0_tf/Nf

C_fb = tf(Den00, [K00*alpha0*beta0 K00*(alpha0+beta0) 0])

%%% PID controller equivalent
alpha_2 = alpha0 * beta0;
alpha_1 = alpha0 + beta0;

% PID format
Tau_d0 = alpha_2/alpha_1
Ki0 = Wn0(1)^2/K00/alpha_1
Kp0 = (2*Wn0(1)*Z0(1)*alpha_1-Wn0(1)^2*alpha_2)/K00/alpha_1^2
Kd0 = (alpha_1^2-2*Wn0(1)*Z0(1)*alpha_1*alpha_2+Wn0(1)^2*alpha_2^2)/K00/(alpha_1^3)

%%plotting---------------------------------------------------------
fontsize00 = 24; linewidth00 = 3;linewidth01 = 2;

figure(1)
margin(C_fb*G0)

%MPPT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmpp = 2e2;
fmpp_pd = 100;
x_init = round(Voc_array*.95);
delta_x = 1;


%%%%%%%%% Simulation parameters  --------------------------
Ttotal = 4e-1;
Tsample = 1e-5;
