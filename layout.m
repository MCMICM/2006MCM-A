function [pipe, npipe, nsperinkler] = layout(type, isplot)
% Define layout
%%
%    +---------------------------+     Layout 1: sprinkler distance 10.0m
%    o      o      o      o      o               lateral   distance 20.0m
%    |      |      |      |      |
%    o      o      o      o      o
%    |      |      |      |      |
%    o      o      o      o      o
%    +---------------------------+
%%
%    +---------------------------+     Layout 2: sprinkler distance 10.0m       
%    o--o--o    o--o--o    o--o--o               lateral   distance  5.0m
%    |  1          2          3  |     Layout 3: sprinkler distance 10.0m    
%    |                           |               lateral   distance  4.2m
%    |  4          5          6  |     Layout 1: sprinkler distance  
%    o--o--o    o--o--o    o--o--o               1,3,4,6:9.0m;  2,5:10.0m
%    +---------------------------+               lateral   distance  4.2m
%%
% zhou lvwen: zhou.lv.wen@gmail.com.   January 12, 2015
%%

if nargin==1; isplot = 0; end
switch type
    case 1   % layout 1
        npipe = 5; nsperinkler = 3;
        [x, y] = meshgrid(0:20:80, 5:10:25);
    case 2   % layout 2
        npipe = 6; nsperinkler = 3;
        [x, y] = meshgrid(0:10:80, 5:20:25);
        x = reshape(x',3,6);
        y = reshape(y',3,6);
    case 3   % layout 3
        npipe = 6; nsperinkler = 3;
        [x, y] = meshgrid(0:10:80, 4.2:21.6:25.8);
        x = reshape(x',3,6);
        y = reshape(y',3,6);
    case 4   % layout 4
        npipe = 6; nsperinkler = 3;
        [x, y] = meshgrid([-2 8 18 30 40 50 62 72 82], [4.2 25.8]);
        x = reshape(x',3,6);
        y = reshape(y',3,6);
    case 5   % test case: only one pipe with 3 sprinklers
        npipe = 1; nsperinkler = 3;
        x = [30;40;50]; y = [4;4;4];
    case 6   % test case: only one sprinkler on the center of field
        npipe = 1; nsperinkler = 1;
        x = 40; y = 15;
end

for i = 1:npipe
    for j = 1:nsperinkler
        pipe(i).sperinkler(j).x = x(j,i);
        pipe(i).sperinkler(j).y = y(j,i);
    end
end

%% plot layout
if isplot
    figure('name',['layout ', num2str(type)])
    fill([0,80,80,0],[0,0,30,30],[0.8,0.8,0.8]); hold on
    for i = 1:npipe
        x = [pipe(i).sperinkler.x];
        y = [pipe(i).sperinkler.y];
        plot(x,y,'o-')
    end
    axis image; axis([-5,85,-5,35]);
    xlabel(['layout ', num2str(type)]);
end
