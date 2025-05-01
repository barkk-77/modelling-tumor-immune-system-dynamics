clc; close all; clear

% Solve
trange=[0 35];
cond=[5e2 2.5e5 5.2e5];
[t,y]=ode15s(@simul_diff_proliferative, [0 40], cond);

cond_1=[2e3 2.5e5 5.2e5];
[t_1,y_1]=ode15s(@simul_diff_proliferative,[0 40],cond_1);

cond_2=[5e4 2.5e5 5.2e5];
[t_2,y_2]=ode15s(@simul_diff_proliferative,[0 40],cond_2);

cond_3=[1e6 2.5e5 5.2e5];
[t_3,y_3]=ode15s(@simul_diff_proliferative,[0 35],cond_3);

Cp_1= y(:,1);
Cp_2= y_1(:,1);
Cp_3= y_2(:,1);
Cp_4= y_3(:,1);
len = length(t);

frames(len) = struct('cdata', [], 'colormap', []);
fig = figure('Position', [0, 0, 1920, 1080]);

for i=1:len
    clf;
    
    plot(t(i),Cp_1(i),'-','Color','b');
    hold on;
    plot(t(1:i),Cp_1(1:i),'b-');
    hold on

    plot(t_1(i),Cp_2(i),'-','Color','r');
    hold on;
    plot(t_1(1:i),Cp_2(1:i),'r-');
    hold on

    plot(t_2(i),Cp_4(i),'-','Color','y');
    hold on;
    plot(t_2(1:i),Cp_3(1:i),'y-');
    hold on;

    plot(t_3(i),Cp_4(i),'-','Color','[0.5, 0, 0.5]');
    hold on;
    plot(t_3(1:i),Cp_4(1:i),'Color',[0.5, 0, 0.5]);
    
    ylabel('Tumor Cells number (x10^7)')
    xlabel('Time (days after tumor cells inoculation)')
    lgd=legend('','500','','2000','','5x10^4','','1x10^6','Location','northwest');
    title(lgd,'Initial Cell Numbers');
    axis([0 35 0 2e7])
    grid on;

    % Tracker
    msg = sprintf(['\\bfDay: %d\\rm\n' ...
                   '\\color{black}500 initial Cells: \\color{blue}%.1f x10^7\n' ...
                   '\\color{black}2000 initial Cells: \\color{red}%.1f x10^7\n' ...
                   '\\color{black}50,000 initial Cells: \\color{yellow}%.1f x10^7\n' ...
                   '\\color{black}1 million initial Cells: \\color[rgb]{0.5,0,0.5}%.1f x10^7'], ...
                   round(t(i)), Cp_1(i)/1e7, Cp_2(i)/1e7, Cp_3(i)/1e7, Cp_4(i)/1e7);
    
    annotation('textbox', [0.138, 0.69, 0.2, 0.1], ...
               'String', msg, ...
               'Interpreter', 'tex', ...
               'FitBoxToText', 'on', ...
               'BackgroundColor', 'w', ...
               'EdgeColor', 'k', ...
               'FontSize', 10, ...
               'FontWeight', 'normal', ...
               'FontName', 'Helvetica');
    
    frames(i) = getframe(fig);

end
movie(fig,frames,2,10);

movie = VideoWriter('(Varied Ini. Conditions) Simulation of Proliferative Tumor Growth (Series 1)','MPEG-4');
movie.FrameRate = 10;
movieFile.Quality=100;

open(movie);
writeVideo(movie,frames);
close(movie);