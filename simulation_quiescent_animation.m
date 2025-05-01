clc; clear all; close all

trange=[0,365];
cond=[5e4 2.5e5 5.2e5];
[t,y]=ode15s(@simul_diff_quiescent,trange,cond);

Cq = y(:, 1);
N = y(:, 2);
T = y(:, 3);
len = length(t);

frames(len) = struct('cdata', [], 'colormap', []);

fig = figure('Position', [0, 0, 1920, 1080]);
for i = 1:len
    clf;
    
    % Quiescient Cells
    yyaxis left
    plot(t(i), Cq(i), 'o','Color','b');
    hold on;
    plot(t(1:i), Cq(1:i), 'b-o');
    ylabel('Tumor cells number (x10^4)')
    ylim([0 6e4])
    
    % NK cells
    yyaxis right
    plot(t(i), N(i), '-','Color','g');
    hold on;
    plot(t(1:i), N(1:i), '--g');
    ylabel('Immune cells number (x10^6)')
    ylim([0 3e6])
    
    % T-cells
    plot(t(i), T(i), '*', 'Color', [1, 0.5, 0], 'MarkerSize', 8);
    hold on;
    plot(t(1:i), T(1:i), '-*', 'Color', [1, 0.5, 0], 'MarkerSize', 8);
    
    legend('','Quiescent Cells','','NK Cells','','T Cells')
    xlabel('Time (days after tumor cells inoculation)')
    xlim([0 365])
    grid on;
    
    % Tracker
    msg = sprintf(['Day: %d\n' ...
                   '\\color{black}Quiescent Cells: \\color{blue}%.1f x10^3\n' ...
                   '\\color{black}NK Cells: \\color{green}%.1f x10^6\n' ...
                   '\\color{black}T Cells: \\color[rgb]{1,0.5,0}%.1f x10^6'], ...
                   round(t(i)), Cq(i)/1e3, N(i)/1e6, T(i)/1e6);
    
    annotation('textbox', [0.675, 0.81, 0.2, 0.1], ...
               'String', msg, ...
               'Interpreter', 'tex', ...
               'FitBoxToText', 'on', ...
               'BackgroundColor', 'w', ...
               'EdgeColor', 'k', ...
               'FontSize', 10, ...
               'FontWeight', 'normal', ...
               'FontName', 'Helvetica')

    frames(i) = getframe(fig);
end
movie(fig,frames,2,15);

movie = VideoWriter('Simulation of Quiescent Tumor Growth (Series 2)','MPEG-4');
movie.FrameRate = 15;
movieFile.Quality=100;

open(movie);
writeVideo(movie,frames);
close(movie);