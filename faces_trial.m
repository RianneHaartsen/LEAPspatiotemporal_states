function [ logOut ] = faces_trial( pres,track,log,vars,varNames,curSample )
% changelog
% 28/04/14  -   changed blank screen duration from fixed 350ms to random
%               350 - 650ms. 
funVersion = '002';
varNames = ['Version', varNames];
vars = [funVersion, vars];

% convert variables into a struct, for ease of access
design=cell2struct(vars,varNames,2);
design.TrialNo=curSample;

% check if the presenter is in the correct state
if isempty(pres)
    error('Empty presenter object passed.')
end

if ~pres.ScreenOpen
    error('The passed presenter object does not have an open screen. Use ECKPresenter.InitialiseDisplay first.')
end

%% DESIGN

trialOnsetTime  =   GetSecs;

% look up images
switch design.Fixation
    case 'ICON'
        fixImg  =   ECKLookupRandomObject(pres.Images, 'ICON');
    case 'FLAG'
        fixImg  =   ECKLookupRandomObject(pres.Images, 'FLAG');
end

faceImg         =   ECKLookupObject(pres.Images, design.Face);

if pres.WindowLimitEnabled
    width       =   pres.WindowWidthLimitCm;
    height      =   pres.WindowHeightLimitCm;
else
    width       =   pres.WindowWidthCm;
    height      =   pres.WindowHeightCm;
end

x               =   width / 2;
y               =   height /2;
fps             =   1 / pres.FlipInterval;

fixMin          =   .5;
fixMax          =   .7;
fixDur          =   fixMin + (rand * (fixMax - fixMin));
fixWidth        =   4;
fixHeight       =   fixWidth / fixImg.AspectRatio;
fixRect         =   [x - (fixWidth / 2), y - (fixHeight / 2),...
                    x + (fixWidth / 2), y + (fixHeight / 2)];
fixRotFrame     =   360 / fps;
fixRot          =   0;

faceDur         =   .5;
faceWidth       =   13;
faceHeight      =   faceWidth / faceImg.AspectRatio;
faceRect        =   [x - (faceWidth / 2), y - (faceHeight / 2),...
                    x + (faceWidth / 2), y + (faceHeight / 2)];
              
blankDurMin     =   .35;
blankDurMax     =   .65;
blankDur        =   blankDurMin + (rand * (blankDurMax - blankDurMin));

% sync EEG
pres.EEGSync

% set up trial
pres.BackColour=[120 120 120];
pres.RefreshDisplay;
pres.KeyUpdate;

trialOnsetTime = GetSecs;

% determine orientation
switch design.Orientation
    case 'UPRIGHT'
        faceRot =   0;
    case 'INVERTED'
        faceRot =   180;
end

%% FIXATION
pres.KeyUpdate;
pres.EEGSendEvent(design.FixEEGCode);
while GetSecs - trialOnsetTime < fixDur 
    
    pres.DrawImage(fixImg, fixRect, fixRot);
    pres.RefreshDisplay;
    
%     fixRot      =   fixRot + fixRotFrame;
%     if fixRot >= 360, fixRot = 0; end
    
end
correct         =   (strcmpi(design.Fixation, 'FLAG') && pres.KeyPressed) ||...
                        strcmpi(design.Fixation, 'ICON');
    
%% FACE
pres.EEGSendEvent(design.FaceEEGCode);
while GetSecs - trialOnsetTime - fixDur < faceDur 
    
    pres.DrawImage(faceImg, faceRect, faceRot);
    pres.RefreshDisplay;
    
end

%% BLANK
pres.EEGSendEvent(229);
pres.RefreshDisplay;
WaitSecs(blankDur);

trialOffsetTime = GetSecs;

logOut.Data=horzcat({...
    num2str(trialOnsetTime),...
    num2str(trialOffsetTime)...
    },vars);

logOut.Headings=horzcat({...
    'TrialOnsetTime',...
    'TrialOffsetTime',...  
    }, varNames);
end

