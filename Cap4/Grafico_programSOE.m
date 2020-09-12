%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%  LAMBDA GROUP %%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%% TOPICOS DSGE - RBC %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%

clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dynare RBC16.mod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'y','c','i','h','tb_y','ca_y'};
names  ={'PBI','Consumo', 'Inversion','Empleo','BC/PBI','CA/Y'};
[nper,junk1] = size(y_e);
nvar = length(varble);
fechas = (0:1:nper)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shock  = 'e';
size_shock = 1;
resp_mat1 = [];
for ii=1:nvar
    eval(['y1=',char(varble(ii)),'_',char(shock),';']);
    y1= y1*size_shock;
    y1=[0;y1];
    resp_mat1 = [resp_mat1 y1];
end
save('Model01','resp_mat1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dynare RBC16a.mod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'y','c','i','h','tb_y','ca_y'};
names  ={'PBI','Consumo', 'Inversion','Empleo','BC/PBI','CA/Y'};
[nper,junk1] = size(y_e);
nvar = length(varble);
fechas = (0:1:nper)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shock  = 'e';
size_shock = 1;
resp_mat2 = [];
for ii=1:nvar
    eval(['y2=',char(varble(ii)),'_',char(shock),';']);
    y2= y2*size_shock;
    y2=[0;y2];
    resp_mat2 = [resp_mat2 y2];
end
save('Model02','resp_mat2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dynare RBC17.mod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'y','c','i','h','tb_y','ca_y'};
names  ={'PBI','Consumo', 'Inversion','Empleo','BC/PBI','CA/Y'};
[nper,junk1] = size(y_e);
nvar = length(varble);
fechas = (0:1:nper)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shock  = 'e';
size_shock = 1;
resp_mat3 = [];
for ii=1:nvar
    eval(['y3=',char(varble(ii)),'_',char(shock),';']);
    y3= y3*size_shock;
    y3=[0;y3];
    resp_mat3 = [resp_mat3 y3];
end
save('Model03','resp_mat3');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dynare RBC18.mod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'y','c','i','h','tb_y','ca_y'};
names  ={'PBI','Consumo', 'Inversion','Empleo','BC/PBI','CA/Y'};
[nper,junk1] = size(y_e);
nvar = length(varble);
fechas = (0:1:nper)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shock  = 'e';
size_shock = 1;
resp_mat4 = [];
for ii=1:nvar
    eval(['y4=',char(varble(ii)),'_',char(shock),';']);
    y4= y4*size_shock;
    y4=[0;y4];
    resp_mat4 = [resp_mat4 y4];
end
save('Model04','resp_mat4');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dynare RBC19.mod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'y','c','i','h','tb_y','ca_y'};
names  ={'PBI','Consumo', 'Inversion','Empleo','BC/PBI','CA/Y'};
[nper,junk1] = size(y_e);
nvar = length(varble);
fechas = (0:1:nper)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shock  = 'e';
size_shock = 1;
resp_mat5 = [];
for ii=1:nvar
    eval(['y5=',char(varble(ii)),'_',char(shock),';']);
    y5= y5*size_shock;
    y5=[0;y5];
    resp_mat5 = [resp_mat5 y5];
end
save('Model05','resp_mat5');

load Model01
load Model02
load Model03
load Model04
load Model05

figure(1)
for ii=1:nvar
    subplot(3,2,ii);
    hold on; 
    mm=plot(fechas,resp_mat1(:,ii));
    set(mm,'Color',[51/255 130/255 214/255],'LineWidth',1.5,'LineStyle','-');
    jj=plot(fechas,resp_mat2(:,ii));
    set(jj,'Color',[237/255 50/255 55/255],'LineWidth',1.5,'LineStyle','--');
    pp=plot(fechas,resp_mat3(:,ii));
    set(pp,'Color',[164/255 94/255 77/255],'LineWidth',1.5,'LineStyle',':');
    nn=plot(fechas,resp_mat4(:,ii));
    set(nn,'Color',[66/255 143/255 93/255],'LineWidth',1.5,'LineStyle','-.');
    bb=plot(fechas,resp_mat5(:,ii));
    set(bb,'Color',[254/255 158/255 50/255],'LineWidth',1.5,'LineStyle','-.');
    plot([0 10],[0 0],'-k','LineWidth',1.5)
    hold off;
    grid on; xlim([1 10]);
    if ii>1
        xlabel('Trimestres','Fontsize',8)
    end
    ylabel('Desv. % EE','Fontsize',8)
    title(names(ii),'Interpreter','none','Fontsize',10);
   if ii==nvar
        legend('EDF','EDF-i','D-EIR','PACM','CASM');
   end
end
