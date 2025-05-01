clc
close all
clear
trange=[0,365];
cond=[5e4 2.5e5 5.2e5];
[t,y]=ode15s(@simul_diff_quiescent,trange,cond);

figure
yyaxis left
plot(t,y(:,1),'b-o')
ylabel('Tumor Cells number (x10^4)')
ylim([0 6e4])

hold on
yyaxis right
ylabel('Immune Cells number (x10^6)')
plot(t,y(:,2),'g--')
hold on
plot(t,y(:,3),'-*', 'Color', [1, 0.5, 0], 'MarkerSize', 8)
hold on
ylim([0 3e6])
xlim([0 365])
legend("Quiescient Cells","NK cells","T Cells")
xlabel('Time (days after tumor cells inoculation)')
grid on