clc
close all
Temp02 = Vocs/VT_STC;
Iss_STC = Iscs/(exp(Temp02/A_0)-1);     %saturation current of cell at STC
Vpv = [0:0.002:(Vocs+0.01)];
Ipv= double(Iscs-Iss_STC*(exp(Vpv/A_0/VT_STC)-1));  % produce the cell Ipv according to Vpv series
Ppv =Vpv.*Ipv;              % Ppv of PV cell
Gpvs = -Iss_STC/A_0/VT_STC*exp(Vpv/A_0/VT_STC);      %conductance of cell    
Gpv = Gpvs*Np/Ns;               %conductance at array level
Rpv =1./Gpv;        %dynamic resistance at array level

Ind_MPP = find(Ppv >= max(Ppv));        %locate MPP
Vmpp_model = Vpv(Ind_MPP)*Ns;              % Vmpp of array model
Impp_model = Ipv(Ind_MPP)*Np;              % Impp of array model
Gpv_mpp_model = Gpv(Ind_MPP);
Rpv_mpp_model=1/Gpv_mpp_model;
%%%%%%%%%%%% number to string for plot %%%%%%%%%%%%%%%%55
V_MPP = num2str(Vmpp_model,3);
I_MPP = num2str(Impp_model*Np,3);
P_MPP = num2str(Vmpp_model*Impp_model,4);
Gpv_MPP = num2str(Gpv_mpp_model,3);
Rpv_MPP = num2str(Rpv_mpp_model,3);
Legend_IV_MPP = strcat('MPP ','(',V_MPP,'V,', I_MPP,'A)');
Legend_PV_MPP = strcat('MPP ','(',V_MPP,'V, ', P_MPP,'W)');
Legend_Gpv_MPP = strcat('at MPP ','(',V_MPP,'V, ', Gpv_MPP,'S)');
Legend_Rpv_MPP = strcat('at MPP ','(',V_MPP,'V, ', Rpv_MPP,'\Omega)');

%%%%%%%%%%%%% dynamic model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
I_L_avg = Impp_model/(1-D0);
A00 = [0 D0/L; -D0/Cin 1/Rpv_mpp_model/Cin];
B00 = [(Vmpp_model+Vo_nom/n)/L; -I_L_avg/Cin];
C00 = [0 1];
D00 = 0;
G0 = ss(A00, B00, C00, D00);

[Num00, Den00]= ss2tf(A00, B00,C00,D00);
[Wn,zeta] = damp(G0)
num2str(Num00)
num2str(Den00)

