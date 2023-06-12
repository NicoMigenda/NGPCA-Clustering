function [Parameter,units] = Init

%% Load Data Set
Parameter.filename = 's1_with_gt.mat';
load(Parameter.filename,'data','gt');
Parameter.shape = data;
Parameter.GT = gt;
Parameter.pa = 's1-label.pa';

%Parameter.filename = 's1_with_gt.mat';
%load(Parameter.filename,'data','gt');
%Parameter.shape_two = data;
%Parameter.GT_two = gt;

%Parameter.filename = 'rls.mat';
%Parameter.shape = load('rls.mat', '-ASCII' );%data;%vortex(6*pi, 120, 20, 2000);%;
%Parameter.GT = mean(Parameter.shape);

%Parameter.shape_two = vortex(6*pi, 120, 20, 4000);
%Parameter.GT_two = mean(Parameter.shape_two);

%% NGPCA Parameter
% Number of units
Parameter.M = size(Parameter.GT,1);
% Unit Dimension
Parameter.StartDim = 2;
% Number of total iterationens
Parameter.N = length(Parameter.shape) * 4;
Parameter.Change = Parameter.N+1;
% Potentialfunction 
Parameter.logTerms = "G";    %"G" = Gaussian      , "M" = Mixture
Parameter.v_control = "AR";  %"AV" = (A)djustable (V)olume, "VRV" = (V)artiable (R)elative (V)olume, "AR" = (A)daptive (R)adius, "VRR" = (V)ariable (R)elative (R)adius "N" = No control
Parameter.c_type = "S";      %"H" = Hardclustering, "S" = Softclustering
Parameter.LR = "V";          %"V" = Variance      , "G" = Gaussian
% Learningrate for [Welsch10]
Parameter.epsilon_init = 0.99;
Parameter.epsilon_final = 0.01;
% Activity 
Parameter.activity = 1;
% Neighborhood range
Parameter.rho_init = 1;
Parameter.rho_final = 0.02;
% initial variance
Parameter.lambda_init = 1.5;
% Learningrate constants
Parameter.mu = 0.005;
Parameter.rmax = 200;

%% Plot Parameter
Parameter.plt = 1;
Parameter.t_show = 100;
Parameter.makeGIF = 0; % Requires plt to be 1 

%-------------------------------------------------------------------------%
% MEMORY ALLOCATION                                                       %
%-------------------------------------------------------------------------%
Parameter = memAloc(Parameter);

%-------------------------------------------------------------------------%
% UNIT INITIALIZATION                                                     %
%-------------------------------------------------------------------------%
[Parameter, units] = unitInit(Parameter);

