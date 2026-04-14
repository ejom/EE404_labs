clear all
close all
clc

%%%%%%%%% PV model constants %%%%%%%%%%%
qk0 =11594;
Tc = 25; 
VT_STC =  (273 + Tc)/qk0; %0.0257
A_0 =1.5762;  % ideality factor

%%%%%%%%%%%% PV module data at STC %%%%%%%%%%%%%%%
Vms = 30.9;
Ims = 8.1;
Vocs = 37.4;
Iscs = 8.7;
Ns = 60;
Np = 1;

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
alpha_T = 0.048/100;
beta_T = -0.32/100;
gamma = -0.0528;

%%%%%%%% PV array parameters --------------------------------
Nss = 12;
P_total = Pmpp*Ns*Np*Nss;   % array power at STC
Vmpp_array = Vmpp *Ns*Nss;  % array voltage at STC    
Impp_array = Impp*Np;   % array current at STC
Voc_array = Vocs * Ns*Nss;  % array open circuit voltage at STC

%%%%%%%%% Inital environmental condition --------------------
Ee = 1000;                 % irradiance = 1000 W/m^2
Tc = 25;                % cell temperature 

%%%%%%%%%%%5 converter parameters ------------------------
Vo_nom = 600;            % nominal output voltage
Fsw = 50e3;             % switching frequency
delta_I_L = Impp_array *.1;          % peak-to-peak inductor current ripple
delta_V_PV = Vmpp_array *0.002;        % peak-to-peak Vpv ripple  
D0 = 1-Vmpp_array/Vo_nom; % duty cycle in STC and nominal output voltage
L = Vmpp_array *D0/delta_I_L/Fsw;       % inductance
Cin0 = delta_I_L/8/delta_V_PV/Fsw % input capacitance
Cin = 3.3e-6 %for implementation.

% %% MPPT parameters ------------------------------
% delta_D = 0.01;     %perturbation size or step size
% D_init = D0*.9;      % first step
% fmpp=100;           % MPPT speed in Hz

%%%%%%%%%%%% inverter parameters ------------------
Fb = 50;        %base frequency is 60Hz

Vmag = 230*sqrt(2); 

Pdc = 6000;
Ppv1 = 3004;
Ppv2 = 2942;
Vdc_ref = 600;
Vdc_rip = 3;
Cdc = Pdc/2/pi/Fb/Vdc_ref/Vdc_rip;
Idc = Pdc/Vdc_ref;
Imag = 2*Pdc/Vmag;
err =Imag*.04;
%err =5;
Fsw_peak = 20e3;
Ton_zero = 1/2/Fsw_peak
Lg = Ton_zero*Vdc_ref/2/err


%Lg = 3e-3;
% 
% Lg = (Vdc_ref-Vmag/2)/Fsw_ref/2/err/2
% Tsw_low = 4*err*Lg/Vdc_ref
Ton_rise = 2*err*Lg/(Vdc_ref-Vmag)
Ton_drop = 2*err*Lg/(Vdc_ref+Vmag)
Fsw_low = 1/(Ton_rise+Ton_drop)


