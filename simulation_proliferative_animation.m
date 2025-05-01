clc; clear all; close all

trange = [0 35];
ini = [5e4 2.5e5 5.2e5];
[t, y] = ode15s(@simul_diff_proliferative, trange, ini);

Cp = y(:, 1);
N = y(:, 2);
T = y(:, 3);
len = length(t);

frames(len) = struct('cdata', [], 'colormap', []);
fig = figure('Position', [0, 0, 1920, 1080]);

for i = 1:len
    clf;

    % Proliferative Cells
    yyaxis left
    plot(t(i), Cp(i), '*','Color','b');
    hold on;
    plot(t(1:i), Cp(1:i), 'b-');
    ylabel('Tumor cells number (x10^7)')
    ylim([0 2.5e7])
    
    % NK cells
    yyaxis right
    plot(t(i), N(i), '*','Color','b');
    hold on;
    plot(t(1:i), N(1:i), '--g');
    ylabel('Immune cells number (x10^6)')
    ylim([0 10e6])
    
    % T-cells
    plot(t(i), T(i), '*', 'Color', [1, 0.5, 0], 'MarkerSize', 8);
    hold on;
    plot(t(1:i), T(1:i), '-*', 'Color', [1, 0.5, 0], 'MarkerSize', 8);
    
    legend('','Proliferative Cells','','NK Cells','','T Cells')
    xlabel('Time (days after tumor cells inoculation)')
    xlim([0 35])
    grid on;

    % Tracker
    msg = sprintf(['Day: %d\n' ...
                   '\\color{black}Proliferative Cells: \\color{blue}%.1f x10^6\n' ...
                   '\\color{black}NK Cells: \\color{green}%.1f x10^6\n' ...
                   '\\color{black}T Cells: \\color[rgb]{1,0.5,0}%.1f x10^6'], ...
                   round(t(i)), Cp(i)/1e6, N(i)/1e6, T(i)/1e6);
    
    annotation('textbox', [0.6, 0.81, 0.2, 0.1], ...
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

movie = VideoWriter('Simulation of Proliferative Tumor Growth (Series 1)','MPEG-4');
movie.FrameRate = 10;
movieFile.Quality=100;

open(movie);
writeVideo(movie,frames);
close(movie);


