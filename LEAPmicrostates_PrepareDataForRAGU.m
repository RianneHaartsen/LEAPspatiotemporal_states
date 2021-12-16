%% Prep LEAP microstates

% This scripts reads in the clean ERP data from the faces up/inverted, and
% converts them to input files for the RAGU program (microstates).

% For each subject with clean ERP data %%%%%%%%%%%%%%%%%%%%%%%%
% 1) read in preprocessed ERP data (preprocessed by Luke Mason and Pilar
% Garces)
% for faces up: 
% 2) select 59 common electrodes
% 3) transpose data with time in rows, and sensors in columns
% 4) save file with name subjID_Fu.asc
% for faces inv:
% 5) select 59 common electrodes
% 6) transpose data with time in rows, and sensores in columns
% 7) save file with name subjID_Fi.asc

% Create montage file for 58 channels with x y z coordinates

% created by Rianne Haartsen, April 2019 - February 2020

%% 

clear 
% Set up local paths to scripts

%add eeglab path
addpath(genpath('%%path%%/MATLAB/eeglab14_1_2b')); 
%add fieldtrip path and set to defaults
addpath('%%path%%/MATLAB/fieldtrip-20180925'); 
ft_defaults

%temp power data folder
addpath('%%path%%/MS_data');

%% Connect to server with data

% contact Luke Mason for access to the client server

MASTER = client.GetTable;

% Query database for data

    [ids, guids] = client.GetField('ID', 'faceerp_avged', true);
    
% Load names of channels of interest
    load %%path%%/MS_data/ChoIs_MS.mat

% Create variable to save and check dimensions of the data    
    TrackerDims = {'ID','Fu_T','Fu_Ch','Fi_T','Fi_Ch'};
    
%%  For each subject with data for the average ERP

for ii = 1:length(ids)
 % NB: data = [] for ii = 407 499 502
 
% Get guid and cleaned fieldtrip format EEG data
    [data, ~] = client.GetVariable('faceerp_avg30', 'ID', ids{ii});
    
        % Put ID in TrackerDims
        TrackerDims{ii+1,1} = ids{ii};
        
        % For face up condition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Prep data
        [FaceUp_ERP] = LEAP_MS_00_PrepData(data.face_up, ChoIs_MS);
        % find the dimensions and save in TrackerDims
        TrackerDims{ii+1,2} = size(FaceUp_ERP,1);
        TrackerDims{ii+1,3} = size(FaceUp_ERP,2);
        
        % For face inv condition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Prep data
        [FaceInv_ERP] = LEAP_MS_00_PrepData(data.face_inv, ChoIs_MS);
        % find the dimensions and save in TrackerDims
        TrackerDims{ii+1,4} = size(FaceInv_ERP,1);
        TrackerDims{ii+1,5} = size(FaceInv_ERP,2);
        
%         if isequal(size(FaceUp_ERP,1),1001) && isequal(size(FaceInv_ERP,1),1001)
            % Save the data in MS_1001 folder
            NameData1 = strcat('/Users/riannehaartsen/Documents/02_Braintools/LEAP_EEG/LEAP_mircostates/MS_data/ERPs_1001/',ids{ii}, '_Fu.txt');
            save(NameData1, 'FaceUp_ERP','-ascii')
            % Save the data
            NameData2 = strcat('/Users/riannehaartsen/Documents/02_Braintools/LEAP_EEG/LEAP_mircostates/MS_data/ERPs_1001/',ids{ii}, '_Fi.txt');
            save(NameData2, 'FaceInv_ERP','-ascii')
