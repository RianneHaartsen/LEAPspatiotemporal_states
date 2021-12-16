# LEAPspatiotemporal_states
Matlab code used for analysis of spatiotemporal brain states during face processing in the LEAP dataset

LEAP microstate analyses
These Matlab scripts were written for the purpose of examining spatiotemporal brain states during face processing in the EU-AIMS Longitudinal European Autism Project (LEAP (1)). Spatiotemporal brain states were derived and statistically tested using the Randomised Graphical User Interface (RAGU (2), vJune 2019). The scripts in this repository were used to present the stimuli, prepare the preprocessed averaged ERP for the RAGU analyses, visualisation of the results, and further analyses based on RAGU output. 

The Matlab scripts were written for the following purposes:
Stimulus presentation
1) Presentation of 1 trial with fixation stimulus, faces stimulus and a blank screen: faces_trial.m
2) Presentation of a block of trials in randomised order: faces_block.m

EEG data preprocessing
1) Reading in the preprocessed data from a Matlab table and converting them into text files suitable for RAGU: LEAPmicrostates_PrepareDataForRAGU.m

Visualising results from the RAGU output
1) Plot of the TANOVA and GFP results displayed in Figure 1 in the main text:  LEAPmicrostates_Plots_TANOVA_GFP.m
2) Topoplots of the microstates displayed in Figure 3 panels a, c, and e in the main text: LEAPmicrostates_Plots_MicrostateMaps.m

Further analyses
1) Extracting and organising the microstate features exported from RAGU: LEAPmicrostates_RAGUexport_to_Matlab.m
2) Correlations between face inversion effects for the number of trials and microstate features: LEAPmicrostates_FIE_Ntrials_MSf.m
3) Generating normative models and calculating overall deviance scores across all microstate features (also see SM 8): for the different age groups: 
a) LEAPmicrostates_NormativeModelling_Children.m,
b) LEAPmicrostates_NormativeModelling_Adolescents.m, and 
c) LEAPmicrostates_NormativeModelling_Adults.m, all calling to NormativeModeling_LEAP_Microstates.m for the normative modelling of the data
4) Exploring the similarities between the different microstate maps in the different age groups (also see SM 11): LEAPmicrostates_SimilaritiesMicrostateMaps.m
5) Testing associations between age and microstate features and overall deviance scores (also see SM 13): LEAPmicrostates_FIE_Age_MSf.m


References
1.	Loth, E. et al. The EU-AIMS Longitudinal European Autism Project (LEAP): design and methodologies to identify and validate stratification biomarkers for autism spectrum disorders. Mol. Autism 8, 27 (2017).
2.	Koenig, T., Kottlow, M., Stein, M. & Melie-García, L. Ragu: A Free Tool for the Analysis of EEG and MEG Event-Related Scalp Field Data Using Global Randomization Statistics. Comput. Intell. Neurosci. 2011, 1–14 (2011).


