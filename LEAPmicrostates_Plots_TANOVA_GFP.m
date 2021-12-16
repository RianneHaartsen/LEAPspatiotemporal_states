%% Figs Microstates LEAP => 20 trials, TANOVA and GFP top and bottom
% This scripts plots the findings of the TANOVA and GFP across the -200 to
% 800ms time window.

% created by Rianne Haartsen, June 2020

clear all

% add paths here

% figure dimensions
% FigDims = [1455 763 875 274]; % 1408 1060 669 209
% TANOVA colour
ColF = [0 0 .6]; %blue 0 .6 1 
% GFP colour
ColF_gfp =  [1 .6 0]; % orange 1 .6 0 .5[0.6350 0.0780 0.1840]; % red;



% information needed for plotting
% threshold for duration of sign results
    Info.DurThrs = struct;
    Info.DurThrs.Order = 'FaceDir_ClinGrp_Interaction';
    Info.DurThrsChildren.TANOVA = [57, 83, 58];
    Info.DurThrsChildren.GFP = [63, 96, 64];
    Info.DurThrsAdolescents.TANOVA = [59, 84, 58];
    Info.DurThrsAdolescents.GFP = [64, 124, 65];
    Info.DurThrsAdults.TANOVA = [60, 75, 64];
    Info.DurThrsAdults.GFP = [69, 108, 71];
% mean and stdev for N170 across P7/8
% children
    load('%%path%%/Children_N170vals_min20tpc.mat');
    N170_lats_P78 = mean([Children_min20_N170values.N170_Lat.Up.P7, Children_min20_N170values.N170_Lat.Up.P8, ...
        Children_min20_N170values.N170_Lat.Inv.P7, Children_min20_N170values.N170_Lat.Inv.P8],2);  
    Info.N170_Children = [mean(N170_lats_P78,1) std(N170_lats_P78)];
    clear N170_lats_P78
% adolescents
    load('%%path%%//Adolescents_N170vals_min20tpc.mat');
    N170_lats_P78 = mean([Adolescents_min20_N170values.N170_Lat.Up.P7, Adolescents_min20_N170values.N170_Lat.Up.P8, ...
        Adolescents_min20_N170values.N170_Lat.Inv.P7, Adolescents_min20_N170values.N170_Lat.Inv.P8],2);  
    Info.N170_Adolescents = [mean(N170_lats_P78,1) std(N170_lats_P78)];
    clear N170_lats_P78
% adults
    load('%%path%%//Adults_N170vals_min20tpc.mat');
    N170_lats_P78 = mean([Adults_min20_N170values.N170_Lat.Up.P7, Adults_min20_N170values.N170_Lat.Up.P8, ...
        Adults_min20_N170values.N170_Lat.Inv.P7, Adults_min20_N170values.N170_Lat.Inv.P8],2);  
    Info.N170_Adults = [mean(N170_lats_P78,1) std(N170_lats_P78)];
    clear N170_lats_P78
    clear Children_min20_N170values Adolescents_min20_N170values Adults_min20_N170values

% create figure
Tanova_GFP_results_plot = figure; 
% set(gcf,'position',FigDims,'MenuBar','none')
    
    
%% Children

