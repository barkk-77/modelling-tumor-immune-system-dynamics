clc
clear all
close all

%Control (no stimulation with quiescent cells)
trange=[0 35];
ini=[5e4 2.5e5 5.2e5];
[t_control,y]=ode15s(@simul_diff_proliferative, trange,ini);

%10-day Stimulation with quiescent cancer cells before insertion of
%proliferative
trange1=[0 10];
trange2=[0 40];
cond1=[5e4 2.5e5 5.2e5];
[t_pre_10,y_pre_10]=ode15s(@simul_diff_quiescent,trange1,cond1);
val_10=[y_pre_10(13,1) y_pre_10(13,2) y_pre_10(13,3)];

cond2=[5e4 val_10(2) val_10(3)];
[t_post_10,y_post_10]=ode15s(@simul_diff_proliferative,trange2,cond2);

Cp_control=y(:,1)';
Cp_post_10=y_post_10(:,1)';
N_control=y(:,2)';
N_post_10=y_post_10(:,2)';
T_control=y(:,3)';
T_post_10=y_post_10(:,3)';
len=length(t_control);

frames(len) = struct('cdata', [], 'colormap', []);
fig = figure('Position', [0, 0, 1920, 1080]);

for i=1:len
    clf;
    
    % Control
    plot(t_control(i),Cp_control(i),'o','Color',[0.5, 0, 0.5]);
    hold on;
    plot(t_control(1:i),Cp_control(1:i),'-o','Color',[0.5, 0, 0.5]);
    hold on;

    plot(t_control(i),N_control(i),'-','Color','g');
    hold on;
    plot(t_control(1:i),N_control(1:i),'--','Color','g');
    hold on;

    plot(t_control(i),T_control(i),'*','Color','b');
    hold on;
    plot(t_control(1:i),T_control(1:i),'-*','Color','b');
    hold on;

    % Post_10
    plot(t_post_10(i),Cp_post_10(i),'-','Color','b');
    hold on;
    plot(t_post_10(1:i),Cp_post_10(1:i),'-o','Color','b');
    hold on;

    plot(t_post_10(i),N_post_10(i),'-','Color','y');
    hold on;
    plot(t_post_10(1:i),N_post_10(1:i),'--','Color','y');
    hold on;

    plot(t_post_10(i),T_post_10(i),'*','Color','y');
    hold on;
    plot(t_post_10(1:i),T_post_10(1:i),'-*','Color','y');

    
    xlim([0 35]);
    ylim([0 2.5e7]);
    ylabel('Cells number (x10^7)');
    xlabel('Time (days after tumor cells inoculation)')
    legend('','Proliferative cell-control','','NK cell-control','','T cell-control','','Proliferative cell-precondition','','NK cell-precondition','','T cell-precondition','Location','northwest');
    grid on;

    frames(i)= getframe(fig);
end
movie(fig,frames,2,12);

movie = VideoWriter('Simulation of aggressive tumor growth delay by 10-day immune preconditioning with dormant cells','MPEG-4');
movie.FrameRate = 12;
movieFile.Quality=100;

open(movie);
writeVideo(movie,frames);
close(movie);

