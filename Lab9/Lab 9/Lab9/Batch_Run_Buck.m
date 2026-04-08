%%%%%%%%%%%%%%%%% batch file to run the complete simulation %%%%%%%%%%%%
clear all
close all
clc
run('Parameters_Buck.m')
run('Control_Buck.m')
tic
sim('Buck_Charger')
Simulation_Time = toc
run('Plot_Result_Buck.m')
