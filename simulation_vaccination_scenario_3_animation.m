clc
clear all
close all

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
len = length(t);

frames(len) = struct('cdata', [], 'colormap', []);
fig = figure('Position', [0, 0, 1920, 1080]);

for i=1:len
    clf;
    
    plot(t(i),Cp(i),'-','Color','b');
    hold on;
    plot(t(1:i),Cp(1:i),'b-');
    hold on

    plot(t(i),Cq(i),'-','Color','r');
    hold on;
    plot(t(1:i),Cq(1:i),'r-');
    hold on

    plot(t(i),N(i),'-','Color','y');
    hold on;
    plot(t(1:i),N(1:i),'y-');
    hold on;

    plot(t(i),T(i),'-','Color','[0.5, 0, 0.5]');
    hold on;
    plot(t(1:i),T(1:i),'Color',[0.5, 0, 0.5]);

    %Formating
    ylim([0 10e6]);
    xlim([0 70]);
    xticks(sort(unique([get(gca, 'XTick'), 7])));
    ylabel('Cells number (x10^6)');
    xlabel('Time (days after tumor cells inoculation)')
    legend('','Proliferative tumor cell','','Quiescent tumor cell','','NK cell','','T cell','Location','northwest');
    grid on;

    if t(i) >= 7 && t(i) <= 20
    annotation('textarrow', [0.208, 0.208], [0.38, 0.3], 'String', 'Dose of 2x10^6 quiescent cells');
    end

    frames(i)= getframe(fig);
end 
movie(fig,frames,2,12);

movie = VideoWriter('(7 days before inoculation) Simulation of Vaccination Protocol','MPEG-4');
movie.FrameRate = 12;
movieFile.Quality=100;

open(movie);
writeVideo(movie,frames);
close(movie);


