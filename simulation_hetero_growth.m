clc
close all
trange=[0 365];

% Proliferative cells
f=9800;
z=5e4-f;
cond=[f z 2.5e5 5.2e5];
[t,y]=ode15s(@simul_diff_hetero_growth,trange,cond);

f_1=2000;
z_1=5e4-(f_1);
cond_1=[f_1 z_1 2.5e5 5.2e5];
[t_1,y_1]=ode15s(@simul_diff_hetero_growth,trange,cond_1);

f_2=1000;
z_2=5e4-(f_2);
cond_2=[f_2 z_2 2.5e5 5.2e5];
[t_2,y_2]=ode15s(@simul_diff_hetero_growth,trange,cond_2);

% f_3=800;
% z_3=5e4-(f_3);
% cond_3=[f_3 z_3 2.5e5 5.2e5];
% [t_3,y_3]=ode15s(@simul_diff_hetero_growth,trange,cond_3);

figure
yyaxis left
plot(t,y(:,1),'b');
hold on
plot(t_1,y_1(:,1),'b--');
hold on
plot(t_2,y_2(:,1),'b:');
% hold on
% plot(t_3,y_3(:,1),'b-o');
% hold on
ylabel('Proliferative Cells (x10^7)')
ylim([0 2e7])


% Quiescent cells
cond_qui=[5e4 2.5e5 5.2e5];
[t_qui,y_qui]=ode15s(@simul_diff_quiescent,trange,cond_qui);

yyaxis right
plot(t_qui,y_qui(:,1),'-o','Color', [1, 0.5, 0]);
ylabel('Quiescent Cells number (x10^4)')
ylim([0 8e4])

xlim([0 365])
xlabel('Time (days after tumor cells inoculation)')
legend('Proliferative Cell (9800)' ,'Proliferative Cell (2000)', 'Proliferative Cell (1000)','Quiescent Cell')
grid on
