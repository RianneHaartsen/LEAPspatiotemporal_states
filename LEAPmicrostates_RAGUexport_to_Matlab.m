%% Associations between MS features and N170 features: set up datasets for min 20 tpc
% This script reads in the excel files exported from RAGU and organised the
% microstate features observed into structures for further analyses. 

%% read in ind MS feature data

% Children
[~, ~, Chil_IndMSvals] = xlsread('/%%path%%/Children_InvMSvalues.xlsx','Sheet1');
Chil_IndMSvals = Chil_IndMSvals(1:end,:);

Chil_IndMSvals = string(Chil_IndMSvals);
Chil_IndMSvals(ismissing(Chil_IndMSvals)) = '';

% Adolescents
[~, ~, Adol_IndMSvals] = xlsread('%%path%%/Adolescents_InvMSvalues.xlsx','Sheet1');
Adol_IndMSvals = Adol_IndMSvals(1:end,:);

Adol_IndMSvals = string(Adol_IndMSvals);
Adol_IndMSvals(ismissing(Adol_IndMSvals)) = '';

% Adults
[~, ~, Adul_IndMSvals] = xlsread('/%%path%%/Adults_InvMSvalues.xlsx','Sheet1');
Adul_IndMSvals = Adul_IndMSvals(1:end,:);

Adul_IndMSvals = string(Adul_IndMSvals);
Adul_IndMSvals(ismissing(Adul_IndMSvals)) = '';


%% match up children data

% create structure
    Children_MS_ERPmaster = struct();

% add fields for first subject
    Children_MS_ERPmaster.Subj(1,1) = extractBefore(Chil_IndMSvals(2,1),'_');
% Microstates    
    % MS1
    Children_MS_ERPmaster.MS1.Inv.Dur(1,1) = str2double(Chil_IndMSvals(2,2));
    Children_MS_ERPmaster.MS1.Inv.GFP(1,1) = str2double(Chil_IndMSvals(2,3));
    Children_MS_ERPmaster.MS1.Up.Dur(1,1) = str2double(Chil_IndMSvals(2,4));
    Children_MS_ERPmaster.MS1.Up.GFP(1,1) = str2double(Chil_IndMSvals(2,5));
    % MS2
    Children_MS_ERPmaster.MS2.Inv.Dur(1,1) = str2double(Chil_IndMSvals(2,7));
    Children_MS_ERPmaster.MS2.Inv.GFP(1,1) = str2double(Chil_IndMSvals(2,8));
    Children_MS_ERPmaster.MS2.Up.Dur(1,1) = str2double(Chil_IndMSvals(2,9));
    Children_MS_ERPmaster.MS2.Up.GFP(1,1) = str2double(Chil_IndMSvals(2,10));
    % MS3
    Children_MS_ERPmaster.MS3.Inv.Dur(1,1) = str2double(Chil_IndMSvals(2,12));
    Children_MS_ERPmaster.MS3.Inv.GFP(1,1) = str2double(Chil_IndMSvals(2,13));
    Children_MS_ERPmaster.MS3.Up.Dur(1,1) = str2double(Chil_IndMSvals(2,14));
    Children_MS_ERPmaster.MS3.Up.GFP(1,1) = str2double(Chil_IndMSvals(2,15));
    % MS4
    Children_MS_ERPmaster.MS4.Inv.Dur(1,1) = str2double(Chil_IndMSvals(2,17));
    Children_MS_ERPmaster.MS4.Inv.GFP(1,1) = str2double(Chil_IndMSvals(2,18));
    Children_MS_ERPmaster.MS4.Up.Dur(1,1) = str2double(Chil_IndMSvals(2,19));
    Children_MS_ERPmaster.MS4.Up.GFP(1,1) = str2double(Chil_IndMSvals(2,20));    
    % MS5
    Children_MS_ERPmaster.MS5.Inv.Dur(1,1) = str2double(Chil_IndMSvals(2,22));
    Children_MS_ERPmaster.MS5.Inv.GFP(1,1) = str2double(Chil_IndMSvals(2,23));
    Children_MS_ERPmaster.MS5.Up.Dur(1,1) = str2double(Chil_IndMSvals(2,24));
    Children_MS_ERPmaster.MS5.Up.GFP(1,1) = str2double(Chil_IndMSvals(2,25));    
    % MS6
    Children_MS_ERPmaster.MS6.Inv.Dur(1,1) = str2double(Chil_IndMSvals(2,27));
    Children_MS_ERPmaster.MS6.Inv.GFP(1,1) = str2double(Chil_IndMSvals(2,28));
    Children_MS_ERPmaster.MS6.Up.Dur(1,1) = str2double(Chil_IndMSvals(2,29));
    Children_MS_ERPmaster.MS6.Up.GFP(1,1) = str2double(Chil_IndMSvals(2,30));    
    

