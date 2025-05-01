clc
close all
clear
trange=[0 35];
cond=[5e2 2.5e5 5.2e5];
[t,y]=ode15s(@simul_diff_proliferative, trange, cond);

cond_1=[2e3 2.5e5 5.2e5];
[t_1,y_1]=ode15s(@simul_diff_proliferative,trange,cond_1);

cond_2=[5e4 2.5e5 5.2e5];
[t_2,y_2]=ode15s(@simul_diff_proliferative,trange,cond_2);

cond_3=[1e6 2.5e5 5.2e5];
[t_3,y_3]=ode15s(@simul_diff_proliferative,trange,cond_3);

figure
plot(t,y(:,1),'b-')
hold on
plot(t_1,y_1(:,1),'r-')
hold on
plot(t_2,y_2(:,1),'y-')
hold on
plot(t_3,y_3(:,1),'Color',[0.5, 0, 0.5])

ylabel('Tumor Cells number (x10^7)')
xlabel('Time (days after tumor cells inoculation)')
lgd=legend('500','2000','5x10^4','1x10^6','Location','northwest');
title(lgd,'Initial Cell Numbers');
axis([0 35 0 2e7])
grid on