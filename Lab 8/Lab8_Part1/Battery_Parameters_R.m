clear all

clc

D10A = csvread('D10A.csv');
D20A = csvread('D20A.csv');
D30A = csvread('D30A.csv');
D100A = csvread('D100A.csv');

C_nom = 90;
C_total = C_nom*3600;
C_init = C_total*.8;

Rbat = (D10A(5,2)-D20A(5,2))/10
D00A(:,1) = D10A(:,1);
D00A(:,2) = D20A(:,2)+Rbat*20


%%%%%%%%%%%%%%%% curve fitting based on discharged capacity %%%%%%%%%%%
[P00A S00A] = polyfit(D00A(:,1), D00A(:,2),5);          

%  p1 = -1.6284e-011
%   p2 = -7.3659e-010
%   p3 = 7.7148e-007
%   p4 = -9.6158e-005
%   p5 = 0.0051104
%   p6 = -0.12637
%   p7 = 14.038
Ah00A = [0:90];
Voc00A = P00A(1)*Ah00A.^5+P00A(2)*Ah00A.^4+P00A(3)*Ah00A.^3+P00A(4)*Ah00A.^2+P00A(5)*Ah00A + P00A(6);

Voc10A = Voc00A - Rbat*10;
Voc20A = Voc00A - Rbat*20;
Voc30A = Voc00A - Rbat*30;
Voc100A = Voc00A - Rbat*100;
figure(1)
plot(Ah00A, Voc00A,'g-.', Ah00A,Voc10A,'--k', Ah00A,Voc20A,'-.b',Ah00A,Voc30A,'c',Ah00A,Voc100A,':r',D10A(:,1),D10A(:,2),'hk',D20A(:,1),D20A(:,2),'ob',D30A(:,1),D30A(:,2),'cs' ,D100A(:,1),D100A(:,2),'^r','linewidth',4)
axis([0 91 7 15])
xlabel('Discharged Capacity C_{dis} (Ah)','fontsize',32,'fontname','Times')
ylabel('\itV_{bat} (V)','fontsize',32,'fontname','Times')
%legend('0A','10A','20A','30A','100A',3); legend boxoff
set(gca,'fontsize',32,'fontname','Times')

%%%%%%%%%%%%%%%%% curve fitting based on SOC %%%%%%%%%%%%%%

SOC01A = (C_nom - D10A(:,1))/C_nom;
[P01A S01A] = polyfit(SOC01A(:,1), D00A(:,2),5);  
num2str(P01A)
Ah01A = [0:5e-2:1];
Voc01A = P01A(1)*Ah01A.^5+P01A(2)*Ah01A.^4+P01A(3)*Ah01A.^3+P01A(4)*Ah01A.^2+P01A(5)*Ah01A + P01A(6);

figure(2)
plot(SOC01A*100, D00A(:,2),'sR', Ah01A*100, Voc01A,'k-','linewidth',4)
axis([1 99 7 15])
xlabel('SOC (%)','fontsize',32,'fontname','Times')
ylabel('\itV_{OC} (V)','fontsize',32,'fontname','Times')
%legend('Derived from datasheet','Polynomial Model',4); legend boxoff
set(gca,'fontsize',32,'fontname','Times')


%%%%%%%%%%%%%%%%%%simulation para %%%%%%%%%%%%%%%%%%

Ttotal = 3600*4;
Tsample =1;