% add fields for other subjects %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nrows = length(Chil_IndMSvals);

for rMSvals = 3:Nrows

    nextrMast = size(Children_MS_ERPmaster.Subj,1)+1;
    
    Children_MS_ERPmaster.Subj(nextrMast,1) = extractBefore(Chil_IndMSvals(rMSvals,1),'_');
% Microstates    
    % MS1
    Children_MS_ERPmaster.MS1.Inv.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,2));
    Children_MS_ERPmaster.MS1.Inv.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,3));
    Children_MS_ERPmaster.MS1.Up.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,4));
    Children_MS_ERPmaster.MS1.Up.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,5));
    % MS2
    Children_MS_ERPmaster.MS2.Inv.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,7));
    Children_MS_ERPmaster.MS2.Inv.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,8));
    Children_MS_ERPmaster.MS2.Up.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,9));
    Children_MS_ERPmaster.MS2.Up.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,10));
    % MS3
    Children_MS_ERPmaster.MS3.Inv.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,12));
    Children_MS_ERPmaster.MS3.Inv.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,13));
    Children_MS_ERPmaster.MS3.Up.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,14));
    Children_MS_ERPmaster.MS3.Up.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,15));
    % MS4
    Children_MS_ERPmaster.MS4.Inv.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,17));
    Children_MS_ERPmaster.MS4.Inv.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,18));
    Children_MS_ERPmaster.MS4.Up.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,19));
    Children_MS_ERPmaster.MS4.Up.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,20));    
    % MS5
    Children_MS_ERPmaster.MS5.Inv.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,22));
    Children_MS_ERPmaster.MS5.Inv.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,23));
    Children_MS_ERPmaster.MS5.Up.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,24));
    Children_MS_ERPmaster.MS5.Up.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,25));    
    % MS6
    Children_MS_ERPmaster.MS6.Inv.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,27));
    Children_MS_ERPmaster.MS6.Inv.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,28));
    Children_MS_ERPmaster.MS6.Up.Dur(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,29));
    Children_MS_ERPmaster.MS6.Up.GFP(nextrMast,1) = str2double(Chil_IndMSvals(rMSvals,30));  
    

end

Namefull = '%%path%%/Children_MSindVals_20tpc.mat';
save(Namefull, 'Children_MSindVals_20tpc');


%% match up adolescents data

load('/%%path%%/ERPN170_master_allLEAPppts.mat')

% create structure
    Adolescents_MS_ERPmaster = struct();

% add fields for first subject
    Adolescents_MS_ERPmaster.Subj(1,1) = extractBefore(Adol_IndMSvals(2,1),'_');
