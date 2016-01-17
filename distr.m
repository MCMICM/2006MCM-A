function pptn = distr(r)
% Precipitation rate in the position with a distance r from the sprinkler.
%                          
%                         3(R - r)
%               pr(r) = ------------ v,   R = 19m, v = 50lpm 
%                          pi R^3
%
% zhou lvwen: zhou.lv.wen@gmail.com.   January 12, 2015
%%

R = 19;                  % m. precipitation radius for 3 sprinklers/pipe
pptn = 3/(pi*R^3)*(R-r); % 1/m^2. precipitation
pptn(pptn<0) = 0;