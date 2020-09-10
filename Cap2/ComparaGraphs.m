clear all;

dynare RBC01b.mod % Modelo original

varble = {'y','c','innv','lab','w','r','kap','z'}; % Se listan las variables que se quieren graficar
names  ={'PBI','Consumo', 'Inversion','Empleo','Salario real','Tasa de interes','Capital','Productividad'}; % Se nombran cada una de las variables
[nper,junk1] = size(y_e_z); % Importante lo que se coloca como argumento de size()
nvar = length(varble);
dates = (0:1:nper)';

shock  = 'e_z'; % Se escribe el shock de interes
size_shock = 1;
resp_mat1 = []; % Las IRF's se guardan en esta matriz
for ii=1:nvar
    eval(['y1=',char(varble(ii)),'_',char(shock),';']);
    y1= y1*size_shock;
    y1=[0;y1];
    resp_mat1 = [resp_mat1 y1];
end
save('Model01','resp_mat1'); % Guardamos la matriz con el nombre 'Model01'

clear all;

dynare RBC01d.mod % Modelo alternativo

varble = {'y','c','innv','lab','w','r','kap','z'}; % Las mismas variables que antes
names  ={'PBI','Consumo', 'Inversion','Empleo','Salario real','Tasa de interes','Capital','Productividad'};
[nper,junk1] = size(y_e_z); % Lo mismo que antes
nvar = length(varble);
dates = (0:1:nper)';

shock  = 'e_z'; % Se escribe el choque de interes
size_shock = 1;
resp_mat2 = []; % Note que la matriz debe ser distinta a la anterior
for ii=1:nvar
    eval(['y2=',char(varble(ii)),'_',char(shock),';']);
    y2= y2*size_shock;
    y2=[0;y2];
    resp_mat2 = [resp_mat2 y2]; 
end
save('Model02','resp_mat2');  % Guardamos la matriz con el nombre 'Model02'

% Llamamos a nuestros resultados
load Model01
load Model02

% Graficamos 
figure(1)
for ii=1:nvar
    subplot(2,4,ii); % Filas x Columnas debe coincidir con # de variables
    plot(dates,resp_mat1(:,ii),'-r',dates,resp_mat2(:,ii),'--b','LineWidth',2); 
    grid on; xlim([1 nper]);
    hold on; 
    plot([0 nper],[0 0],'-k','LineWidth',2)
    hold off;
    if ii>8 % Si se quiere mostrar una etiqueta en el eje horizontal entonces poner `ii>0'
        xlabel('Trimestres','Fontsize',12)
    end
    ylabel('Desv. EE','Fontsize',12)
    title(names(ii),'Interpreter','none','Fontsize',12);
   if ii==nvar
        legend('L variable','L fijo'); % Leyenda con el mismo orden como se presentan los modelos
   end
end 