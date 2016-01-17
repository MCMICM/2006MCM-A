function RimDistDuAnalysis
%
% Analysis of the relationship between DU and rim distance
%
%% Region to simulate a catch-can test: #
%      <--dx-->          
%      :      :      :        
%      |      o      o ...
%      |      |      | dy
%  rim |------o      o ...
%      |######|      |   
%      |------o      o ...
%      |      |      |   
%      |      o      o ...
%      :      :      :   
%%                                
% zhou lvwen: zhou.lv.wen@gmail.com.   January 12, 2015
%%

%% DU plotted vs. distance from the rim to the sprinkler
nx = 30; ny = 30;
DU = [];
for dx = 0.5:0.5:10
    DUi = [];
    for dy =  20./[2, 3]        
        DUii = rectDU(dx, dy, nx, ny);
        DUi = [DUi DUii];
    end
    DU = [DU; DUi];
end

figure('name', 'DU plotted vs. distance from the rim to the sprinkler')
plot(0.5:0.5:10,DU)
legend('rectangular spaceing, with sprinkler distance 10.00m, lateral distance 20m', ...
       'rectangular spaceing, with sprinkler distance  6.67m, lateral distance 20m', 3)
xlabel('Distance from the rim to the sprinkler (unit: m)')
ylabel('Distribution Uniformity')

% ------------------------------------------------------------------------

function [DU, field] = rectDU(dx, dy, nx, ny)

field = zeros(ny, nx);
xi = linspace(0, dx, nx);
yi = linspace(0, dy, ny);
[x,y] = meshgrid(xi, yi);
R = 19; % m. precipitation radius for 3 sprinklers/pipe

n = 0;
for sx = dx*[1:ceil(R/dx)+1]
    for sy = dy*[-ceil(R/dy):ceil(R/dy)+1]
        r = sqrt((x-sx).^2 + (y-sy).^2);
        field = field + distr(r);
    end
end
DU = distrUniform(field);