%%%%%%%%%%%% inverter parameters ------------------
Fb = 50;        %base frequency is 60Hz
Vmag = 230*sqrt(2); 
Pdc = 250;
Vdc_ref = 380;
Vdc_rip = 2;
Cdc = Pdc/2/pi/Fb/Vdc_ref/Vdc_rip;
Idc = Pdc/Vdc_ref;
Imag = 2*Pdc/Vmag;
