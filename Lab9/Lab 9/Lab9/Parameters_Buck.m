clear all
close all
clc

%%%%%%%%% PV model constants %%%%%%%%%%%
qk0 =11594;
Tc = 25; 
VT_STC =  (273 + Tc)/qk0; %0.0257
A_0 =1.6882;  % ideality factor

%%%%%%%%%%%% PV module data at STC %%%%%%%%%%%%%%%
Vms = 31.67;
Ims = 8.84;
Vocs = 38.97;
Iscs = 9.41;
Ns = 60;
Np = 3;

%%%%%%%%% PV cell data at STC %%%%%%%%%%%%%%%%
V_OCS = Vocs/Ns;        % open circuit
I_SCS = Iscs/Np;          % short circuit
V_MPP = Vms/Ns; 
I_MPP = Ims/Np ;
P_MPP = V_MPP*I_MPP;

%%%%%%%%%%% PV cell Parameters -------------------------------
Iscs = Iscs;
Impp = Ims/Np ;
Vmpp = Vms/Ns; 
Pmpp = Impp*Vmpp;
Vocs = Vocs/Ns; 

%%%%%%%%%%% temperature coefficient %%%%%%%%%%%%%%%%%%
alpha_T = 0.04/100;
beta_T = -0.29/100;
gamma = -0.04;

%%%%%%%% PV array parameters --------------------------------
Nss = 3;
P_total = Pmpp*Ns*Np*Nss;   % array power at STC
Vmpp_array = Vmpp *Ns*Nss;  % array voltage at STC    
Impp_array = Impp*Np;   % array current at STC
Voc_array = Vocs * Ns*Nss;  % array open circuit voltage at STC

%%%%%%%%% Inital environmental condition --------------------
Ee = 800;                 % irradiance = 1000 W/m^2
Tc = 25;                % cell temperature 

%%%%%%%% battery parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%

P01A = [42.2942  -98.3961   88.7769  -40.3893   10.2942   11.4802];
C_total =  90 * 3600;
C_init = C_total*.8;
I_load =    2.8;        % battery pack has 4 modules in series
 Cbat = 33e-6;
 Rbat = 21.6e-3*4;
 Ilimit = 60;
 Vlimit = 55; 


%%%%%%%%%%% buck converter parameters ------------------------
Vo_nom = 48;            % nominal output voltage
Fsw = 50e3;             % switching frequency
D0 = Vo_nom/Vmpp_array; % duty cycle in STC and nominal output voltage
delta_I_L = Impp_array /D0*.1;          % peak-to-peak inductor current ripple
delta_V_PV = Vmpp_array *0.002;        % peak-to-peak Vpv ripple  
L = Vo_nom *(1-D0)/delta_I_L/Fsw;       % inductance
Cin = Impp_array*(1-D0)/delta_V_PV/Fsw; % input capacitance
L = 470e-6;
Cin = 470e-6;




