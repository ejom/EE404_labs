%%%%%%%%%%%%%%%%% batch file to run the complete simulation %%%%%%%%%%%%
clear all
close all
clc
run('System_parameters')
run('modeling_control_para')
tic
sim('Final_simulink')
Simulation_Time = toc
run('Plot_result')
