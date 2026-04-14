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
Nss = 1;
P_total = Pmpp*Ns*Np*Nss;   % array power at STC
Vmpp_array = Vmpp *Ns*Nss;  % array voltage at STC    
Impp_array = Impp*Np;   % array current at STC
Voc_array = Vocs * Ns*Nss;  % array open circuit voltage at STC

%%%%%%%%% Inital environmental condition --------------------
Ee = 1;                 % irradiance = 1000 W/m^2
Tc = 25;                % cell temperature 
