clc
clear all
close all

trange1=[0 7];
trange2=[0 63];

%7 days before inoculation of quiescent cells
cond1=[5e4 2.5e5 5.2e5];
[t_for_7,y_for_7]=ode15s(@simul_diff_proliferative,trange1,cond1);
val_7=[y_for_7(16,1) y_for_7(16,2) y_for_7(16,3)];

plot(t_for_7,y_for_7(:,1),'b');
hold on
plot(t_for_7,y_for_7(:,2),'y');
hold on
plot(t_for_7,y_for_7(:,3),'Color',[0.5, 0, 0.5]);
hold on

%After inoculation of quiescent cells
cond2=[val_7(1) 2e6 val_7(2) val_7(3)];
[t_post_7,y_post_7]=ode15s(@simul_diff_hetero_growth,trange2,cond2);

plot(t_post_7+7,y_post_7(:,1),'b');
hold on
plot(t_post_7+7,y_post_7(:,2),'r');
hold on
plot(t_post_7+7,y_post_7(:,3),'y');
hold on
plot(t_post_7+7,y_post_7(:,4),'Color',[0.5, 0, 0.5]);
hold on
grid on

%Continuity Correction
plot([0 7], [0 0], 'r');
hold on
plot([7 7], [0 2e6], 'r');

%Formating 
xticks(sort(unique([get(gca, 'XTick'), 7])));
ylabel('Cells number (x10^6)');
xlabel('Time (days after tumor cells inoculation)')
legend('Proliferative tumor cell','NK cell','T cell','','Quiescent Tumor Cell','Location','northwest');
ylim([0 10e6]);
