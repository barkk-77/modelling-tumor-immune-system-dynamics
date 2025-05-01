clc
clear all
close all

%7 days before inoculation of quiescent cells
trange1=[0 7];
cond1=[5e4 2.5e5 5.2e5];
[t_for_7,y_for_7]=ode15s(@simul_diff_proliferative,trange1,cond1);
val_7=[y_for_7(16,1) y_for_7(16,2) y_for_7(16,3)];

plot(t_for_7,y_for_7(:,1),'b');
hold on
plot(t_for_7,y_for_7(:,2),'y');
hold on
plot(t_for_7,y_for_7(:,3),'Color',[0.5, 0, 0.5]);
hold on

%7 days before second inoculation of quiescent cells
trange2=[0 7];
cond2=[val_7(1) 1e6 val_7(2) val_7(3)];
[t_post_7,y_post_7]=ode15s(@simul_diff_hetero_growth,trange2,cond2);
val_14=[y_post_7(15,1) y_post_7(15,2) y_post_7(15,3) y_post_7(15,4)];

plot(t_post_7+7,y_post_7(:,1),'b');
hold on
plot(t_post_7+7,y_post_7(:,2),'r');
hold on
plot(t_post_7+7,y_post_7(:,3),'y');
hold on
plot(t_post_7+7,y_post_7(:,4),'Color',[0.5, 0, 0.5]);
hold on

%After second inoculation of quiescent cells
trange3=[0 56];
cond3=[val_14(1) (val_14(2)+1e6) val_14(3) val_14(4)];
[t_post_14,y_post_14]=ode15s(@simul_diff_hetero_growth,trange3,cond3);

plot(t_post_14+14,y_post_14(:,1),'b');
hold on
plot(t_post_14+14,y_post_14(:,2),'r');
hold on
plot(t_post_14+14,y_post_14(:,3),'y');
hold on
plot(t_post_14+14,y_post_14(:,4),'Color',[0.5, 0, 0.5]);
hold on


% Continuity correction
plot([0 7], [0 0], 'r');
hold on
plot([7 7], [0 1e6],'r');
hold on
plot([14 14], [val_14(2) (val_14(2)+1e6)], 'r');

% Formatting
grid on
xticks(sort(unique([get(gca, 'XTick'), 7])));
xticks(sort(unique([get(gca, 'XTick'), 14])));

ylabel('Cells number (x10^6)');
xlabel('Time (days after tumor cells inoculation)')
legend('Proliferative tumor cell','NK cell','T cell','','Quiescent Tumor Cell','Location','northwest');
ylim([0 10e6]);
