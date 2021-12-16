%% Plot MS maps in fieldtrip format
% This scripts takes the RAGU output and creates topoplots of the extracted
% microstates for each age group.

% created by Rianne Haartsen, June 2020

clear all

%add eeglab path
    addpath(genpath('%%path%%/MATLAB/eeglab14_1_2b')); 
    %add fieldtrip path and set to defaults
    addpath('%%path%%/MATLAB/fieldtrip-20180925'); 
    ft_defaults
    %add other paths needed
    
%% Get data from the MS maps
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

MinGFP = min(All_MSmaps20);
MinGFP = min(MinGFP);

MaxGFP = max(All_MSmaps20);
MaxGFP = max(MaxGFP);

%%

cd('%%path%%/LEAP_microstates/MS_data')
load %%% this needs to be a datasat named Data in fieldtrip format that will be used as a template

% Load names of channels of interest
load '%%path%%/ChoIs_MS.mat'
% Create data template
Data.fsample = 1000;
Data.label = ChoIs_MS;
Data.time = [];
Data.trial = [];
Data.trialinfo = 1;
Data.sampleinfo = [1, 1001];

Data.time{1,1} = -.2:.001:.8;

Chil_MS1 = Data;
Chil_MS1.trial{1,1} = repmat(Chil_MSmaps20(1,:)',[1,1001]);
Chil_MS1.avg = Chil_MS1.trial{1,1};

cfg = [];
cfg.highlight           = 'on';
cfg.markersymbol        = 'O';
cfg.highlightchannel    = {'P7','P8'};
cfg.layout              = 'EEG1005.lay';
cfg.zlim                = [-3.25, 3.25];
cfg.parameter           = 'avg'; % the default 'avg' is not present in the data
cfg.colorbar            = 'no';
cfg.comment             = 'no';
figure; ft_topoplotER(cfg,Chil_MS1); 


%% Plot all microstate maps

figure;

for map = 1:18
    
    MS_data = Data;
    MS_data.trial{1,1} = repmat(All_MSmaps20(:,map),[1,1001]);
    MS_data.avg = repmat(All_MSmaps20(:,map),[1,1001]);
    
    subplot(3,6,map)
    cfg = [];
    cfg.highlight           = 'on';
    cfg.markersymbol        = 'O';
    cfg.highlightchannel    = {'P7','P8'};
    cfg.layout              = 'EEG1005.lay';
    cfg.zlim                = [-3.25, 3.25];
    cfg.parameter           = 'avg'; % the default 'avg' is not present in the data
    cfg.colorbar            = 'no';
    cfg.comment             = 'no';
    cfg.colormap            = 'jet';
    ft_topoplotER(cfg,MS_data); 
%     title(strcat('MSmap ', num2str(map)))

end


figure
map = 1;
MS_data = Data;
MS_data.trial{1,1} = repmat(All_MSmaps20(:,map),[1,1001]);
MS_data.avg = repmat(All_MSmaps20(:,map),[1,1001]);

cfg = [];
cfg.highlight           = 'on';
cfg.markersymbol        = 'O';
cfg.highlightchannel    = {'P7','P8'};
cfg.layout              = 'EEG1005.lay';
cfg.zlim                = [-3.25, 3.25];
cfg.parameter           = 'avg'; % the default 'avg' is not present in the data
cfg.colorbar            = 'no';
cfg.comment             = 'no';
cfg.colormap            = 'jet';
ft_topoplotER(cfg,MS_data);

h = colorbar('SouthOutside');
ylabel(h, 'GFP (\muV)')