%         else
%             % Save the data in MS_not1001 folder
%             NameData1 = strcat('/Users/riannehaartsen/Documents/02_Braintools/LEAP_EEG/LEAP_mircostates/MS_data/MS_not1001/',ids{ii}, '_Fu.txt');
%             save(NameData1, 'FaceUp_ERP','-ascii')
%             % Save the data
%             NameData2 = strcat('/Users/riannehaartsen/Documents/02_Braintools/LEAP_EEG/LEAP_mircostates/MS_data/MS_not1001/',ids{ii}, '_Fi.txt');
%             save(NameData2, 'FaceInv_ERP','-ascii')
%         end

        
        clear FaceUp_ERP FaceInv_ERP NameData1 NameData2 data 
end
  
save('%%path%%/TrackerDimensions_MS.mat','TrackerDims')


%% Select averaged ERPs based on 20 trials or more per condition and move to appropriate folder
% Copy the txt files from subjects with 20 or more trials per condition
% into the min20trls folder. 

% Children %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
% Set up local paths to scripts
    addpath(genpath('%%path%%'));

% load info with subj ids and trials per condition (tpc)
    load('%%path%%')

% find indices for subj with tpc Up => 20 and tpc Inv => 20
    Tpc = [Children_MS_ERPmaster.Ntrls_Up, Children_MS_ERPmaster.Ntrls_Inv, zeros(length(Children_MS_ERPmaster.Ntrls_Inv),1)];
    for ii = 1:length(Tpc)
        if Tpc(ii,1) >= 20 && Tpc(ii,2) >= 20
            Tpc(ii,3) = 1;
        end
    end
    clear ii
    IndSubjIncl = find(Tpc(:,3) == 1);

% create list of subj IDs with min 20 trls   
    for ii = 1:size(IndSubjIncl,1)
        Child_IDs_min20trls{ii,1} = Children_MS_ERPmaster.Subj{IndSubjIncl(ii,1),1};
    end
    clear ii

    cd '%%path%%/LEAP_microstates/MS_data/ERPs_min20trls'
    save('Child_IDs_min20trls.mat','Child_IDs_min20trls')
      
% copy data for subj to new folder and keep track of it
    Tracker_Children = {'ID','CS_Up','CS_Inv'};
    
    % list files in directory
    filesPres = dir('/%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/*.txt');

    for ii = 1:length(Child_IDs_min20trls)
        % Put ID in TrackerDims
        Tracker_Children{ii+1,1} = Child_IDs_min20trls{ii,1};
        
        % Get names for data
        % Up condition
        NameUp = strcat(Child_IDs_min20trls{ii,1},'_Fu.txt');
        fullNameUp = strcat('%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/', NameUp);
        % Inv condition
        NameInv = strcat(Child_IDs_min20trls{ii,1},'_Fi.txt');
        fullNameInv = strcat('%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/', NameInv);
            
        % check if data is present
        Check = [0 0];
        for bb = 1:size(filesPres,1)
            fileQ = string(filesPres(bb).name);
            if strcmp(fileQ, NameUp)
                Check(1,1) = Check(1,1) + 1;
            elseif strcmp(fileQ, NameInv)
                Check(1,2) = Check(1,2) + 1;
            end
        end
        
        if Check(1,1) == 1 && Check(1,2) == 1
            % copy data 
            StatusUp = copyfile(fullNameUp,'%%path%%/LEAP_microstates/MS_data/ERPs_min20trls/Children');
            StatusInv = copyfile(fullNameInv,'%%path%%/LEAP_microstates/MS_data/ERPs_min20trls/Children');
            % Save status of copying into tracker
            Tracker_Children{ii+1,2} = StatusUp;
            Tracker_Children{ii+1,3} = StatusInv;
            clear StatusUp StatusInv 
        else
            warning('Unable to find file')
            if Check(1,1) == 1 && Check(1,2) == 0
                Tracker_Children{ii+1,2} = 1;
                Tracker_Children{ii+1,3} = [];
            elseif Check(1,1) == 0 && Check(1,2) == 1
                Tracker_Children{ii+1,2} = [];
                Tracker_Children{ii+1,3} = 1;
            else
                Tracker_Children{ii+1,2} = [];
                Tracker_Children{ii+1,3} = [];
            end
        end

    end