% TANOVA %%%%%%%%%%%%%%
% get TANOVA data
ExpFile = '%%path%%/Children_TANOVAb_timepoints_results.txt';
TANOVA_results = importfile_RAGUtimes(ExpFile);
T_res = table2array(TANOVA_results);
T_res2 = [T_res(:,2)'; T_res(:,3)';T_res(:,4)'];
Dummy = zeros(size(T_res2,1),size(T_res2,2));
Dummy(T_res2 < .05) = 1;
Time = T_res(:,1)';

subplot(3,1,1)
% face effect
FaceEffect = [0 Dummy(1,:) 0];
    % find indices
    Diffs = diff(FaceEffect);
    Beg = find(Diffs == 1)';
    End = find(Diffs == -1)';
    if isequal(size(Beg,1), size(End,1))
        Inds_Face = [Beg End-1];
    else 
        error('Mismatch number of begin and end samples for face effect')
    end
    clear Diffs
% group effect
GrpEffect = [0 Dummy(2,:) 0];
    % find indices
    Diffs = diff(GrpEffect);
    Beg2 = find(Diffs == 1)';
    End2 = find(Diffs == -1)';
    if isequal(size(Beg2,1), size(End2,1))
        Inds_Grp = [Beg2 End2-1];
    else 
        error('Mismatch number of begin and end samples for group effect')
    end    
    clear Diffs
% interaction effect
IntEffect = [0 Dummy(3,:) 0];
    % find indices
    Diffs = diff(IntEffect);
    Beg3 = find(Diffs == 1)';
    End3 = find(Diffs == -1)';
    if isequal(size(Beg3,1), size(End3,1))
        Inds_Int = [Beg3 End3-1];
    else 
        error('Mismatch number of begin and end samples for interaction effect')
    end 
    clear Diffs Beg End Beg2 End2 Beg3 End3 
    
% plot the results    
    % origin and mean and std N170 lat
    plot([0 0],[0 4],'k') %plot origin
    hold on
    plot([500 500],[0 4],'k') %plot end of stimulus presentation
    N170mn_ms = Info.N170_Children(1,1)*1000;
    N170mn_std = Info.N170_Children(1,2)*1000;
    plot([N170mn_ms N170mn_ms],[0 4],'Color','k','LineWidth',1,'LineStyle','-')
    plot([N170mn_ms-N170mn_std N170mn_ms-N170mn_std],[0 4],'Color','k','LineWidth',1,'LineStyle','--')
    plot([N170mn_ms+N170mn_std N170mn_ms+N170mn_std],[0 4],'Color','k','LineWidth',1,'LineStyle','--')
%     % results lines
%     plot([-200 800],[.25 .25],'Color','k','LineWidth',.5,'LineStyle',':')
%     plot([-200 800],[.75 .75],'Color','k','LineWidth',.5,'LineStyle',':')
%     plot([-200 800],[1.75 1.75],'Color','k','LineWidth',.5,'LineStyle',':')
%     plot([-200 800],[2.25 2.25],'Color','k','LineWidth',.5,'LineStyle',':')
%     plot([-200 800],[3.25 3.25],'Color','k','LineWidth',.5,'LineStyle',':')
%     plot([-200 800],[3.75 3.75],'Color','k','LineWidth',.5,'LineStyle',':')
    % TANOVA results
    % face
    if ~isempty(Inds_Face)    
        for rr = 1:size(Inds_Face,1)
            BegX = Time(Inds_Face(rr,1)); EndX = Time(Inds_Face(rr,2));
            if (EndX - BegX) < Info.DurThrsChildren.TANOVA(1,1)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,3.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % group
    if ~isempty(Inds_Grp)    
        for rr = 1:size(Inds_Grp,1)
            BegX = Time(Inds_Grp(rr,1)); EndX = Time(Inds_Grp(rr,2));
            if (EndX - BegX) < Info.DurThrsChildren.TANOVA(1,2)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,2,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % interaction
    if ~isempty(Inds_Int)    
        for rr = 1:size(Inds_Int,1)
            BegX = Time(Inds_Int(rr,1)); EndX = Time(Inds_Int(rr,2));
            if (EndX - BegX) < Info.DurThrsChildren.TANOVA(1,3)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    

% GFP %%%%%%%%%%%%%%    
% get GFP data
ExpFile = '%%path%%//Children_GFPb_timepoints_results.txt';
GFP_results = importfile_RAGUtimes(ExpFile);
T_res = table2array(GFP_results);
T_res2 = [T_res(:,2)'; T_res(:,3)';T_res(:,4)'];
Dummy = zeros(size(T_res2,1),size(T_res2,2));
Dummy(T_res2 < .05) = 1;
Time = T_res(:,1)';

% face effect
FaceEffect = [0 Dummy(1,:) 0];
    % find indices
    Diffs = diff(FaceEffect);
    Beg = find(Diffs == 1)';
    End = find(Diffs == -1)';
    if isequal(size(Beg,1), size(End,1))
        Inds_Face = [Beg End-1];
    else 
        error('Mismatch number of begin and end samples for face effect')
    end
    clear Diffs
% group effect
GrpEffect = [0 Dummy(2,:) 0];
    % find indices
    Diffs = diff(GrpEffect);
    Beg2 = find(Diffs == 1)';
    End2 = find(Diffs == -1)';
    if isequal(size(Beg2,1), size(End2,1))
        Inds_Grp = [Beg2 End2-1];
    else 
        error('Mismatch number of begin and end samples for group effect')
    end    
    clear Diffs
% interaction effect
IntEffect = [0 Dummy(3,:) 0];
    % find indices
    Diffs = diff(IntEffect);
    Beg3 = find(Diffs == 1)';
    End3 = find(Diffs == -1)';
    if isequal(size(Beg3,1), size(End3,1))
        Inds_Int = [Beg3 End3-1];
    else 
        error('Mismatch number of begin and end samples for interaction effect')
    end 
    clear Diffs Beg End Beg2 End2 Beg3 End3 
    
    % GFP results
    % face
    if ~isempty(Inds_Face)    
        for rr = 1:size(Inds_Face,1)
            BegX = Time(Inds_Face(rr,1)); EndX = Time(Inds_Face(rr,2));
            if (EndX - BegX) < Info.DurThrsChildren.GFP(1,1)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,3,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % group
    if ~isempty(Inds_Grp)    
        for rr = 1:size(Inds_Grp,1)
            BegX = Time(Inds_Grp(rr,1)); EndX = Time(Inds_Grp(rr,2));
            if (EndX - BegX) < Info.DurThrsChildren.GFP(1,2)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,1.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % interaction
    if ~isempty(Inds_Int)    
        for rr = 1:size(Inds_Int,1)
            BegX = Time(Inds_Int(rr,1)); EndX = Time(Inds_Int(rr,2));
            if (EndX - BegX) < Info.DurThrsChildren.GFP(1,3)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,0,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % add titles etc
    ylim([0 4]); xlim([-200 800]);
    yticks([.25 .75 1.75 2.25 3.25 3.75])
    yticklabels({strcat('GFP Interaction (', num2str(Info.DurThrsChildren.GFP(1,3)),' ms)'),...
        strcat('TAN Interaction (', num2str(Info.DurThrsChildren.TANOVA(1,3)),' ms)'),...
        strcat('GFP Group (',num2str(Info.DurThrsChildren.GFP(1,2)),' ms)'),...
        strcat('TAN Group (',num2str(Info.DurThrsChildren.TANOVA(1,2)),' ms)'),...
        strcat('GFP Orientation (',num2str(Info.DurThrsChildren.GFP(1,1)),' ms)'),...
        strcat('TAN Orientation (',num2str(Info.DurThrsChildren.TANOVA(1,1)),' ms)')});
    xlabel('Time (ms)')

    
    
    
%% Adolescents

% TANOVA %%%%%%%%%%%%%%
% get TANOVA data
ExpFile = '%%path%%/Adolescents_TANOVAb_timepoints_results.txt';
TANOVA_results = importfile_RAGUtimes(ExpFile);
T_res = table2array(TANOVA_results);
T_res2 = [T_res(:,2)'; T_res(:,3)';T_res(:,4)'];
Dummy = zeros(size(T_res2,1),size(T_res2,2));
Dummy(T_res2 < .05) = 1;
Time = T_res(:,1)';

subplot(3,1,2)
% face effect
FaceEffect = [0 Dummy(1,:) 0];
    % find indices
    Diffs = diff(FaceEffect);
    Beg = find(Diffs == 1)';
    End = find(Diffs == -1)';
    if isequal(size(Beg,1), size(End,1))
        Inds_Face = [Beg End-1];
    else 
        error('Mismatch number of begin and end samples for face effect')
    end
    clear Diffs
% group effect
GrpEffect = [0 Dummy(2,:) 0];
    % find indices
    Diffs = diff(GrpEffect);
    Beg2 = find(Diffs == 1)';
    End2 = find(Diffs == -1)';
    if isequal(size(Beg2,1), size(End2,1))
        Inds_Grp = [Beg2 End2-1];
    else 
        error('Mismatch number of begin and end samples for group effect')
    end    
    clear Diffs
% interaction effect
IntEffect = [0 Dummy(3,:) 0];
    % find indices
    Diffs = diff(IntEffect);
    Beg3 = find(Diffs == 1)';
    End3 = find(Diffs == -1)';
    if isequal(size(Beg3,1), size(End3,1))
        Inds_Int = [Beg3 End3-1];
    else 
        error('Mismatch number of begin and end samples for interaction effect')
    end 
    clear Diffs Beg End Beg2 End2 Beg3 End3 
    
% plot the results    
    % origin and mean and std N170 lat
    plot([0 0],[0 4],'k') %plot origin
    hold on
    plot([500 500],[0 4],'k') %plot end of stimulus presentation
    N170mn_ms = Info.N170_Adolescents(1,1)*1000;
    N170mn_std = Info.N170_Adolescents(1,2)*1000;
    plot([N170mn_ms N170mn_ms],[0 4],'Color','k','LineWidth',1,'LineStyle','-')
    plot([N170mn_ms-N170mn_std N170mn_ms-N170mn_std],[0 4],'Color','k','LineWidth',1,'LineStyle','--')
    plot([N170mn_ms+N170mn_std N170mn_ms+N170mn_std],[0 4],'Color','k','LineWidth',1,'LineStyle','--')
    % TANOVA results
    % face
    if ~isempty(Inds_Face)    
        for rr = 1:size(Inds_Face,1)
            BegX = Time(Inds_Face(rr,1)); EndX = Time(Inds_Face(rr,2));
            if (EndX - BegX) < Info.DurThrsAdolescents.TANOVA(1,1)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,3.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % group
    if ~isempty(Inds_Grp)    
        for rr = 1:size(Inds_Grp,1)
            BegX = Time(Inds_Grp(rr,1)); EndX = Time(Inds_Grp(rr,2));
            if (EndX - BegX) < Info.DurThrsAdolescents.TANOVA(1,2)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,2,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % interaction
    if ~isempty(Inds_Int)    
        for rr = 1:size(Inds_Int,1)
            BegX = Time(Inds_Int(rr,1)); EndX = Time(Inds_Int(rr,2));
            if (EndX - BegX) < Info.DurThrsAdolescents.TANOVA(1,3)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end

% GFP %%%%%%%%%%%%%%    
% get GFP data
ExpFile = '%%path%%/Adolescents_GFPb_timepoints_results.txt';
GFP_results = importfile_RAGUtimes(ExpFile);
T_res = table2array(GFP_results);
T_res2 = [T_res(:,2)'; T_res(:,3)';T_res(:,4)'];
Dummy = zeros(size(T_res2,1),size(T_res2,2));
Dummy(T_res2 < .05) = 1;
Time = T_res(:,1)';

% face effect
FaceEffect = [0 Dummy(1,:) 0];
    % find indices
    Diffs = diff(FaceEffect);
    Beg = find(Diffs == 1)';
    End = find(Diffs == -1)';
    if isequal(size(Beg,1), size(End,1))
        Inds_Face = [Beg End-1];
    else 
        error('Mismatch number of begin and end samples for face effect')
    end
    clear Diffs
% group effect
GrpEffect = [0 Dummy(2,:) 0];
    % find indices
    Diffs = diff(GrpEffect);
    Beg2 = find(Diffs == 1)';
    End2 = find(Diffs == -1)';
    if isequal(size(Beg2,1), size(End2,1))
        Inds_Grp = [Beg2 End2-1];
    else 
        error('Mismatch number of begin and end samples for group effect')
    end    
    clear Diffs
% interaction effect
IntEffect = [0 Dummy(3,:) 0];
    % find indices
    Diffs = diff(IntEffect);
    Beg3 = find(Diffs == 1)';
    End3 = find(Diffs == -1)';
    if isequal(size(Beg3,1), size(End3,1))
        Inds_Int = [Beg3 End3-1];
    else 
        error('Mismatch number of begin and end samples for interaction effect')
    end 
    clear Diffs Beg End Beg2 End2 Beg3 End3 
      
    % GFP results
    % face
    if ~isempty(Inds_Face)    
        for rr = 1:size(Inds_Face,1)
            BegX = Time(Inds_Face(rr,1)); EndX = Time(Inds_Face(rr,2));
            if (EndX - BegX) < Info.DurThrsAdolescents.GFP(1,1)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,3,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % group
    if ~isempty(Inds_Grp)    
        for rr = 1:size(Inds_Grp,1)
            BegX = Time(Inds_Grp(rr,1)); EndX = Time(Inds_Grp(rr,2));
            if (EndX - BegX) < Info.DurThrsAdolescents.GFP(1,2)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,1.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % interaction
    if ~isempty(Inds_Int)    
        for rr = 1:size(Inds_Int,1)
            BegX = Time(Inds_Int(rr,1)); EndX = Time(Inds_Int(rr,2));
            if (EndX - BegX) < Info.DurThrsAdolescents.GFP(1,3)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,0,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end  
    % add titles etc
    ylim([0 4]); xlim([-200 800]);
    yticks([.25 .75 1.75 2.25 3.25 3.75])
    yticklabels({strcat('GFP Interaction (', num2str(Info.DurThrsAdolescents.GFP(1,3)),' ms)'),...
        strcat('TAN Interaction (', num2str(Info.DurThrsAdolescents.TANOVA(1,3)),' ms)'),...
        strcat('GFP Group (',num2str(Info.DurThrsAdolescents.GFP(1,2)),' ms)'),...
        strcat('TAN Group (',num2str(Info.DurThrsAdolescents.TANOVA(1,2)),' ms)'),...
        strcat('GFP Orientation (',num2str(Info.DurThrsAdolescents.GFP(1,1)),' ms)'),...
        strcat('TAN Orientation (',num2str(Info.DurThrsAdolescents.TANOVA(1,1)),' ms)')});
    xlabel('Time (ms)')
 
    
    
    
    
%% Adults

% TANOVA %%%%%%%%%%%%%%
% get TANOVA data
ExpFile = '%%path%%/Adults_TANOVAb_timepoints_results.txt';
TANOVA_results = importfile_RAGUtimes(ExpFile);
T_res = table2array(TANOVA_results);
T_res2 = [T_res(:,2)'; T_res(:,3)';T_res(:,4)'];
Dummy = zeros(size(T_res2,1),size(T_res2,2));
Dummy(T_res2 < .05) = 1;
Time = T_res(:,1)';

subplot(3,1,3)
% face effect
FaceEffect = [0 Dummy(1,:) 0];
    % find indices
    Diffs = diff(FaceEffect);
    Beg = find(Diffs == 1)';
    End = find(Diffs == -1)';
    if isequal(size(Beg,1), size(End,1))
        Inds_Face = [Beg End-1];
    else 
        error('Mismatch number of begin and end samples for face effect')
    end
    clear Diffs
% group effect
GrpEffect = [0 Dummy(2,:) 0];
    % find indices
    Diffs = diff(GrpEffect);
    Beg2 = find(Diffs == 1)';
    End2 = find(Diffs == -1)';
    if isequal(size(Beg2,1), size(End2,1))
        Inds_Grp = [Beg2 End2-1];
    else 
        error('Mismatch number of begin and end samples for group effect')
    end    
    clear Diffs
% interaction effect
IntEffect = [0 Dummy(3,:) 0];
    % find indices
    Diffs = diff(IntEffect);
    Beg3 = find(Diffs == 1)';
    End3 = find(Diffs == -1)';
    if isequal(size(Beg3,1), size(End3,1))
        Inds_Int = [Beg3 End3-1];
    else 
        error('Mismatch number of begin and end samples for interaction effect')
    end 
    clear Diffs Beg End Beg2 End2 Beg3 End3 
    
% plot the results    
    % origin and mean and std N170 lat
    plot([0 0],[0 4],'k') %plot origin
    hold on
    plot([500 500],[0 4],'k') %plot end of stimulus presentation
    N170mn_ms = Info.N170_Adults(1,1)*1000;
    N170mn_std = Info.N170_Adults(1,2)*1000;
    plot([N170mn_ms N170mn_ms],[0 4],'Color','k','LineWidth',1,'LineStyle','-')
    plot([N170mn_ms-N170mn_std N170mn_ms-N170mn_std],[0 4],'Color','k','LineWidth',1,'LineStyle','--')
    plot([N170mn_ms+N170mn_std N170mn_ms+N170mn_std],[0 4],'Color','k','LineWidth',1,'LineStyle','--')
    % TANOVA results
    % face
    if ~isempty(Inds_Face)    
        for rr = 1:size(Inds_Face,1)
            BegX = Time(Inds_Face(rr,1)); EndX = Time(Inds_Face(rr,2));
            if (EndX - BegX) < Info.DurThrsAdults.TANOVA(1,1)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,3.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % group
    if ~isempty(Inds_Grp)    
        for rr = 1:size(Inds_Grp,1)
            BegX = Time(Inds_Grp(rr,1)); EndX = Time(Inds_Grp(rr,2));
            if (EndX - BegX) < Info.DurThrsAdults.TANOVA(1,2)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,2,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % interaction
    if ~isempty(Inds_Int)    
        for rr = 1:size(Inds_Int,1)
            BegX = Time(Inds_Int(rr,1)); EndX = Time(Inds_Int(rr,2));
            if (EndX - BegX) < Info.DurThrsAdults.TANOVA(1,3)
                ColCur = [ColF .2];
            else
                ColCur = [ColF .8];
            end
           rectangle('Position',[BegX,.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end

% GFP %%%%%%%%%%%%%%    
% get GFP data
ExpFile = '%%path%%/Adults_GFPb_timepoints_results.txt';
GFP_results = importfile_RAGUtimes(ExpFile);
T_res = table2array(GFP_results);
T_res2 = [T_res(:,2)'; T_res(:,3)';T_res(:,4)'];
Dummy = zeros(size(T_res2,1),size(T_res2,2));
Dummy(T_res2 < .05) = 1;
Time = T_res(:,1)';

% face effect
FaceEffect = [0 Dummy(1,:) 0];
    % find indices
    Diffs = diff(FaceEffect);
    Beg = find(Diffs == 1)';
    End = find(Diffs == -1)';
    if isequal(size(Beg,1), size(End,1))
        Inds_Face = [Beg End-1];
    else 
        error('Mismatch number of begin and end samples for face effect')
    end
    clear Diffs
% group effect
GrpEffect = [0 Dummy(2,:) 0];
    % find indices
    Diffs = diff(GrpEffect);
    Beg2 = find(Diffs == 1)';
    End2 = find(Diffs == -1)';
    if isequal(size(Beg2,1), size(End2,1))
        Inds_Grp = [Beg2 End2-1];
    else 
        error('Mismatch number of begin and end samples for group effect')
    end    
    clear Diffs
% interaction effect
IntEffect = [0 Dummy(3,:) 0];
    % find indices
    Diffs = diff(IntEffect);
    Beg3 = find(Diffs == 1)';
    End3 = find(Diffs == -1)';
    if isequal(size(Beg3,1), size(End3,1))
        Inds_Int = [Beg3 End3-1];
    else 
        error('Mismatch number of begin and end samples for interaction effect')
    end 
    clear Diffs Beg End Beg2 End2 Beg3 End3 
    
    % GFP results
    % face
    if ~isempty(Inds_Face)    
        for rr = 1:size(Inds_Face,1)
            BegX = Time(Inds_Face(rr,1)); EndX = Time(Inds_Face(rr,2));
            if (EndX - BegX) < Info.DurThrsAdults.GFP(1,1)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,3,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % group
    if ~isempty(Inds_Grp)    
        for rr = 1:size(Inds_Grp,1)
            BegX = Time(Inds_Grp(rr,1)); EndX = Time(Inds_Grp(rr,2));
            if (EndX - BegX) < Info.DurThrsAdults.GFP(1,2)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,1.5,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end
    % interaction
    if ~isempty(Inds_Int)    
        for rr = 1:size(Inds_Int,1)
            BegX = Time(Inds_Int(rr,1)); EndX = Time(Inds_Int(rr,2));
            if (EndX - BegX) < Info.DurThrsAdults.GFP(1,3)
                ColCur = [ColF_gfp .2];
            else
                ColCur = [ColF_gfp .8];
            end
           rectangle('Position',[BegX,0,EndX - BegX, .5], 'FaceColor', ColCur, 'EdgeColor', ColCur);
        end
    end 
    
    % add titles etc
    ylim([0 4]); xlim([-200 800]);
    yticks([.25 .75 1.75 2.25 3.25 3.75])
    yticklabels({strcat('GFP Interaction (', num2str(Info.DurThrsAdults.GFP(1,3)),' ms)'),...
        strcat('TAN Interaction (', num2str(Info.DurThrsAdults.TANOVA(1,3)),' ms)'),...
        strcat('GFP Group (',num2str(Info.DurThrsAdults.GFP(1,2)),' ms)'),...
        strcat('TAN Group (',num2str(Info.DurThrsAdults.TANOVA(1,2)),' ms)'),...
        strcat('GFP Orientation (',num2str(Info.DurThrsAdults.GFP(1,1)),' ms)'),...
        strcat('TAN Orientation (',num2str(Info.DurThrsAdults.TANOVA(1,1)),' ms)')});
    xlabel('Time (ms)')
    
    