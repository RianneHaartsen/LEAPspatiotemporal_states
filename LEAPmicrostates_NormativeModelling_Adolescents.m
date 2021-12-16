%% Normative modelling of MS data: adolescents

% A) Calculate atypicality scores from normative modelling for ASD individuals
% using CTRL group as as normative group, age as covariate, for duration
% and GFP of each microstate, for up and inv
% B) Sum all atypicality scores into 1 score of overall deviation

% created by Rianne Haartsen, May 2020


addpath('/Users/riannehaartsen/Documents/02a_LEAP_EEG/LEAP_microstates/LEAPms_scripts')

%% Load data

clear

% Children; MS and group data from RAGU
    load('%%path%%/Adolescents_MS6_5MS_stats.mat')
    load('%%path%%/Adolescents20_MS_ERPsMaster.mat')

    Data_Master = struct();
    Data_Master.Subj = str2double(Adolescents20_MS_ERPmaster.Subj);
    Data_Master.Group = rd.IndFeature;
    Data_Master.Age = [];
    Data_Master.MS1 = Adolescents20_MS_ERPmaster.MS1;
    Data_Master.MS2 = Adolescents20_MS_ERPmaster.MS2;
    Data_Master.MS3 = Adolescents20_MS_ERPmaster.MS3;
    Data_Master.MS4 = Adolescents20_MS_ERPmaster.MS4;
    Data_Master.MS5 = Adolescents20_MS_ERPmaster.MS5;
    
    clear Adolescents20_MS_ERPmaster rd

% Age data
% read in excel file with clinical variables
    [~, ~, AllClinicalVars] = xlsread('%%path%%.xlsx','DATA_labels');
    All_Age_years = cell2mat(AllClinicalVars(2:end,[1,14]));
% match the ages to the participants    
    for ii = 1:length(Data_Master.Subj)
        CurrSubj = Data_Master.Subj(ii);
        Indx = All_Age_years(:,1) == CurrSubj;
        Data_Master.Age(ii,1) = All_Age_years(Indx,2);
    end
    clear CurrSubj Indx ii

%% Prepare for normative modelling    
% prepare gaussian process model functions
    addpath(genpath('%%path%%/MATLAB/gpml-matlab-v4.2-2018-06-11'))
    startup
    set(0,'defaultAxesFontSize',12)

% For all models
    Index_CTRgrp = Data_Master.Group == 1;
    Subj = Data_Master.Subj;
    Age = Data_Master.Age;

% Microstate 1
    [Fig_NM_MS1, DevScores_MS1] = NormativeModeling_LEAP_Microstates(Data_Master.MS1, Index_CTRgrp, Subj, Age, 'Microstate 1');

% Microstate 2
    [Fig_NM_MS2, DevScores_MS2] = NormativeModeling_LEAP_Microstates(Data_Master.MS2, Index_CTRgrp, Subj, Age, 'Microstate 2');    
   
% Microstate 3
    [Fig_NM_MS3, DevScores_MS3] = NormativeModeling_LEAP_Microstates(Data_Master.MS3, Index_CTRgrp, Subj, Age, 'Microstate 3');        
   
% Microstate 4
    [Fig_NM_MS4, DevScores_MS4] = NormativeModeling_LEAP_Microstates(Data_Master.MS4, Index_CTRgrp, Subj, Age, 'Microstate 4');        
      
% Microstate 5
    [Fig_NM_MS5, DevScores_MS5] = NormativeModeling_LEAP_Microstates(Data_Master.MS5, Index_CTRgrp, Subj, Age, 'Microstate 5');       

    
%% Save data
cd('%%path%%/NormMod_MS')

% figures
saveas(Fig_NM_MS1,'Adol_NormMod_MS1.png');
saveas(Fig_NM_MS2,'Adol_NormMod_MS2.png');
saveas(Fig_NM_MS3,'Adol_NormMod_MS3.png');
saveas(Fig_NM_MS4,'Adol_NormMod_MS4.png');
saveas(Fig_NM_MS5,'Adol_NormMod_MS5.png');

