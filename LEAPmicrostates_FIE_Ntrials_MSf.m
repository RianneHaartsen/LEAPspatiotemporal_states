%% Correlations between N trials and FIE on MS measures: 
% This script tests whether differences in number of trials between
% conditions is related to differences in MS features between conditions.

% adapted by Rianne Haartsen: Nov 2021
%%

% Bonferroni correction
AlphaLevel_chil = .05/(7*2);
AlphaLevel_ado = .05/(5*2);
AlphaLevel_adu = .05/(6*2);


Rs_FIENtrls_x_MSmeasures = figure;
% Children %%%%%%%%%

cd %%path%%
load Children20_MS_ERPsMaster.mat 
Ntrls_diff = Children20_MS_ERPmaster.Ntrls_Inv - Children20_MS_ERPmaster.Ntrls_Up;

% MS1 
Fie_MS1 = [Children20_MS_ERPmaster.MS1.Inv.Dur - Children20_MS_ERPmaster.MS1.Up.Dur, Children20_MS_ERPmaster.MS1.Inv.GFP - Children20_MS_ERPmaster.MS1.Up.GFP];   
% do pairwise correlations
[Fie_rho1, Fie_pvals1] = corr(Fie_MS1, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS2 
Fie_MS2 = [Children20_MS_ERPmaster.MS2.Inv.Dur - Children20_MS_ERPmaster.MS2.Up.Dur, Children20_MS_ERPmaster.MS2.Inv.GFP - Children20_MS_ERPmaster.MS2.Up.GFP];   
% do pairwise correlations
[Fie_rho2, Fie_pvals2] = corr(Fie_MS2, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS3 
Fie_MS3 = [Children20_MS_ERPmaster.MS3.Inv.Dur - Children20_MS_ERPmaster.MS3.Up.Dur, Children20_MS_ERPmaster.MS3.Inv.GFP - Children20_MS_ERPmaster.MS3.Up.GFP];   
% do pairwise correlations
[Fie_rho3, Fie_pvals3] = corr(Fie_MS3, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS4 
Fie_MS4 = [Children20_MS_ERPmaster.MS4.Inv.Dur - Children20_MS_ERPmaster.MS4.Up.Dur, Children20_MS_ERPmaster.MS4.Inv.GFP - Children20_MS_ERPmaster.MS4.Up.GFP];   
% do pairwise correlations
[Fie_rho4, Fie_pvals4] = corr(Fie_MS4, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS5 
Fie_MS5 = [Children20_MS_ERPmaster.MS5.Inv.Dur - Children20_MS_ERPmaster.MS5.Up.Dur, Children20_MS_ERPmaster.MS5.Inv.GFP - Children20_MS_ERPmaster.MS5.Up.GFP];   
% do pairwise correlations
[Fie_rho5, Fie_pvals5] = corr(Fie_MS5, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS6 
Fie_MS6 = [Children20_MS_ERPmaster.MS6.Inv.Dur - Children20_MS_ERPmaster.MS6.Up.Dur, Children20_MS_ERPmaster.MS6.Inv.GFP - Children20_MS_ERPmaster.MS6.Up.GFP];   
% do pairwise correlations
[Fie_rho6, Fie_pvals6] = corr(Fie_MS6, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS7 
Fie_MS7 = [Children20_MS_ERPmaster.MS7.Inv.Dur - Children20_MS_ERPmaster.MS7.Up.Dur, Children20_MS_ERPmaster.MS7.Inv.GFP - Children20_MS_ERPmaster.MS7.Up.GFP];   
% do pairwise correlations
[Fie_rho7, Fie_pvals7] = corr(Fie_MS7, Ntrls_diff,'type','Spearman','rows','pairwise');

rhoAll = [Fie_rho1; Fie_rho2; Fie_rho3; Fie_rho4; Fie_rho5; Fie_rho6; Fie_rho7];
pvalsAll = [Fie_pvals1; Fie_pvals2; Fie_pvals3; Fie_pvals4; Fie_pvals5; Fie_pvals6; Fie_pvals7]; 


% set rho to NaN if p-vals exceet the alpha levels
rhoAll(pvalsAll >= AlphaLevel_chil) = NaN;

% plot figure
subplot(7,3,[1 4 7 10 13 16 19])
b = imagesc(rhoAll,[-1 1]);
set(b,'AlphaData',~isnan(rhoAll))
colorbar
grid on
xtickangle(45)
xticks([1 2 3 4])
xticklabels({'Ntrl inv','Ntrl up','Ntrl FIE'})
yticks(1:1:28)
yticklabels({'MS1 Dur', 'MS1 GFP', ...
    'MS2 Dur','MS2 GFP', ...
    'MS3 Dur','MS3 GFP', ...
    'MS4 Dur','MS4 GFP', ...
    'MS5 Dur','MS5 GFP', ...
    'MS6 Dur','MS6 GFP', ...
    'MS7 Dur','MS7 GFP'})
title({'Children'; strcat('p < ',num2str(AlphaLevel_chil))})

clear Fie_N170
clear Fie_MS1 Fie_MS2 Fie_MS3 Fie_MS4 Fie_MS5 Fie_MS6 Fie_MS7
clear Fie_pvals1 Fie_pvals2 Fie_pvals3 Fie_pvals4 Fie_pvals5 Fie_pvals6 Fie_pvals7 
clear Fie_rho1 Fie_rho2 Fie_rho3 Fie_rho4 Fie_rho5 Fie_rho6 Fie_rho7 
clear rhoAll pvalsAll
clear Ntrls_diff


% Adolescents %%%%%%%%%
load Adolescents20_MS_ERPsMaster.mat 
Ntrls_diff =  Adolescents20_MS_ERPmaster.Ntrls_Inv - Adolescents20_MS_ERPmaster.Ntrls_Up;

% MS1 
Fie_MS1 = [Adolescents20_MS_ERPmaster.MS1.Inv.Dur - Adolescents20_MS_ERPmaster.MS1.Up.Dur, Adolescents20_MS_ERPmaster.MS1.Inv.GFP - Adolescents20_MS_ERPmaster.MS1.Up.GFP];   
% do pairwise correlations
[Fie_rho1, Fie_pvals1] = corr(Fie_MS1, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS2 
Fie_MS2 = [Adolescents20_MS_ERPmaster.MS2.Inv.Dur - Adolescents20_MS_ERPmaster.MS2.Up.Dur, Adolescents20_MS_ERPmaster.MS2.Inv.GFP - Adolescents20_MS_ERPmaster.MS2.Up.GFP];   
% do pairwise correlations
[Fie_rho2, Fie_pvals2] = corr(Fie_MS2, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS3 
Fie_MS3 = [Adolescents20_MS_ERPmaster.MS3.Inv.Dur - Adolescents20_MS_ERPmaster.MS3.Up.Dur, Adolescents20_MS_ERPmaster.MS3.Inv.GFP - Adolescents20_MS_ERPmaster.MS3.Up.GFP];   
% do pairwise correlations
[Fie_rho3, Fie_pvals3] = corr(Fie_MS3, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS4 
Fie_MS4 = [Adolescents20_MS_ERPmaster.MS4.Inv.Dur - Adolescents20_MS_ERPmaster.MS4.Up.Dur, Adolescents20_MS_ERPmaster.MS4.Inv.GFP - Adolescents20_MS_ERPmaster.MS4.Up.GFP];   
% do pairwise correlations
[Fie_rho4, Fie_pvals4] = corr(Fie_MS4, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS5 
Fie_MS5 = [Adolescents20_MS_ERPmaster.MS5.Inv.Dur - Adolescents20_MS_ERPmaster.MS5.Up.Dur, Adolescents20_MS_ERPmaster.MS5.Inv.GFP - Adolescents20_MS_ERPmaster.MS5.Up.GFP];   
% do pairwise correlations
[Fie_rho5, Fie_pvals5] = corr(Fie_MS5, Ntrls_diff,'type','Spearman','rows','pairwise');

rhoAll = [Fie_rho1; Fie_rho2; Fie_rho3; Fie_rho4; Fie_rho5];
pvalsAll = [Fie_pvals1; Fie_pvals2; Fie_pvals3; Fie_pvals4; Fie_pvals5]; 
rhoAll(pvalsAll >= AlphaLevel_ado) = NaN;

% plot figure
subplot(7,3,[2 5 8 11 14])
b = imagesc(rhoAll,[-1 1]);
set(b,'AlphaData',~isnan(rhoAll))
colorbar
grid on
xtickangle(45)
xticks([1 2 3 4])
xticklabels({'Ntrl inv','Ntrl up','Ntrl FIE'})
yticks(1:1:28)
yticklabels({'MS1 Dur', 'MS1 GFP', ...
    'MS2 Dur','MS2 GFP', ...
    'MS3 Dur','MS3 GFP', ...
    'MS4 Dur','MS4 GFP', ...
    'MS5 Dur','MS5 GFP'})
title({'Adolescents'; strcat('p < ',num2str(AlphaLevel_ado))})

clear Fie_N170
clear Fie_MS1 Fie_MS2 Fie_MS3 Fie_MS4 Fie_MS5 Fie_MS6 Fie_MS7
clear Fie_pvals1 Fie_pvals2 Fie_pvals3 Fie_pvals4 Fie_pvals5 Fie_pvals6 Fie_pvals7 
clear Fie_rho1 Fie_rho2 Fie_rho3 Fie_rho4 Fie_rho5 Fie_rho6 Fie_rho7 
clear rhoAll pvalsAll
clear Ntrls_diff


% Adults %%%%%%%%%
load Adults20_MS_ERPsMaster.mat 
Ntrls_diff = Adults20_MS_ERPmaster.Ntrls_Inv - Adults20_MS_ERPmaster.Ntrls_Up;

% MS1 
Fie_MS1 = [Adults20_MS_ERPmaster.MS1.Inv.Dur - Adults20_MS_ERPmaster.MS1.Up.Dur, Adults20_MS_ERPmaster.MS1.Inv.GFP - Adults20_MS_ERPmaster.MS1.Up.GFP];   
% do pairwise correlations
[Fie_rho1, Fie_pvals1] = corr(Fie_MS1, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS2 
Fie_MS2 = [Adults20_MS_ERPmaster.MS2.Inv.Dur - Adults20_MS_ERPmaster.MS2.Up.Dur, Adults20_MS_ERPmaster.MS2.Inv.GFP - Adults20_MS_ERPmaster.MS2.Up.GFP];   
% do pairwise correlations
[Fie_rho2, Fie_pvals2] = corr(Fie_MS2, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS3 
Fie_MS3 = [Adults20_MS_ERPmaster.MS3.Inv.Dur - Adults20_MS_ERPmaster.MS3.Up.Dur, Adults20_MS_ERPmaster.MS3.Inv.GFP - Adults20_MS_ERPmaster.MS3.Up.GFP];   
% do pairwise correlations
[Fie_rho3, Fie_pvals3] = corr(Fie_MS3, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS4 
Fie_MS4 = [Adults20_MS_ERPmaster.MS4.Inv.Dur - Adults20_MS_ERPmaster.MS4.Up.Dur, Adults20_MS_ERPmaster.MS4.Inv.GFP - Adults20_MS_ERPmaster.MS4.Up.GFP];   
% do pairwise correlations
[Fie_rho4, Fie_pvals4] = corr(Fie_MS4, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS5 
Fie_MS5 = [Adults20_MS_ERPmaster.MS5.Inv.Dur - Adults20_MS_ERPmaster.MS5.Up.Dur, Adults20_MS_ERPmaster.MS5.Inv.GFP - Adults20_MS_ERPmaster.MS5.Up.GFP];   
% do pairwise correlations
[Fie_rho5, Fie_pvals5] = corr(Fie_MS5, Ntrls_diff,'type','Spearman','rows','pairwise');

% MS6 
Fie_MS6 = [Adults20_MS_ERPmaster.MS6.Inv.Dur - Adults20_MS_ERPmaster.MS6.Up.Dur, Adults20_MS_ERPmaster.MS6.Inv.GFP - Adults20_MS_ERPmaster.MS6.Up.GFP];   
% do pairwise correlations
[Fie_rho6, Fie_pvals6] = corr(Fie_MS6, Ntrls_diff,'type','Spearman','rows','pairwise');

rhoAll = [Fie_rho1; Fie_rho2; Fie_rho3; Fie_rho4; Fie_rho5; Fie_rho6];
pvalsAll = [Fie_pvals1; Fie_pvals2; Fie_pvals3; Fie_pvals4; Fie_pvals5; Fie_pvals6]; 
rhoAll(pvalsAll >= AlphaLevel_adu) = NaN;

% plot figure
subplot(7,3,[3 6 9 12 15 18])
b = imagesc(rhoAll,[-1 1]);
set(b,'AlphaData',~isnan(rhoAll))
colorbar
grid on
xtickangle(45)
xticks([1 2 3 4])
xticklabels({'Ntrl inv','Ntrl up','Ntrl FIE'})
yticks(1:1:28)
yticklabels({'MS1 Dur', 'MS1 GFP', ...
    'MS2 Dur','MS2 GFP', ...
    'MS3 Dur','MS3 GFP', ...
    'MS4 Dur','MS4 GFP', ...
    'MS5 Dur','MS5 GFP', ...
    'MS6 Dur','MS6 GFP'})
title({'Adults'; strcat('p < ',num2str(AlphaLevel_adu))})

clear Fie_N170
clear Fie_MS1 Fie_MS2 Fie_MS3 Fie_MS4 Fie_MS5 Fie_MS6 Fie_MS7
clear Fie_pvals1 Fie_pvals2 Fie_pvals3 Fie_pvals4 Fie_pvals5 Fie_pvals6 Fie_pvals7 
clear Fie_rho1 Fie_rho2 Fie_rho3 Fie_rho4 Fie_rho5 Fie_rho6 Fie_rho7 
clear rhoAll pvalsAll
clear Ntrls_diff




