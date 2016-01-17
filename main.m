% 
% MCM 2006 PROBLEM A: Positioning and Moving Sprinkler Systems for Irrigation
%
% Reference: Wang Cheng, Wen Ye and Yu Yintao. A Schedule for Lazy but 
%            Smart Ranchers. The UMAP Journal 27 (3) (2006) 269–284.
%
% zhou lvwen: zhou.lv.wen@gmail.com.   January 12, 2015
%%

Lx = 80;        Ly = 30;        % m, field size
nx = 801;       ny = 301;       % number of grids
dx = Lx/(nx-1); dy = Ly/(ny-1); % m, grid size
flux = 0.15;                    % 0.15 m^3/min = 150 L/min
m2cm = 100;                     % factor for meter to centimeter

type = 1;                       % layout type. see function layout
[pipe, npipe, nsperinkler] = layout(type,1);

xi = linspace(0, Lx, nx);
yi = linspace(0, Ly, ny);

[x, y] = meshgrid(xi,yi);       % grid(i,j)'s postion = (x(i,j), y(i,j))
field = zeros(ny, nx);          % define a vacant field

for i = 1:npipe
    for j = 1:nsperinkler
        % r: the distance from the position to the sprinkler
        r = sqrt( (x - pipe(i).sperinkler(j).x).^2 + ...
                  (y - pipe(i).sperinkler(j).y).^2 );
        field = field + distr(r);
    end
end

field = field * flux/nsperinkler * m2cm; 

maxpr = max(field(:));

figure('name',['precipitation rate profile for layout ', num2str(type)])
imagesc(xi, yi, field)
axis image;  colormap gray; colorbar
DU = distrUniform(field)
title(['precipitation rate profile for layout ', num2str(type)]);
xlabel(sprintf('DU = %.4f, Max precipitation rate = %.4f cm/min',DU,maxpr));