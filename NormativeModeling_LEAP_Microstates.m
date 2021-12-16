function [NorMod_fig, DevScores] = NormativeModeling_LEAP_Microstates(MSdata, idx_ctr, Subj, Age, MSstr)

% This function runs the normative modeling on the control group and
% calculates the deviation from the normative model for each of the
% individuals with ASD, while correcting for age.

% input:
% - MSdata: microstate duration and mGFP for up and inverted conditions
% - indx_nt: index for subjects in the control group
% - subj: list of subjects
% - age: age variable used in the normative modeling

% output:
% - figure with plots of the data and histograms for the z-scores
% - DevScores: structure with Subj, age, and z-scores for microstates
% duration, mGFP for up and inverted conditions

% based on script from Luke Mason 
% calling to GPML Matlab Code version 4.2, available via http://www.gaussianprocess.org/gpml/code/matlab/doc/
% adapted by Rianne Haartsen: 28-05-20

%%

DevScores = struct();
DevScores.Subj = Subj(~idx_ctr);
DevScores.Up.Dur = [];
DevScores.Up.GFP = [];
DevScores.Inv.Dur = [];
DevScores.Inv.GFP = [];

NorMod_fig = figure;
set(gcf,'Position',[2 1 965 954],'Menubar','none');

%% Up - duration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% prepare NT data
    % get data for NT participants
        xc = Age(idx_ctr);
        yc = MSdata.Up.Dur(idx_ctr);
    %Make figure for controls
        sp11 = subplot(4,2,1);
  
% estimation of the model
        meanfunc = []; % empty: don't use a mean function

        covfunc = @covSEiso; % Squared Exponental covariance function
        ell=365; 
        sf=1;
        hyp.cov = log([ell;sf]);
        likfunc = @likGauss; sn = 1; hyp.lik = log(sn); % Gaussian likelihood

        nlml = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc);

        hyp = minimize(hyp, @gp, -1000, @infExact, meanfunc, covfunc, likfunc, xc, yc);
        z = linspace(min(xc), max(xc), 100)';
        [m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, z);
        f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
        fill([z; flipdim(z,1)], f, [7 7 7]/8);
        hold on;
        f = [m+sqrt(s2); flipdim(m-sqrt(s2),1)];
        fill([z; flipdim(z,1)], f, [5 5 5]/8)
        plot(z, m);
        h1 = plot(xc, yc, 'b+');
        xlabel('Age (years)','FontSize',12)
        ylabel('Up - duration (ms)','FontSize',12)
        title([MSstr],'FontSize',12)
        ax = gca; ax.FontSize = 12;
        hold on

% plot ASD
    xa = Age(~idx_ctr);
    ya = MSdata.Up.Dur(~idx_ctr);
    plot(xa, ya, '+r')
    
    [mp s2p] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, xa);
    za = (ya-mp)./sqrt(s2p);
    
    [mc s2c] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, xc);
    zc = (yc-mc)./sqrt(s2c);
    
 % plot counts  
    sp12 = subplot(4,2,2);
    M = ceil(max(abs(za)));
    edges = linspace(-M, M, 100);
    
    distC = histc(zc, edges);
    distP = histc(za, edges);
    
    b1 = bar(edges, [distC, distP]);
    set(b1(1),'FaceColor','b');
    set(b1(2),'FaceColor','r');
    legend('CTR', 'ASD')
    
    [h,p,k] = kstest2(distC,distP);
    title(['Two-sample Kolmogorov-Smirnov test: K=',num2str(k),' (p=',num2str(p),')'],'FontSize',12)
    xlabel('Z-score (deviation from TD norm)','FontSize',12)
    ylabel('Frequency','FontSize',12)
    ax = gca; ax.FontSize = 12;
    
% save the deviation scores for ASD
    DevScores.Up.Dur = za;
    
    clear xc yc xa ya za
    
    
    
    
%% Up - GFP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% prepare NT data
    % get data for NT participants
        xc = Age(idx_ctr);
        yc = MSdata.Up.GFP(idx_ctr);
        % set NaN values to 0;
        yc(isnan(yc)) = 0;
    % Make figure for controls
        sp21 = subplot(4,2,3);
  
