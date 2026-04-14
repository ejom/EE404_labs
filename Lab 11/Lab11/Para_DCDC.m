
%%%% converter specification %%%%%%%%%%
n  = 12;                % winding turn raito
Fsw  = 200e3;            % switching frequency
Vo_nom = 380;            % nominal ouput voltage
delta_Vpv = .2;         % ripple voltage of Vpv
delta_i_L = 2;          % ripple current of inductor

%%%% steady state analysis and calculation %%%%%
D0 = 1/(1+Vmpp_array*n/Vo_nom);  %nominal switching duty cycle
L = Vmpp_array*D0/Fsw/delta_i_L; 
Cin = Impp_array*(1-D0)/Fsw/delta_Vpv;

