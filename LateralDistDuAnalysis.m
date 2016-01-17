function LateralDistDuAnalysis
%
% Analysis of the relationship between DU and lateral distance
%
%%    Rectangular spacing          %      Trianglular spacing
%       <--dx-->                   %        <--dx-->
%       :      :      :            %        :      :      :           
%   ... o      o      o ...        %    ... o      |      o ...        
%       |      |      | dy         %        |      o      | dy         
%   ... o------o      o ...        %    ... o----- |      o ...        
%       |######|      |            %        |######o      |            
%   ... o------o      o ...        %    ... o------|      o ...        
%       |      |      |            %        |      o      |            
%   ... o      o      o ...        %    ... o      |      o ...        
%       :      :      :            %        :      :      :            
%%                                
% zhou lvwen: zhou.lv.wen@gmail.com.   January 12, 2015
%%

%% DU plotted vs. lateral distance, in 4 different situations.
nx = 30; ny = 30;
DU = [];
for dx = 3:25 % lateral distance
    DUi = [];
    for dy =  20./[2, 3] % sprinkler distance
        DUr = spacingDU(dx, dy, nx, ny, 'rectangle');
        DUt = spacingDU(dx, dy, nx, ny, 'triangle');
        DUi = [DUi DUr DUt];
    end
    DU = [DU; DUi];
end

figure('name','DU vs. lateral distance, in 4 different situations')
plot(3:25,DU)
legend('rectangular spaceing, with sprinkler distance 10.00m', ...
       'triangular  spaceing, with sprinkler distance 10.00m', ...
       'rectangular spaceing, with sprinkler distance  6.67m', ...
       'triangular  spaceing, with sprinkler distance  6.67m',3)
xlabel('Lateral Distance (unit:m)'); ylabel('Distribution Uniformity');
title('DU vs. lateral distance, in 4 different situations')

%%  2D and 3D Precipitation profile
dx = 20;  dy = 10;
spacing = {'rectangle', 'triangle'};
for i = 1:2
    figure('name', '2D and 3D Precipitation profile')
    spactype = spacing{i};
    
    subplot(1,2,1) % 2D
    nx = 300; ny = 300;
    [DU, field] = spacingDU(dx, dy, nx, ny, spactype);
    xi = linspace(0,dx,nx); yi = linspace(0,dy,ny);
    imagesc(yi,xi,field'*50)
    colormap gray;
    
    subplot(1,2,2) % 3D
    nx = 30; ny = 30;
    [DU, field] = spacingDU(dx, dy, nx, ny, spactype);
    xi = linspace(0,dx,nx); yi = linspace(0,dy,ny);
    surf(xi,yi,field);
    colorbar
    fprintf(1,['------%s spacing------   \n',...
               '-sprinkler distance = 10m\n',...
               '-lateral distance   = 20m\n',...
               '         DU = %2.1f%%\n\n'], spactype, DU*100);
end

% ------------------------------------------------------------------------

function [DU, field] = spacingDU(dx, dy, nx, ny, type)

if ~strcmp(type,'triangle') & ~strcmp(type,'rectangle');
    error('type can olny be "rectangle" or "triangle" ');
end

field = zeros(ny, nx);
xi = linspace(0, dx, nx);
yi = linspace(0, dy, ny);
[x,y] = meshgrid(xi, yi);
R = 19; % m. precipitation radius for 3 sprinklers/pipe

n = 0;
for sx = dx*[-ceil(R/dx):ceil(R/dx)+1]
    n = n + 1;
    for sy = dy*[-ceil(R/dy)-1:ceil(R/dy)+2]
        if strcmp(type,'triangle'); sy = sy + dy/2*mod(n,2); end
        r = sqrt((x-sx).^2 + (y-sy).^2);
        field = field + distr(r);
    end
end
DU = distrUniform(field);