function [Parameter,units] = init_benchmark (method, expThreshold,potentialFunction,shape,N,dim,gt)

%% Load Data Set
Parameter.shape = shape;
Parameter.GT = gt;

[Parameter.rows, Parameter.columns] = size(Parameter.shape);

%% Hyperparameter
% Number of ellipses
Parameter.N = N;
% Init Dimension
Parameter.StartDim = dim;
% Number of total iterationens
Parameter.T = 4 * Parameter.rows;
% Learning rate method
Parameter.LearningAlgo = method;
% only adapt units above exp_thresh (0.0 = soft clustering, 1.0 = hard clustering)
if expThreshold == "hard"
    Parameter.expThreshold = 1.0;
else
    Parameter.expThreshold = 0.0;
end
Parameter.potentialFunction = potentialFunction;

Parameter.randomPlacement = 1;

Parameter.Change = Parameter.T+1; %Parameter.T/2;
Parameter.phi = 2.0;
Parameter.mu = 0.005;
% plots the current state every t_show iteration steps
Parameter.plt = 0;
Parameter.t_show = 500;

%% Allocation
% number of time steps between unit reset
Parameter.t_resetCheck = 15;
% Learningrate
Parameter.epsilon_init = 1;
Parameter.epsilon_final = 0.01;
% Neighborhood range
Parameter.rho_init = 1.5; 
Parameter.rho_final = 0.02;
% initial variance
Parameter.lambda_init = 1500.0;
% Maximum Age of a cluster
Parameter.ageMax = Parameter.t_resetCheck * Parameter.N;
Parameter.xvalue = 0;
Parameter.x = 0;
Parameter.logArgMinLimit = 1e-323;
Parameter.udmLogBase = 10.0;
Parameter.log_precomp = log( Parameter.udmLogBase );
Parameter.DtAllUnits = 0 ;
Parameter.lambdaSum = 0;
Parameter.sigmaSum = 0;
Parameter.DtMax =  0.99;
Parameter.Dsum = 0;

%-------------------------------------------------------------------------%
% UNIT INITIALIZATION                                                     %
%-------------------------------------------------------------------------%

% init data structure for units
units = cell(Parameter.N, 1);

for k = 1:Parameter.N

    %Unit specific Output Dimension
    units{k}.outdimension = Parameter.StartDim;
    
    % init centers by choosing N data points at random 
    if Parameter.randomPlacement == 0
        units{k}.center = Parameter.shape(ceil(Parameter.rows .* rand), :)';
    elseif Parameter.randomPlacement == 1
        for i = 1 : Parameter.columns
            units{k}.center(i) = 2*(max(Parameter.shape(:,i)) - min(Parameter.shape(:,i)))*rand + 2*min(Parameter.shape(:,i));
        end
        units{k}.center = units{k}.center';
    end
        
    % first m principal axes (weights)
    % orhonormal (as needed by distance measure)        
    units{k}.weight = orth(rand(Parameter.columns, units{k}.outdimension));
    
    % first m eigenvalues                                
    units{k}.eigenvalue = repmat(Parameter.lambda_init, units{k}.outdimension, 1);
    
    % residual variance in the minor (d - m) eigendirections
    units{k}.sigma = Parameter.lambda_init;
    
    % deviation between input and center
    units{k}.x_c = zeros(Parameter.columns, 1);
    
    % unit output (activation) for input x_c
    units{k}.y = zeros(units{k}.outdimension, 1);
    
    % unit "age" (for unit reset heuristic)
    Parameter.allAges(k) = Parameter.ageMax;
    
    % unit matching measure
    units{k}.mt = zeros(units{k}.outdimension, 1);
    units{k}.b = zeros(units{k}.outdimension, 1);
    
    % unit summarized matching measure
    units{k}.Dt = Parameter.DtMax;
    units{k}.D = Parameter.DtMax;
    
    % adapt steps for this unit                       
    units{k}.t = 0;

    % global learning rate 
    units{k}.alpha = Parameter.epsilon_init;
    units{k}.epsilon = Parameter.epsilon_init;
    
    units{k}.x_c = zeros(Parameter.StartDim,1);
    units{k}.winnerCount = 1;
   
end

% init ranking-vector
Parameter.r = zeros(Parameter.N, 2);