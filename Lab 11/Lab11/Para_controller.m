
K01 = Num00(3)/Den00(1)         %static gain, zero freq. 
beta0 = Num00(2)/K01


%%%% verification of the transfer function derived in the book
Nf = 8
alpha0 = 1/zeta(1)/Wn(1)/Nf

C_fb = tf(Den00, [K01*alpha0*beta0 K01*(alpha0+beta0) 0])
num2str( C_fb.num{1,1})
num2str( C_fb.den{1,1})
%%% PID controller equivalent
alpha_2 = alpha0 * beta0;
alpha_1 = alpha0 + beta0;

% PID format
Tau_d0 = alpha_2/alpha_1
Ki0 = Wn(1)^2/K01/alpha_1
Kp0 = (2*Wn(1)*zeta(1)*alpha_1-Wn(1)^2*alpha_2)/K01/alpha_1^2
Kd0 = (alpha_1^2-2*Wn(1)*zeta(1)*alpha_1*alpha_2+Wn(1)^2*alpha_2^2)/K01/(alpha_1^3)

%MPPT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fmpp = 2e2;
fmpp_pd = 100;
x_init = round(Voc_array*.9);
delta_x = 0.2;
%margin(C_fb*G0)

%%%%%%%% DC link regulation
Kp = -10;