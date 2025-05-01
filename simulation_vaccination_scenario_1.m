clc
clear all
close all

%Control (no stimulation with quiescent cells)
trange=[0 35];
ini=[5e4 2.5e5 5.2e5];
[t,y]=ode15s(@simul_diff_proliferative, trange,ini);

figure
plot(t,y(:,1),'Color',[0.5, 0, 0.5]);
hold on
plot(t,y(:,2),'g--');
hold on
plot(t,y(:,3),'b-*');
hold on


%10-day Stimulation with quiescent cancer cells before insertion of
%proliferative
trange1=[0 10];
trange2=[0 35];
cond1=[5e4 2.5e5 5.2e5];
[t_pre_10,y_pre_10]=ode15s(@simul_diff_quiescent,trange1,cond1);
val_10=[y_pre_10(13,1) y_pre_10(13,2) y_pre_10(13,3)];

cond2=[5e4 val_10(2) val_10(3)];
[t_post_10,y_post_10]=ode15s(@simul_diff_proliferative,trange2,cond2);

plot(t_post_10,y_post_10(:,1),'b');
hold on
plot(t_post_10,y_post_10(:,2),'y--');
hold on
plot(t_post_10,y_post_10(:,3),'y-*');
grid on

ylabel('Cells number (x10^7)');
xlabel('Time (days after tumor cells inoculation)')
legend('Proliferative cell-control','NK cell-control','T cell-control','Proliferative cell-precondition','NK cell-precondition','T cell-precondition','Location','northwest');
ylim([0 2.5e7]);