% Microstates    
    % MS1
    Adolescents_MS_ERPmaster.MS1.Inv.Dur(1,1) = str2double(Adol_IndMSvals(2,2));
    Adolescents_MS_ERPmaster.MS1.Inv.GFP(1,1) = str2double(Adol_IndMSvals(2,3));
    Adolescents_MS_ERPmaster.MS1.Up.Dur(1,1) = str2double(Adol_IndMSvals(2,4));
    Adolescents_MS_ERPmaster.MS1.Up.GFP(1,1) = str2double(Adol_IndMSvals(2,5));
    % MS2
    Adolescents_MS_ERPmaster.MS2.Inv.Dur(1,1) = str2double(Adol_IndMSvals(2,7));
    Adolescents_MS_ERPmaster.MS2.Inv.GFP(1,1) = str2double(Adol_IndMSvals(2,8));
    Adolescents_MS_ERPmaster.MS2.Up.Dur(1,1) = str2double(Adol_IndMSvals(2,9));
    Adolescents_MS_ERPmaster.MS2.Up.GFP(1,1) = str2double(Adol_IndMSvals(2,10));
    % MS3
    Adolescents_MS_ERPmaster.MS3.Inv.Dur(1,1) = str2double(Adol_IndMSvals(2,12));
    Adolescents_MS_ERPmaster.MS3.Inv.GFP(1,1) = str2double(Adol_IndMSvals(2,13));
    Adolescents_MS_ERPmaster.MS3.Up.Dur(1,1) = str2double(Adol_IndMSvals(2,14));
    Adolescents_MS_ERPmaster.MS3.Up.GFP(1,1) = str2double(Adol_IndMSvals(2,15));
    % MS4
    Adolescents_MS_ERPmaster.MS4.Inv.Dur(1,1) = str2double(Adol_IndMSvals(2,17));
    Adolescents_MS_ERPmaster.MS4.Inv.GFP(1,1) = str2double(Adol_IndMSvals(2,18));
    Adolescents_MS_ERPmaster.MS4.Up.Dur(1,1) = str2double(Adol_IndMSvals(2,19));
    Adolescents_MS_ERPmaster.MS4.Up.GFP(1,1) = str2double(Adol_IndMSvals(2,20));    
    % MS5
    Adolescents_MS_ERPmaster.MS5.Inv.Dur(1,1) = str2double(Adol_IndMSvals(2,22));
    Adolescents_MS_ERPmaster.MS5.Inv.GFP(1,1) = str2double(Adol_IndMSvals(2,23));
    Adolescents_MS_ERPmaster.MS5.Up.Dur(1,1) = str2double(Adol_IndMSvals(2,24));
    Adolescents_MS_ERPmaster.MS5.Up.GFP(1,1) = str2double(Adol_IndMSvals(2,25));       
    

% add fields for other subjects %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nrows = length(Adol_IndMSvals);

for rMSvals = 3:Nrows

    nextrMast = size(Adolescents_MS_ERPmaster.Subj,1)+1;
    
    Adolescents_MS_ERPmaster.Subj(nextrMast,1) = extractBefore(Adol_IndMSvals(rMSvals,1),'_');
% Microstates    
    % MS1s
    Adolescents_MS_ERPmaster.MS1.Inv.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,2));
    Adolescents_MS_ERPmaster.MS1.Inv.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,3));
    Adolescents_MS_ERPmaster.MS1.Up.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,4));
    Adolescents_MS_ERPmaster.MS1.Up.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,5));
    % MS2
    Adolescents_MS_ERPmaster.MS2.Inv.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,7));
    Adolescents_MS_ERPmaster.MS2.Inv.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,8));
    Adolescents_MS_ERPmaster.MS2.Up.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,9));
    Adolescents_MS_ERPmaster.MS2.Up.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,10));
    % MS3
    Adolescents_MS_ERPmaster.MS3.Inv.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,12));
    Adolescents_MS_ERPmaster.MS3.Inv.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,13));
    Adolescents_MS_ERPmaster.MS3.Up.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,14));
    Adolescents_MS_ERPmaster.MS3.Up.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,15));
    % MS4
    Adolescents_MS_ERPmaster.MS4.Inv.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,17));
    Adolescents_MS_ERPmaster.MS4.Inv.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,18));
    Adolescents_MS_ERPmaster.MS4.Up.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,19));
    Adolescents_MS_ERPmaster.MS4.Up.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,20));    
    % MS5
    Adolescents_MS_ERPmaster.MS5.Inv.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,22));
    Adolescents_MS_ERPmaster.MS5.Inv.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,23));
    Adolescents_MS_ERPmaster.MS5.Up.Dur(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,24));
    Adolescents_MS_ERPmaster.MS5.Up.GFP(nextrMast,1) = str2double(Adol_IndMSvals(rMSvals,25));        

end

Namefull = '%%path%%/Adolescents_MSindVals_20tpc.mat';
save(Namefull, 'Adolescents_MSindVals_20tpc');




%% match up adults data

load('%%path%%/ERPN170_master_allLEAPppts.mat')

% create structure
    Adults_MS_ERPmaster = struct();

% add fields for first subject
    Adults_MS_ERPmaster.Subj(1,1) = extractBefore(Adul_IndMSvals(2,1),'_');
