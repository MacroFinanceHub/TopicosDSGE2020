%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%  LAMBDA GROUP %%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%% TOPICOS DSGE - RBC %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Codigo que describe un modelo RBC basico linealizado (expansion de
// Taylor de 1er orden). Las CPO se presentan de forma no lineal.
// El Estado Estacionario es obtenido manualmente.
// La funcion de utilidad corresponde a la forma logaritmica. 
// (c) Carlos Rojas Quiroz 

var lab c w r y kap innv z g;
predetermined_variables kap;
varexo e_z e_g;
parameters alpha delta betta theta rho_z rho_g 
z_ss lab_ss r_ss  kap_ss w_ss y_ss c_ss inv_ss g_ss C_Y I_Y G_Y;

alpha  = 1-0.33;
delta  = 0.023;
betta  = 0.99;
theta  = 1/2.75;
rho_z  = 0.95;
rho_g  = 0.75;
z_ss   = 1;
G_Y    = 0.155;
lab_ss = 1/((1-theta)/(alpha*theta*z_ss)*((1-betta+alpha*betta*delta)/(1-betta+betta*delta)-G_Y)+1);
y_ss   = z_ss*(((1-alpha)*betta/(1-betta+betta*delta))^((1-alpha)/alpha))*lab_ss;
w_ss   = alpha*y_ss/lab_ss;
kap_ss = (1-alpha)*betta/(1-betta+betta*delta)*y_ss;
inv_ss = delta*kap_ss;
r_ss   = (1-alpha)*y_ss/kap_ss-delta;
c_ss   = ((1-betta+alpha*betta*delta)/(1-betta+betta*delta)-G_Y)*y_ss;
g_ss   = G_Y*y_ss;
C_Y    = c_ss/y_ss;
I_Y    = inv_ss/y_ss;

model;
theta/c =(1-theta)/((1-lab)*w);
1/c     =betta*1/c(+1)*(1+r(+1));
w       =alpha*y/lab;
r+delta =(1-alpha)*y/kap;
y       =c+innv+g;
kap(+1) =(1-delta)*kap+innv;
y       =z*kap^(1-alpha)*lab^alpha;
log(z)  =(1-rho_z)*log(z_ss) + rho_z*log(z(-1)) + e_z;
log(g)  =(1-rho_g)*log(g_ss) + rho_g*log(g(-1)) + e_g;
end;

steady_state_model;
lab =lab_ss;
c   =c_ss; 
w   =w_ss; 
r   =r_ss; 
y   =y_ss; 
kap =kap_ss; 
innv=inv_ss; 
z   =z_ss;
g   =g_ss;
end;

shocks;

var e_z; stderr 0.01;
var e_g; stderr 0.01;
end;
 
resid;
steady;
check;

stoch_simul(order = 1, irf=40);