% estimation of the model
        meanfunc = []; % empty: don't use a mean function

        covfunc = @covSEiso; % Squared Exponental covariance function
        ell=365; 
        sf=1;
        hyp.cov = log([ell;sf]);
        likfunc = @likGauss; sn = 1; hyp.lik = log(sn); % Gaussian likelihood

        nlml = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc);

        hyp = minimize(hyp, @gp, -1000, @infExact, meanfunc, covfunc, likfunc, xc, yc);
        z = linspace(min(xc), max(xc), 100)';
        [m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, z);
        f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
        fill([z; flipdim(z,1)], f, [7 7 7]/8);
        hold on;
        f = [m+sqrt(s2); flipdim(m-sqrt(s2),1)];
        fill([z; flipdim(z,1)], f, [5 5 5]/8)
        plot(z, m);
        h1 = plot(xc, yc, 'b+');
        xlabel('Age (years)','FontSize',12)
        ylabel('Up - GFP (\muV)','FontSize',12)
        title([MSstr],'FontSize',12)
        ax = gca; ax.FontSize = 12;
        hold on

% plot ASD
    xa = Age(~idx_ctr);
    ya = MSdata.Up.GFP(~idx_ctr);
    % set NaN values to 0;
    ya(isnan(ya)) = 0;
    plot(xa, ya, '+r')
    
    [mp s2p] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, xa);
    za = (ya-mp)./sqrt(s2p);
    
    [mc s2c] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, xc);
    zc = (yc-mc)./sqrt(s2c);
    
 % plot counts  
    sp22 = subplot(4,2,4);
    M = ceil(max(abs(za)));
    edges = linspace(-M, M, 100);
    
    distC = histc(zc, edges);
    distP = histc(za, edges);
    
    b1 = bar(edges, [distC, distP]);
    set(b1(1),'FaceColor','b');
    set(b1(2),'FaceColor','r');
    legend('CTR', 'ASD')
    
    [h,p,k] = kstest2(distC,distP);
    title(['Two-sample Kolmogorov-Smirnov test: K=',num2str(k),' (p=',num2str(p),')'],'FontSize',12)
    xlabel('Z-score (deviation from TD norm)','FontSize',12)
    ylabel('Frequency','FontSize',12)
    ax = gca; ax.FontSize = 12;
    
% save the deviation scores for ASD
    DevScores.Up.GFP = za;
    
    
    clear xc yc xa ya za
    
    
%% Inv - Duration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% prepare NT data
    % get data for NT participants
        xc = Age(idx_ctr);
        yc = MSdata.Inv.Dur(idx_ctr);
    % Make figure for controls
        sp31 = subplot(4,2,5);
  
% estimation of the model
        meanfunc = []; % empty: don't use a mean function

        covfunc = @covSEiso; % Squared Exponental covariance function
        ell=365; 
        sf=1;
        hyp.cov = log([ell;sf]);
        likfunc = @likGauss; sn = 1; hyp.lik = log(sn); % Gaussian likelihood

        nlml = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc);

        hyp = minimize(hyp, @gp, -1000, @infExact, meanfunc, covfunc, likfunc, xc, yc);
        z = linspace(min(xc), max(xc), 100)';
        [m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, z);
        f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
        fill([z; flipdim(z,1)], f, [7 7 7]/8);
        hold on;
        f = [m+sqrt(s2); flipdim(m-sqrt(s2),1)];
        fill([z; flipdim(z,1)], f, [5 5 5]/8)
        plot(z, m);
        h1 = plot(xc, yc, 'b+');
        xlabel('Age (years)','FontSize',12)
        ylabel('Inv - Duration (ms)','FontSize',12)
        title([MSstr],'FontSize',12)
        ax = gca; ax.FontSize = 12;
        hold on

