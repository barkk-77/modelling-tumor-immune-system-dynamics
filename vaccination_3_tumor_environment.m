clc;clear all; close all

% Solve DE
trange1=[0 7];
trange2=[0 63];

%7 days before inoculation of quiescent cells
cond1=[5e4 2.5e5 5.2e5];
[t_for_7,y_for_7]=ode15s(@simul_diff_proliferative,trange1,cond1);
val_7=[y_for_7(16,1) y_for_7(16,2) y_for_7(16,3)];

%After inoculation of quiescent cells
cond2=[val_7(1) 2e6 val_7(2) val_7(3)];
[t_post_7,y_post_7]=ode15s(@simul_diff_hetero_growth,trange2,cond2);

t=[t_for_7',(t_post_7'+7)];
Cp=[y_for_7(:,1)',y_post_7(:,1)'];
Cq=[zeros(1,length(y_for_7(:,1)')),y_post_7(:,2)'];
N=[y_for_7(:,2)',y_post_7(:,3)'];
T=[y_for_7(:,3)',y_post_7(:,4)'];

% Initialisation
len = length(t);
cells_per_cube = 1e4;
cells_per_dot = 5e4;
fig = figure('Position', [0, 0, 3840, 2160]);
frames(len) = struct('cdata', [], 'colormap', []);


for i = 1:len
    clf;

    % Compute no. of cubes and dots
    cubes_Cp=round(Cp(i)/cells_per_cube);
    cubes_Cq=round(Cq(i)/cells_per_cube);
    dots_nk=round(N(i)/cells_per_dot);
    dots_T=round(T(i)/cells_per_dot);
    
    % Spread immune cells proportionally
    total_cubes=cubes_Cq+cubes_Cp;  
    if cubes_Cq==0
        T_Cp=dots_T;
        nk_Cp=dots_nk;
        T_Cq=0;
        nk_Cq=0;
    else
        prop_Cq=cubes_Cq/total_cubes;
        prop_Cp=cubes_Cp/total_cubes;

        nk_Cq=floor(dots_nk*prop_Cq); T_Cq=floor(dots_T*prop_Cq);
        nk_Cp=dots_nk-nk_Cq; T_Cp=dots_T-T_Cq;
    end
    
    % Generate all positions for dots
    r = 6 + exprnd(1.5, 1, nk_Cq + T_Cq);
    theta = 2 * pi * rand(1, nk_Cq + T_Cq );
    phi = acos(2*rand(1,nk_Cq + T_Cq)-1);
    total_xpos1 = -8 + r .* sin(phi) .* cos(theta);
    total_ypos1 = 0 + r .* sin(phi) .* sin(theta);
    total_zpos1 = 0 + r .* cos(phi);

    r = 6 + exprnd(1.5, 1, nk_Cp + T_Cp);
    theta = 2 * pi * rand(1,nk_Cp + T_Cp);
    phi = acos(2*rand(1,nk_Cp + T_Cp)-1);
    total_xpos2 = 8 + r .* sin(phi) .* cos(theta);
    total_ypos2 = 0 + r .* sin(phi) .* sin(theta);
    total_zpos2 = 0 + r .* cos(phi);
    
    % Shulle all generated postions
    all_xpos=[total_xpos1,total_xpos2];
    all_ypos=[total_ypos1,total_ypos2];
    all_zpos=[total_zpos1,total_zpos2];

    shuffled_order=randperm(length(all_xpos));
    total_xpos=all_xpos(shuffled_order);
    total_ypos=all_ypos(shuffled_order);
    total_zpos=all_zpos(shuffled_order);
    
    
    %Plot T-cells
    xposT=total_xpos(1:dots_T);
    yposT=total_ypos(1:dots_T);
    zposT=total_zpos(1:dots_T);
    T_plot=scatter3(xposT,yposT,zposT, 50,[0 0 1],'filled');
    hold on;
    
    % Plot Quiescent Cells
    if cubes_Cq==0
        Cq_Cubes=grow_cubes([-8 0 0],cubes_Cq,[0 1 1]);
        hold on;
    else
        Cq_Cubes=grow_cubes([-8 0 0],cubes_Cq + randi([-1 1]),[0 1 1]);
        hold on;
    end

    % Plot Proliferative Cells
    Cp_Cubes=grow_cubes([8 0 0],cubes_Cp + randi([-1 1]),[1 0 0]);
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
    legend([Cp_Cubes, N_plot, T_plot,Cq_Cubes], {'10x10^3 Proliferative Cells','50x10^3 NK-cells','50x10^3 T-cells','10x10^3 Quiescent Cells'}, ...
    'TextColor', 'w', 'Location', 'northeast', 'FontSize', 12);

    string= sprintf('Days since innoculation: %d',round(t(i)));
    dimensions = [0.05 0.88 0.1 0.05];
    annotation('textbox',dimensions,'String',string,'FontSize',16,'FontWeight','bold', ...
        'EdgeColor','w','BackgroundColor','k','Color','w','FitBoxToText','on');

    msg = sprintf(['\\color{white}Proliferative Cells: \\color{red}%.1f x10^3\n' ...
                   '\\color{white}Quiescent Cells: \\color{cyan}%.1f x10^3\n' ...
                   '\\color{white}NK Cells: \\color{magenta}%.1f x10^6\n' ...
                   '\\color{white}T Cells: \\color{blue}%.1f x10^6'], ...
                   Cp(i)/1e3, Cq(i)/1e3, N(i)/1e6, T(i)/1e6);

    annotation('textbox', [0.05, 0.83, 0.1, 0.05], ...
               'String', msg, ...
               'Interpreter', 'tex', ...
               'FitBoxToText', 'on', ...
               'BackgroundColor', 'k', ...
               'EdgeColor', 'w', ...
               'FontSize', 10, ...
               'FontWeight', 'normal', ...
               'FontName', 'Helvetica');
    title('Vaccination Scenario 3 (Single dose 7 days after Innoculation)', 'Color', 'w', 'FontSize', 16, 'FontWeight', 'bold');
    
    if t(i)>=7 && t(i)<=11
        string= sprintf('1st dose of 1x10^6 dormant tumor cells');
        dimensions = [0.05 0.715 0.1 0.05];
        annotation('textbox',dimensions,'String',string,'FontSize',12,'FontWeight','normal', ...
        'EdgeColor','w','BackgroundColor','k','Color','w','FitBoxToText','on');
    end

    % Sizing of axes
    xlim([-16 16])
    ylim([-16 16])
    zlim([-8 8])
    grid on;
    
    % Camera motion
    az = (i-1) * (90/len);                    
    el = 30;                                
    view(az, el);

    frames(i) = getframe(fig);
end

movie(fig,frames,1,10);

movie = VideoWriter('Vaccination Scenario 3','MPEG-4');
movie.FrameRate = 10;
movie.Quality=100;

open(movie);
writeVideo(movie,frames);
close(movie);

