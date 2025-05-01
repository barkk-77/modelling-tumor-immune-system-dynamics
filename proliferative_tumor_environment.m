clc; clear all; close all
% Solve model
trange = [0 35];
ini = [5e4 2.5e5 5.2e5];
[t, y] = ode15s(@simul_diff_proliferative, trange, ini);
Cp = y(:, 1)';
N = y(:, 2)';
T = y(:, 3)';

% Initialisation
len = length(t);
cells_per_cube = 1.5e5;
cells_per_dot = 1e4;
fig = figure('Position', [0, 0, 1920, 1080]);
frames(len) = struct('cdata', [], 'colormap', []);


for i = 1:len
    clf;
    % Compute no. of cubes and dots 
    cubes_Cp=round(Cp(i)/cells_per_cube);
    dots_nk=round(N(i)/cells_per_dot);
    dots_T=round(T(i)/cells_per_dot);

    % Compute all positions of dots around tumor
    total=dots_nk+dots_T;
    r = 6 + exprnd(1.5, 1, total);
    theta = 2 * pi * rand(1, total);
    phi = acos(2*rand(1,total)-1);
    total_xpos = r .* sin(phi) .* cos(theta);
    total_ypos = r .* sin(phi) .* sin(theta);
    total_zpos = r .* cos(phi);

    
    % Plot T-cells
    xposT=total_xpos(1:dots_T);
    yposT=total_ypos(1:dots_T);
    zposT=total_zpos(1:dots_T);
    T_plot=scatter3(xposT,yposT,zposT, 50,[0 0 1],'filled');
    hold on;

    % Plot Proliferative Cells
    Cp_Cubes=grow_cubes([0,0,0],cubes_Cp + randi([-1 1]),[1 0 0]);
    hold on;

    % Plot NK-cells
    xposN = total_xpos( (dots_T+1) : (dots_nk+(dots_T)) );
    yposN = total_ypos( (dots_T+1) : (dots_nk+(dots_T)) );
    zposN = total_zpos( (dots_T+1) : (dots_nk+(dots_T)) );
    N_plot=scatter3(xposN, yposN, zposN, 70, [0.5 0 0.5], 'd', 'filled');
    hold on;


    % Background editing
    set(gca, 'Color', 'k')
    set(gcf, 'Color', 'k')
    set(gca, 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');
    camlight('headlight')
    
    % Placards and Titles
    legend([Cp_Cubes, N_plot, T_plot], {'150x10^3 Proliferative Cells','10x10^3 NK-cells','10x10^3 T-cells'}, ...
    'TextColor', 'w', 'Location', 'northeast', 'FontSize', 12);
    
    string= sprintf('Days since innoculation: %d',round(t(i)));
    dimensions = [0.05 0.88 0.1 0.05];
    annotation('textbox',dimensions,'String',string,'FontSize',16,'FontWeight','bold', ...
        'EdgeColor','w','BackgroundColor','k','Color','w','FitBoxToText','on');
    
    msg = sprintf(['\\color{white}Proliferative Cells: \\color{red}%.1f x10^6\n' ...
                   '\\color{white}NK Cells: \\color{magenta}%.1f x10^6\n' ...
                   '\\color{white}T Cells: \\color{blue}%.1f x10^6'], ...
                   Cp(i)/1e6, N(i)/1e6, T(i)/1e6);
    
    annotation('textbox', [0.05, 0.83, 0.1, 0.05], ...
               'String', msg, ...
               'Interpreter', 'tex', ...
               'FitBoxToText', 'on', ...
               'BackgroundColor', 'k', ...
               'EdgeColor', 'w', ...
               'FontSize', 10, ...
               'FontWeight', 'normal', ...
               'FontName', 'Helvetica');
    title('Proliferative Tumor Growth', 'Color', 'w', 'FontSize', 16, 'FontWeight', 'bold');
    
    % Sizing of axes
    xlim([-8 8])
    ylim([-8 8])
    zlim([-8 8])
    grid on;
     
    % Camera motion
    az = mod(i * 2, 360);                    
    el = 30;                                
    view(az, el);
    frames(i) = getframe(fig);
end

movie(fig,frames,1,10);

movie = VideoWriter('Proliferative Cell Growth Animation','MPEG-4');
movie.FrameRate = 10;
movieFile.Quality=100;

open(movie);
writeVideo(movie,frames);
close(movie);