% save za scores
DeviantScores = struct();
DeviantScores.Subj = DevScores_MS1.Subj;
DeviantScores.MS1.Up = DevScores_MS1.Up;
DeviantScores.MS1.Inv = DevScores_MS1.Inv;
    % add for MS2
    if DeviantScores.Subj == DevScores_MS2.Subj
        DeviantScores.MS2.Up = DevScores_MS2.Up;
        DeviantScores.MS2.Inv = DevScores_MS2.Inv;
    end
    % add for MS3
    if DeviantScores.Subj == DevScores_MS3.Subj
        DeviantScores.MS3.Up = DevScores_MS3.Up;
        DeviantScores.MS3.Inv = DevScores_MS3.Inv;
    end
    % add for MS4
    if DeviantScores.Subj == DevScores_MS4.Subj
        DeviantScores.MS4.Up = DevScores_MS4.Up;
        DeviantScores.MS4.Inv = DevScores_MS4.Inv;
    end
    % add for MS5
    if DeviantScores.Subj == DevScores_MS5.Subj
        DeviantScores.MS5.Up = DevScores_MS5.Up;
        DeviantScores.MS5.Inv = DevScores_MS5.Inv;
    end
    
% Collate into matrix and calculate average deviance
All_devscores = [DevScores_MS1.Up.Dur DevScores_MS1.Up.GFP DevScores_MS1.Inv.Dur DevScores_MS1.Inv.GFP...
    DevScores_MS2.Up.Dur DevScores_MS2.Up.GFP DevScores_MS2.Inv.Dur DevScores_MS2.Inv.GFP...
    DevScores_MS3.Up.Dur DevScores_MS3.Up.GFP DevScores_MS3.Inv.Dur DevScores_MS3.Inv.GFP...
    DevScores_MS4.Up.Dur DevScores_MS4.Up.GFP DevScores_MS4.Inv.Dur DevScores_MS4.Inv.GFP...
    DevScores_MS5.Up.Dur DevScores_MS5.Up.GFP DevScores_MS5.Inv.Dur DevScores_MS5.Inv.GFP];
All_devscores_abs = abs(All_devscores); 
DevScores_ASD_mean = mean(All_devscores_abs,2);

clear Fig_NM_MS1 Fig_NM_MS2 Fig_NM_MS3 Fig_NM_MS4 Fig_NM_MS5 Fig_NM_MS6 Fig_NM_MS7
clear DevScores_MS1 DevScores_MS2 DevScores_MS3 DevScores_MS4 DevScores_MS5 DevScores_MS6 DevScores_MS7
clear All_devscores All_devscores_abs
    
    
%% Clinical data    

% get data
% ADI-R scales
    ADI_SocTot = cell2mat(AllClinicalVars(2:end,[1,30])); 
    ADI_ComTot = cell2mat(AllClinicalVars(2:end,[1,31]));
    ADI_RRBTot = cell2mat(AllClinicalVars(2:end,[1,32]));
% ADOS scales
    CSS_Tot = cell2mat(AllClinicalVars(2:end,[1,33]));
    CSS_SA = cell2mat(AllClinicalVars(2:end,[1,34]));
    CSS_RRB = cell2mat(AllClinicalVars(2:end,[1,35]));
% SRS-2 score
    SRS2_raw = cell2mat(AllClinicalVars(2:end,[1,44]));
    
% select relevant ASD ppts and replace 999 with NaNs
% ADI-R SocTot
    ASD_ADI_SocTot = zeros(length(DeviantScores.Subj),1);
        for ii = 1:length(DeviantScores.Subj)
            CurrSubj = DeviantScores.Subj(ii);
            Indx = ADI_SocTot(:,1) == CurrSubj;
            ASD_ADI_SocTot(ii,1) = ADI_SocTot(Indx,2);
        end
        clear CurrSubj Indx ii
    ASD_ADI_SocTot(ASD_ADI_SocTot == 999) = NaN;    
% ADI-R ComTot
    ASD_ADI_ComTot = zeros(length(DeviantScores.Subj),1);
        for ii = 1:length(DeviantScores.Subj)
            CurrSubj = DeviantScores.Subj(ii);
            Indx = ADI_ComTot(:,1) == CurrSubj;
            ASD_ADI_ComTot(ii,1) = ADI_ComTot(Indx,2);
        end
        clear CurrSubj Indx ii
    ASD_ADI_ComTot(ASD_ADI_ComTot == 999) = NaN;    