disp('Copying finished')
save('Tracker_ChildIDs_min20trls.mat','Tracker_Children')

% Adolescents %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
% Set up local paths to scripts
    addpath(genpath('%%path%%/LEAP_microstates/'));

% load info with subj ids and tpc
    load('%%path%%/LEAP_microstates/LEAPms_RAGU_Results/TraditionalWay/Rs_MS_N170/Adolescents_MS_ERPsMaster.mat')

% find indices for subj with tpc Up => 20 and tpc Inv => 20
    Tpc = [Adolescents_MS_ERPmaster.Ntrls_Up, Adolescents_MS_ERPmaster.Ntrls_Inv, zeros(length(Adolescents_MS_ERPmaster.Ntrls_Inv),1)];
    for ii = 1:length(Tpc)
        if Tpc(ii,1) >= 20 && Tpc(ii,2) >= 20
            Tpc(ii,3) = 1;
        end
    end
    clear ii
    IndSubjIncl = find(Tpc(:,3) == 1);

% create list of subj IDs with min 20 trls   
    for ii = 1:size(IndSubjIncl,1)
        Adolescents_IDs_min20trls{ii,1} = Adolescents_MS_ERPmaster.Subj{IndSubjIncl(ii,1),1};
    end
    clear ii

    cd '%%path%%/LEAP_microstates/MS_data/ERPs_min20trls'
    save('Adolescents_IDs_min20trls.mat','Adolescents_IDs_min20trls')
      
% copy data for subj to new folder and keep track of it
    Tracker_Adolescents = {'ID','CS_Up','CS_Inv'};
    
    % list files in directory
    filesPres = dir('%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/*.txt');

    for ii = 1:length(Adolescents_IDs_min20trls)
        % Put ID in TrackerDims
        Tracker_Adolescents{ii+1,1} = Adolescents_IDs_min20trls{ii,1};
        
        % Get names for data
        % Up condition
        NameUp = strcat(Adolescents_IDs_min20trls{ii,1},'_Fu.txt');
        fullNameUp = strcat('%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/', NameUp);
        % Inv condition
        NameInv = strcat(Adolescents_IDs_min20trls{ii,1},'_Fi.txt');
        fullNameInv = strcat('%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/', NameInv);
            
        % check if data is present
        Check = [0 0];
        for bb = 1:size(filesPres,1)
            fileQ = string(filesPres(bb).name);
            if strcmp(fileQ, NameUp)
                Check(1,1) = Check(1,1) + 1;
            elseif strcmp(fileQ, NameInv)
                Check(1,2) = Check(1,2) + 1;
            end
        end
        
        if Check(1,1) == 1 && Check(1,2) == 1
            % copy data 
            StatusUp = copyfile(fullNameUp,'%%path%%/LEAP_microstates/MS_data/ERPs_min20trls/Adolescents');
            StatusInv = copyfile(fullNameInv,'%%path%%/LEAP_microstates/MS_data/ERPs_min20trls/Adolescents');
            % Save status of copying into tracker
            Tracker_Adolescents{ii+1,2} = StatusUp;
            Tracker_Adolescents{ii+1,3} = StatusInv;
            clear StatusUp StatusInv 
        else
            warning('Unable to find file')
            if Check(1,1) == 1 && Check(1,2) == 0
                Tracker_Adolescents{ii+1,2} = 1;
                Tracker_Adolescents{ii+1,3} = [];
            elseif Check(1,1) == 0 && Check(1,2) == 1
                Tracker_Adolescents{ii+1,2} = [];
                Tracker_Adolescents{ii+1,3} = 1;
            else
                Tracker_Adolescents{ii+1,2} = [];
                Tracker_Adolescents{ii+1,3} = [];
            end
        end
      
    disp('Saved data for ii =')    
    disp(ii)
    
    end

