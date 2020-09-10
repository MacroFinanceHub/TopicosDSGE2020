clear all;

alpha=1-0.33;

save parameters_mat alpha

dynare RBC01f.mod;

grid_alpha = [0.25:0.20:0.85];
for ii=1:length(grid_alpha)
        alpha=grid_alpha(:,ii);
        save parameters_mat alpha
        dynare RBC01f.mod;
        if info>0
          disp(['El computo falla debido a que  alpha= ' num2str(grid_alpha(:,ii))]);
        end
        respond_y(ii,:) = oo_.irfs.y_e_z;
end

figure('units','normalized','outerposition',[0 0 1 1])
for ii=1:length(grid_alpha)
    dates = (1:1:40)';
    hold on;
    m=plot(dates,respond_y(ii,:)'*100);
    set(m,'Color',[51/255 130/255 (214-(ii-1)*50)/255],'LineWidth',2.5,'LineStyle','-');
    grid on; 
    %xlim([1 40]); 
    %plot([0 40],[0 0],'-k','LineWidth',2)
    hold off;
    if ii>0
        xlabel('Trimestres','Fontsize',14)
    end
    ylabel('Desv. % EE','Fontsize',12)
    legendInfo{ii} = ['\alpha = ' num2str(grid_alpha(ii))];
end
legend(legendInfo);