% Microstates    
    % MS1
    Adults_MS_ERPmaster.MS1.Inv.Dur(1,1) = str2double(Adul_IndMSvals(2,2));
    Adults_MS_ERPmaster.MS1.Inv.GFP(1,1) = str2double(Adul_IndMSvals(2,3));
    Adults_MS_ERPmaster.MS1.Up.Dur(1,1) = str2double(Adul_IndMSvals(2,4));
    Adults_MS_ERPmaster.MS1.Up.GFP(1,1) = str2double(Adul_IndMSvals(2,5));
    % MS2
    Adults_MS_ERPmaster.MS2.Inv.Dur(1,1) = str2double(Adul_IndMSvals(2,7));
    Adults_MS_ERPmaster.MS2.Inv.GFP(1,1) = str2double(Adul_IndMSvals(2,8));
    Adults_MS_ERPmaster.MS2.Up.Dur(1,1) = str2double(Adul_IndMSvals(2,9));
    Adults_MS_ERPmaster.MS2.Up.GFP(1,1) = str2double(Adul_IndMSvals(2,10));
    % MS3
    Adults_MS_ERPmaster.MS3.Inv.Dur(1,1) = str2double(Adul_IndMSvals(2,12));
    Adults_MS_ERPmaster.MS3.Inv.GFP(1,1) = str2double(Adul_IndMSvals(2,13));
    Adults_MS_ERPmaster.MS3.Up.Dur(1,1) = str2double(Adul_IndMSvals(2,14));
    Adults_MS_ERPmaster.MS3.Up.GFP(1,1) = str2double(Adul_IndMSvals(2,15));
    % MS4
    Adults_MS_ERPmaster.MS4.Inv.Dur(1,1) = str2double(Adul_IndMSvals(2,17));
    Adults_MS_ERPmaster.MS4.Inv.GFP(1,1) = str2double(Adul_IndMSvals(2,18));
    Adults_MS_ERPmaster.MS4.Up.Dur(1,1) = str2double(Adul_IndMSvals(2,19));
    Adults_MS_ERPmaster.MS4.Up.GFP(1,1) = str2double(Adul_IndMSvals(2,20));    
    % MS5
    Adults_MS_ERPmaster.MS5.Inv.Dur(1,1) = str2double(Adul_IndMSvals(2,22));
    Adults_MS_ERPmaster.MS5.Inv.GFP(1,1) = str2double(Adul_IndMSvals(2,23));
    Adults_MS_ERPmaster.MS5.Up.Dur(1,1) = str2double(Adul_IndMSvals(2,24));
    Adults_MS_ERPmaster.MS5.Up.GFP(1,1) = str2double(Adul_IndMSvals(2,25));      
    

% add fields for other subjects %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nrows = length(Adul_IndMSvals);

for rMSvals = 3:Nrows

    nextrMast = size(Adults_MS_ERPmaster.Subj,1)+1;
    
    Adults_MS_ERPmaster.Subj(nextrMast,1) = extractBefore(Adul_IndMSvals(rMSvals,1),'_');
% Microstates    
    % MS1s
    Adults_MS_ERPmaster.MS1.Inv.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,2));
    Adults_MS_ERPmaster.MS1.Inv.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,3));
    Adults_MS_ERPmaster.MS1.Up.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,4));
    Adults_MS_ERPmaster.MS1.Up.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,5));
    % MS2
    Adults_MS_ERPmaster.MS2.Inv.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,7));
    Adults_MS_ERPmaster.MS2.Inv.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,8));
    Adults_MS_ERPmaster.MS2.Up.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,9));
    Adults_MS_ERPmaster.MS2.Up.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,10));
    % MS3
    Adults_MS_ERPmaster.MS3.Inv.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,12));
    Adults_MS_ERPmaster.MS3.Inv.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,13));
    Adults_MS_ERPmaster.MS3.Up.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,14));
    Adults_MS_ERPmaster.MS3.Up.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,15));
    % MS4
    Adults_MS_ERPmaster.MS4.Inv.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,17));
    Adults_MS_ERPmaster.MS4.Inv.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,18));
    Adults_MS_ERPmaster.MS4.Up.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,19));
    Adults_MS_ERPmaster.MS4.Up.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,20));    
    % MS5
    Adults_MS_ERPmaster.MS5.Inv.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,22));
    Adults_MS_ERPmaster.MS5.Inv.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,23));
    Adults_MS_ERPmaster.MS5.Up.Dur(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,24));
    Adults_MS_ERPmaster.MS5.Up.GFP(nextrMast,1) = str2double(Adul_IndMSvals(rMSvals,25));    

end

Namefull = '%%path%%/Adults_MSindVals_20tpc.mat';
save(Namefull, 'Adults_MSindVals_20tpc');