% plot ASD
    xa = Age(~idx_ctr);
    ya = MSdata.Inv.Dur(~idx_ctr);
    plot(xa, ya, '+r')
    
    [mp s2p] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, xa);
    za = (ya-mp)./sqrt(s2p);
    
    [mc s2c] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, xc);
    zc = (yc-mc)./sqrt(s2c);
    
 % plot counts  
    sp32 = subplot(4,2,6);
    M = ceil(max(abs(za)));
    edges = linspace(-M, M, 100);
    
    distC = histc(zc, edges);
    distP = histc(za, edges);
    
    b1 = bar(edges, [distC, distP]);
    set(b1(1),'FaceColor','b');
    set(b1(2),'FaceColor','r');
    legend('CTR', 'ASD')
    
    [h,p,k] = kstest2(distC,distP);
    title(['Two-sample Kolmogorov-Smirnov test: K=',num2str(k),' (p=',num2str(p),')'],'FontSize',12)
    xlabel('Z-score (deviation from TD norm)','FontSize',12)
    ylabel('Frequency','FontSize',12)
    ax = gca; ax.FontSize = 12;
    
% save the deviation scores for ASD
    DevScores.Inv.Dur = za;    
    
    
    clear xc yc xa ya za
    
    
%% Inv - GFP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% prepare NT data
    % get data for NT participants
        xc = Age(idx_ctr);
        yc = MSdata.Inv.GFP(idx_ctr);
        % set NaN values to 0;
        yc(isnan(yc)) = 0;
    % Make figure for controls
        sp41 = subplot(4,2,7);
  
% estimation of the model
        meanfunc = []; % empty: don't use a mean function

        covfunc = @covSEiso; % Squared Exponental covariance function
        ell=365; 
        sf=1;
        hyp.cov = log([ell;sf]);
        likfunc = @likGauss; sn = 1; hyp.lik = log(sn); % Gaussian likelihood

        nlml = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc);

        hyp = minimize(hyp, @gp, -1000, @infExact, meanfunc, covfunc, likfunc, xc, yc);
        z = linspace(min(xc), max(xc), 100)';
        [m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, z);
        f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
        fill([z; flipdim(z,1)], f, [7 7 7]/8);
        hold on;
        f = [m+sqrt(s2); flipdim(m-sqrt(s2),1)];
        fill([z; flipdim(z,1)], f, [5 5 5]/8)
        plot(z, m);
        h1 = plot(xc, yc, 'b+');
        xlabel('Age (years)','FontSize',12)
        ylabel('Inv - GFP (\muV)','FontSize',12)
        title([MSstr],'FontSize',12)
        ax = gca; ax.FontSize = 12;
        hold on

% plot ASD
    xa = Age(~idx_ctr);
    ya = MSdata.Inv.GFP(~idx_ctr);
    % set NaN values to 0;
    ya(isnan(ya)) = 0;
    plot(xa, ya, '+r')
    
    [mp s2p] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, xa);
    za = (ya-mp)./sqrt(s2p);
    
    [mc s2c] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, xc, yc, xc);
    zc = (yc-mc)./sqrt(s2c);
    
 % plot counts  
    sp42 = subplot(4,2,8);
    M = ceil(max(abs(za)));
    edges = linspace(-M, M, 100);
    
    distC = histc(zc, edges);
    distP = histc(za, edges);
    
    b1 = bar(edges, [distC, distP]);
    set(b1(1),'FaceColor','b');
    set(b1(2),'FaceColor','r');
    legend('CTR', 'ASD')
    
    [h,p,k] = kstest2(distC,distP);
    title(['Two-sample Kolmogorov-Smirnov test: K=',num2str(k),' (p=',num2str(p),')'],'FontSize',12)
    xlabel('Z-score (deviation from TD norm)','FontSize',12)
    ylabel('Frequency','FontSize',12)
    ax = gca; ax.FontSize = 12;
    
% save the deviation scores for ASD
    DevScores.Inv.GFP = za;        
    
    
    clear xc yc xa ya za
    
    
 %% Link axes in the subplots
    linkaxes([sp11, sp21, sp31, sp41], 'x');
    linkaxes([sp11, sp31], 'y');
    linkaxes([sp21, sp41], 'y'); 
    linkaxes([sp12, sp22, sp32, sp42], 'x');
    linkaxes([sp12, sp22, sp32, sp42], 'y');

end