disp('Copying finished')
save('Tracker_AdolescentsIDs_min20trls.mat','Tracker_Adolescents')



% Adults %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
% Set up local paths to scripts
    addpath(genpath('%%path%%/LEAP_microstates/'));

% load info with subj ids and tpc
    load('%%path%%/LEAP_microstates/LEAPms_RAGU_Results/TraditionalWay/Rs_MS_N170/Adults_MS_ERPsMaster.mat')

% find indices for subj with tpc Up => 20 and tpc Inv => 20
    Tpc = [Adults_MS_ERPmaster.Ntrls_Up, Adults_MS_ERPmaster.Ntrls_Inv, zeros(length(Adults_MS_ERPmaster.Ntrls_Inv),1)];
    for ii = 1:length(Tpc)
        if Tpc(ii,1) >= 20 && Tpc(ii,2) >= 20
            Tpc(ii,3) = 1;
        end
    end
    clear ii
    IndSubjIncl = find(Tpc(:,3) == 1);

% create list of subj IDs with min 20 trls   
    for ii = 1:size(IndSubjIncl,1)
        Adults_IDs_min20trls{ii,1} = Adults_MS_ERPmaster.Subj{IndSubjIncl(ii,1),1};
    end
    clear ii

    cd '%%path%%/LEAP_microstates/MS_data/ERPs_min20trls'
    save('Adults_IDs_min20trls.mat','Adults_IDs_min20trls')
      
% copy data for subj to new folder and keep track of it
    Tracker_Adults = {'ID','CS_Up','CS_Inv'};
    
    % list files in directory
    filesPres = dir('%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/*.txt');

    for ii = 1:length(Adults_IDs_min20trls)
        % Put ID in TrackerDims
        Tracker_Adults{ii+1,1} = Adults_IDs_min20trls{ii,1};
        
        % Get names for data
        % Up condition
        NameUp = strcat(Adults_IDs_min20trls{ii,1},'_Fu.txt');
        fullNameUp = strcat('%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/', NameUp);
        % Inv condition
        NameInv = strcat(Adults_IDs_min20trls{ii,1},'_Fi.txt');
        fullNameInv = strcat('%%path%%/LEAP_mircostates/MS_data/ERPs_1001_All/', NameInv);
            
        % check if data is present
        Check = [0 0];
        for bb = 1:size(filesPres,1)
            fileQ = string(filesPres(bb).name);
            if strcmp(fileQ, NameUp)
                Check(1,1) = Check(1,1) + 1;
            elseif strcmp(fileQ, NameInv)
                Check(1,2) = Check(1,2) + 1;
            end
        end
        
        if Check(1,1) == 1 && Check(1,2) == 1
            % copy data 
            StatusUp = copyfile(fullNameUp,'%%path%%/LEAP_microstates/MS_data/ERPs_min20trls/Adults');
            StatusInv = copyfile(fullNameInv,'%%path%%/LEAP_microstates/MS_data/ERPs_min20trls/Adults');
            % Save status of copying into tracker
            Tracker_Adults{ii+1,2} = StatusUp;
            Tracker_Adults{ii+1,3} = StatusInv;
            clear StatusUp StatusInv 
        else
            warning('Unable to find file')
            if Check(1,1) == 1 && Check(1,2) == 0
                Tracker_Adults{ii+1,2} = 1;
                Tracker_Adults{ii+1,3} = [];
            elseif Check(1,1) == 0 && Check(1,2) == 1
                Tracker_Adults{ii+1,2} = [];
                Tracker_Adults{ii+1,3} = 1;
            else
                Tracker_Adults{ii+1,2} = [];
                Tracker_Adults{ii+1,3} = [];
            end
        end
      
    disp('Saved data for ii =')    
    disp(ii)
    
    end

disp('Copying finished')
save('Tracker_AdultsIDs_min20trls.mat','Tracker_Adults')
