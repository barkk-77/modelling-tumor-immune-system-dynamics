clc;clear all;close all
trange=[0 35];
ini=[5e4 2.5e5 5.2e5];
[t,y]=ode15s(@simul_diff_proliferative, trange,ini);

yyaxis left
plot(t,y(:,1),'b-');
hold on
ylabel('Tumor cells number (x10^7)')
ylim([0 2.5e7])

yyaxis right
plot(t,y(:,2),'--', 'Color', 'g');
hold on
ylabel('Immune cells number (x10^6)')
ylim([0 10e6])

plot(t,y(:,3),'-*', 'Color', [1, 0.5, 0], 'MarkerSize', 8);
grid on
legend('Proliferative Cells','NK Cells','T Cells')
xlabel('Time (days after tumor cells inoculation)')
xlim([0 35])
