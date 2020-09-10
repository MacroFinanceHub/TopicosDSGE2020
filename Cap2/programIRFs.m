clc;
close all;
clear all;
dynare RBC01a.mod
save('y_e_z_1.mat','y_e_z')
dynare RBC01c.mod
save('y_e_z_2.mat','y_e_z')
close all;
clear all;
figure(1)
subplot(1,2,1)
load('y_e_z_1.mat')
plot(y_e_z)
load('y_e_z_2.mat')
hold on;
plot(y_e_z)
hold off;
subplot(1,2,2)
load('y_e_z_1.mat')
plot(y_e_z)
load('y_e_z_2.mat')
hold on;
plot(y_e_z/1.19)
hold off;
legend('log-linealizado','linealizado')