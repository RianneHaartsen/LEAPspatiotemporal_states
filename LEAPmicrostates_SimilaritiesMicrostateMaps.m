%% Correlations between MS maps, min 20 trls
% This script loads in the microstate maps of all the age groups and
% calculates the correlation between the topologies. These findings are
% reported in the SM 11.

% created by Rianne Haartsen, March 2020 

clear all
load('%%path%%/Children_MSb_0_800ms_7MS_stats.mat')
Chil_MSmaps20 = rd.MSMaps;
Channels = [];
for ch = 1:59
    Channels{ch} = rd.Channel(ch).Name;
end
clear rd

load('%%path%%/Adolescents_MS6_5MS_stats.mat')
Adol_MSmaps20 = rd.MSMaps;
clear rd

load('%%path%%/Adults_MSb_6MS_stats.mat')
Adul_MSmaps20 = rd.MSMaps;
clear rd

All_MSmaps20 = [Chil_MSmaps20', Adol_MSmaps20', Adul_MSmaps20'];

%% calculate correlations
[rho, pval] = corr(All_MSmaps20,'type','Spearman','rows','pairwise');


%% plot lower part and thresholded, with clim

% set values in upper triangle ton NaN
    rho2 = tril(rho,-1);
    rho2(rho2==0) = NaN;
% threshold data
    AlphaLevel = .0004;
    rho2(pval >= AlphaLevel) = NaN;
% plot data
    figure;
    b1 = imagesc(rho2,[-1 1]);
    set(b1,'AlphaData',~isnan(rho2))
    a = colorbar;
    a.Label.String = 'Spearmans rho';
    a.Label.FontSize = 12;
    a.Limits = [.45 1];
    xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18])
    xtickangle(45)
    xticklabels({'Ch MS_1','Ch MS_2','Ch MS_3','Ch MS_4','Ch MS_5','Ch MS_6','Ch MS_7',...
        'Ado MS_1','Ado MS_2','Ado MS_3','Ado MS_4','Ado MS_5',...
        'Adu MS_1','Adu MS_2','Adu MS_3','Adu MS_4','Adu MS_5','Adu MS_6'});
    yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18])
    yticklabels({'Ch MS_1','Ch MS_2','Ch MS_3','Ch MS_4','Ch MS_5','Ch MS_6','Ch MS_7',...
        'Ado MS_1','Ado MS_2','Ado MS_3','Ado MS_4','Ado MS_5',...
        'Adu MS_1','Adu MS_2','Adu MS_3','Adu MS_4','Adu MS_5','Adu MS_6'});
    
title({'Correlations between microstate maps'},'Fontsize',14)



    
    


    
    
    
    
    
    
    
    