% ADI-R RRBTot
    ASD_ADI_RRBTot = zeros(length(DeviantScores.Subj),1);
        for ii = 1:length(DeviantScores.Subj)
            CurrSubj = DeviantScores.Subj(ii);
            Indx = ADI_RRBTot(:,1) == CurrSubj;
            ASD_ADI_RRBTot(ii,1) = ADI_RRBTot(Indx,2);
        end
        clear CurrSubj Indx ii
    ASD_ADI_RRBTot(ASD_ADI_RRBTot == 999) = NaN;    
% ADOS Tot
    ASD_ADOS_CSS_Tot = zeros(length(DeviantScores.Subj),1);
        for ii = 1:length(DeviantScores.Subj)
            CurrSubj = DeviantScores.Subj(ii);
            Indx = CSS_Tot(:,1) == CurrSubj;
            ASD_ADOS_CSS_Tot(ii,1) = CSS_Tot(Indx,2);
        end
        clear CurrSubj Indx ii
    ASD_ADOS_CSS_Tot(ASD_ADOS_CSS_Tot == 999) = NaN;  
% ADOS SA
    ASD_ADOS_CSS_SA = zeros(length(DeviantScores.Subj),1);
        for ii = 1:length(DeviantScores.Subj)
            CurrSubj = DeviantScores.Subj(ii);
            Indx = CSS_SA(:,1) == CurrSubj;
            ASD_ADOS_CSS_SA(ii,1) = CSS_SA(Indx,2);
        end
        clear CurrSubj Indx ii
    ASD_ADOS_CSS_SA(ASD_ADOS_CSS_SA == 999) = NaN;  
% ADOS RRB
    ASD_ADOS_CSS_RRB = zeros(length(DeviantScores.Subj),1);
        for ii = 1:length(DeviantScores.Subj)
            CurrSubj = DeviantScores.Subj(ii);
            Indx = CSS_RRB(:,1) == CurrSubj;
            ASD_ADOS_CSS_RRB(ii,1) = CSS_RRB(Indx,2);
        end
        clear CurrSubj Indx ii
    ASD_ADOS_CSS_RRB(ASD_ADOS_CSS_RRB == 999) = NaN;  
% SRS-2
    ASD_SRS2_raw = zeros(length(DeviantScores.Subj),1);
        for ii = 1:length(DeviantScores.Subj)
            CurrSubj = DeviantScores.Subj(ii);
            Indx = SRS2_raw(:,1) == CurrSubj;
            ASD_SRS2_raw(ii,1) = SRS2_raw(Indx,2);
        end
        clear CurrSubj Indx ii
    ASD_SRS2_raw(ASD_SRS2_raw == 999) = NaN;  

% summarize into 1 matrix for correlations
ClinicalScores = [ASD_ADI_ComTot ASD_ADI_SocTot ASD_ADI_RRBTot...
    ASD_ADOS_CSS_SA ASD_ADOS_CSS_RRB ASD_ADOS_CSS_Tot...
    ASD_SRS2_raw];
Age_ASD = Age(~Index_CTRgrp);

% correlate deviant scores and clinical scores
    [rho, pvals] = corr(ClinicalScores, DevScores_ASD_mean,'type','Spearman','rows','complete')
    [rho2, pvals2] = corr(Age_ASD, DevScores_ASD_mean,'type','Spearman','rows','complete')

% save data
save('Adol_NormMod_data.mat','DeviantScores','DevScores_ASD_mean',...
    'ASD_ADI_ComTot', 'ASD_ADI_SocTot', 'ASD_ADI_RRBTot',...
    'ASD_ADOS_CSS_SA', 'ASD_ADOS_CSS_RRB', 'ASD_ADOS_CSS_Tot',...
    'ASD_SRS2_raw','Age_ASD')






%% For transfering to SPSS

Mtx = [DeviantScores.Subj Age_ASD DevScores_ASD_mean ASD_ADI_ComTot ASD_ADI_SocTot ASD_ADI_RRBTot...
    ASD_ADOS_CSS_SA ASD_ADOS_CSS_RRB ASD_ADOS_CSS_Tot...
    ASD_SRS2_raw];
Mtx2 = Mtx;
Mtx2(isnan(Mtx2)) = 999;
