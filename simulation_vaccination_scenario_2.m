clc
clear all
close all

%20-day Stimulation with 2e5 quiescent cancer cells before insertion of
%proliferative
trange1=[0 20];
trange2=[0 100];
cond1=[2e5 2.5e5 5.2e5];
[t_pre_20,y_pre_20]=ode15s(@simul_diff_quiescent,trange1,cond1);
val_20=[y_pre_20(20,1) y_pre_20(20,2) y_pre_20(20,3)];

cond2=[5e4 val_20(2) val_20(3)];
[t_post_20,y_post_20]=ode15s(@simul_diff_proliferative,trange2,cond2);

plot(t_post_20,y_post_20(:,1),'b');
hold on
plot(t_post_20,y_post_20(:,2),'y--');
hold on
plot(t_post_20,y_post_20(:,3),'Color',[0.5, 0, 0.5]);
hold on
grid on

plot(t_pre_20-20,y_pre_20(:,3),'Color',[0.5, 0, 0.5]);

ylabel('Cells number (x10^7)');
xlabel('Time (days after tumor cells inoculation)')
legend('Proliferative tumor cell','NK cell','T cell','Location','northwest');
ylim([0 6e7]);
