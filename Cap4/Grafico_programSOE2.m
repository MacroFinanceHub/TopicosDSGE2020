%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%  LAMBDA GROUP %%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%% TOPICOS DSGE - RBC %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%

clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dynare RBC21_Mex.mod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'nx', 'c_y_percentage', 'i_y_percentage'};
names  ={'Exportaciones netas/PBI','Consumo/PBI', 'Inversion/PBI'};
[nper,junk1] = size(y_eps_z);
nvar = length(varble);
fechas = (0:1:nper)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shock  = 'eps_z';
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
dynare RBC21_Mex.mod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
varble = {'nx', 'c_y_percentage', 'i_y_percentage'};
names  ={'Exportaciones netas/PBI','Consumo/PBI', 'Inversion/PBI'};
[nper,junk1] = size(y_eps_z);
nvar = length(varble);
fechas = (0:1:nper)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shock  = 'eps_g';
size_shock = 1;
resp_mat2 = [];
for ii=1:nvar
    eval(['y2=',char(varble(ii)),'_',char(shock),';']);
    y2= y2*size_shock;
    y2=[0;y2];
    resp_mat2 = [resp_mat2 y2];
end
save('Model02','resp_mat2');

load Model01
load Model02

figure(1)
for ii=1:nvar
    subplot(3,1,ii);
    hold on; 
    mm=plot(fechas,resp_mat1(:,ii));
    set(mm,'Color',[51/255 130/255 214/255],'LineWidth',1.5,'LineStyle','--');
    jj=plot(fechas,resp_mat2(:,ii));
    set(jj,'Color',[237/255 50/255 55/255],'LineWidth',1.5,'LineStyle','-');
    plot([0 26],[0 0],'-k','LineWidth',1.5)
    hold off;
    grid on; xlim([1 26]);
    if ii>1
        xlabel('Trimestres','Fontsize',8)
    end
    ylabel('Desv. % EE','Fontsize',8)
    title(names(ii),'Interpreter','none','Fontsize',10);
   if ii==nvar
        legend('Choque transitorio','Choque permanente');
   end
end