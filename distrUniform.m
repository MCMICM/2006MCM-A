function DU = distrUniform(field)
%
% To compute distribution uniformity (DU). DU is defined as
%
%               average precipitation rate of low quarter
%        DU =  ------------------------------------------- x 100 %
%                    average precititation rate
%
% zhou lvwen: zhou.lv.wen@gmail.com.   January 12, 2015
%%

field = sort(field(:));
quar = round(length(field)/4); % quarter
DU = mean(field(1:quar)) / mean(field);
