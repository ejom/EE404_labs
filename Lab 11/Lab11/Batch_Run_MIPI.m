clc
clear
close all

run Para_PV;        %PV parameters
run Para_DCDC;      %converter parameters
run Para_DCAC;
run Para_dynamics;  %dynamic parameters    
run Para_controller; % controller parameter
%%%% simulation parameters %%%%%

Tsample =1e-6
Ttotal = 5e-1;         % total simulation time

%%% run Simulink
tic
sim('MIPI')
Simulation_Time = toc

run('Plot_result.m')


