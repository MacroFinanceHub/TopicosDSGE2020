%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%  LAMBDA GROUP %%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%% TOPICOS DSGE - RBC %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Codigo que describe un modelo RBC basico para economia pequena y abierta
// Las CPO se presentan de forma no lineal.
// El Estado Estacionario es obtenido manualmente.
// Tasa de interes elastica a la deuda.
// (c) Carlos Rojas Quiroz 

var c h y i k a lambda util 
d tb_y ca_y r riskpremium;
predetermined_variables k;
varexo e;                                                                                 
parameters gamma omega rho sigma_tfp delta psi_1 psi_2 alpha phi psi_3 
psi_4 r_bar d_bar beta
h_ss k_ss y_ss i_ss c_ss tb_y_ss util_ss lambda_ss
r_ss; 

%--------------------------------------------------------------------------
%Tabla 1
%--------------------------------------------------------------------------
gamma  = 2;             %Aversion al riesgo
omega  = 1.455;         %Elasticidad de Frisch
psi_1  = 0;             %Elasticidad del factor de descuento
alpha  = 0.32;          %Participacion del capital
phi    = 0.028;         %Costo de ajuste del capital
r_bar  = 0.04;          %Tasa de interes mundial
delta  = 0.1;           %Tasa de depreciacion
rho    = 0.42;          %Autocorrelacion de la PTF
sigma_tfp = 0.0129;     %Desviacion estandar de la PTF
%--------------------------------------------------------------------------
%Tabla 2
%--------------------------------------------------------------------------
psi_2  = 0.000742;
d_bar  = 0.7442;
psi_3  = 0.00074; 
psi_4  = 0;
%--------------------------------------------------------------------------

beta     = 1/(1+r_bar);
r_ss     = (1-beta)/beta;
h_ss     = ((1-alpha)*(alpha/(r_bar+delta))^(alpha/(1-alpha)))^(1/(omega-1));
k_ss     = h_ss/(((r_bar+delta)/alpha)^(1/(1-alpha)));
y_ss     = (k_ss^alpha)*(h_ss^(1-alpha));
i_ss     = delta*k_ss;
c_ss     = y_ss-i_ss-r_bar*d_bar;
tb_y_ss  = 1-((c_ss+i_ss)/y_ss);
util_ss  =(((c_ss-omega^(-1)*h_ss^omega)^(1-gamma))-1)/(1-gamma);
lambda_ss = (c_ss-((h_ss^omega)/omega))^(-gamma);

model;
    //1. Eq. (4), Evolucion de la deuda
    d = (1+exp(r(-1)))*d(-1)- exp(y)+exp(c)+exp(i)+(phi/2)*(exp(k(+1))-exp(k))^2;
    //2. Eq. (5), Funcion de produccion
    exp(y) = exp(a)*(exp(k)^alpha)*(exp(h)^(1-alpha));
    //3. Eq. (6), Ley de Movimiento del capital
    exp(k(+1)) = exp(i)+(1-delta)*exp(k); 
    //4. Eq. (8), Ecuacion de Euler
    exp(lambda)= beta*(1+exp(r))*exp(lambda(+1)); 
    //5. Eq. (9), Definicion de la utilidad marginal
    exp(lambda)=(exp(c)-((exp(h)^omega)/omega))^(-gamma);     
    //7. Eq. (11), CPO r.a. trabajo
    ((exp(c)-(exp(h)^omega)/omega)^(-gamma))*(exp(h)^(omega-1))= exp(lambda)*(1-alpha)*exp(y)/exp(h); 
    //8. Eq. (12), CPO r.a. inversion
    exp(lambda)*(1+phi*(exp(k(+1))-exp(k))) = beta*exp(lambda(+1))*(alpha*exp(y(+1))/exp(k(+1))+1-delta+phi*(exp(k(+2))-exp(k(+1))));     
    //9. Eq. (14), Proceso de la PTF
    a = rho*a(-1)+sigma_tfp*e; 
    //10. Eq. (23), Tasa de interes domestica 
    exp(r) = r_bar+riskpremium;
    //11. p. 171 Definicion del premio al riesgo
    riskpremium = psi_2*(exp(d-d_bar)-1);
    //12. Funcion de utilidad
    util=(((exp(c)-omega^(-1)*exp(h)^omega)^(1-gamma))-1)/(1-gamma);
    //14. p. 169, Definicion del ratio Balanza Comercial/PBI
    tb_y = 1-((exp(c)+exp(i)+(phi/2)*(exp(k(+1))-exp(k))^2)/exp(y));
    //15. p. 169, Definicion del ratio Cuenta Corriente/PBI
    ca_y = (1/exp(y))*(d(-1)-d);                                   
end;

steady_state_model;
    r     = log(r_ss);
    d     = d_bar;
    h     = log(h_ss);
    k     = log(k_ss);
    y     = log(y_ss);
    i     = log(i_ss);
    c     = log(c_ss);
    tb_y  = tb_y_ss;
    util  = util_ss;
    lambda=log(lambda_ss);
    a     = 0;
    ca_y  = 0;
    riskpremium = 0;
end;

shocks; 
var e; stderr 1/sigma_tfp;
end;
  
resid;
steady;
check;

stoch_simul(order = 1, nograph, irf=10);