clc; close all; clear all

% Solve (Proliferative)
trange=[0 365];
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

% Solve (Quiescent)
cond_qui=[5e4 2.5e5 5.2e5];
[t_qui,y_qui]=ode15s(@simul_diff_quiescent,trange,cond_qui);

Cp_1 = y(:,1);
Cp_2 = y_1(:,1);
Cp_3= y_2(:,1);
Cq=y_qui(:,1);
len = length(t_qui);

frames(len) = struct('cdata', [], 'colormap', []);
fig = figure('Position', [0, 0, 1920, 1080]);

for i=1:len
    clf; 
    
    % Proliferative Cells
    yyaxis left
    plot(t(i), Cp_1(i), '*','Color','b');
    hold on;
    plot(t(1:i),Cp_1(1:i),'b-*');
    hold on

    plot(t_1(i), Cp_2(i), '-','Color','b');
    hold on;
    plot(t_1(1:i),Cp_2(1:i),'b--');
    hold on

    plot(t_2(i), Cp_3(i), ':','Color','b');
    hold on;
    plot(t_2(1:i),Cp_3(1:i),'b:');
    hold on
    ylabel('Proliferative Cells (x10^7)')
    ylim([0 2e7])

    % Quiescent Cells
    yyaxis right
    plot(t_qui(i), Cq(i), 'o','Color',[1,0.5,0]);
    hold on;
    plot(t_qui(1:i),Cq(1:i),'-o','Color',[1,0.5,0]);
    ylabel('Quiescent Cells number (x10^4)')
    ylim([0 8e4])
    
    xlim([0 365])
    xlabel('Time (days after tumor cells inoculation)')
    legend('','Proliferative Cell (9800)','','Proliferative Cell (2000)','','Proliferative Cell (1000)','','Quiescent Cell')
    grid on;

    frames(i) = getframe(fig);
end

movie(fig,frames,2,15);

movie = VideoWriter('Simulation of Heterogeneous Tumor Growth (Series 3)','MPEG-4');
movie.FrameRate = 15;
movieFile.Quality=100;

open(movie);
writeVideo(movie,frames);
close(movie);