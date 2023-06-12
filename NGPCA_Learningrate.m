%% Changes made to the original NGPCA-Algorithm [Möller04]:
%{
1. Learningrate
    Original: Learningrate based on the assumption of a normal distribution
    in each dimension [Welsch10] or continuously declining learning rate
    Now: Adaptive unit specific variance-based larningratecontrol
2. Potentialfunction
    Original: Mahalanobis Distance or Normalized Mahalanobis Distance [Hoffmann04]
    Now: Adaptive volume/radius Mahalanobis Distance
3. Unit Initialisation:
    Original: Units are initialized on a random data point
    Now: Units are randomly initialized within the input space
%}

%% Cleaning & Add path
close all
clear variables
addpath('data sets','NGPCA_Functions','Extra_Functions', genpath('Results'));
% Set seed for reproducability
rng(1)

%% 0.1: PREALLOCATION AND INITIALIZATION
[Parameter, units] = Init; 
%% 1.0 NGPCA
for loop = 1:Parameter.N 
     %% 1.1: SET DATASET
     if loop == 1 && Parameter.plt == 1 || Parameter.Change == loop && Parameter.plt == 1
         [Parameter, units] = set_data_distribution(Parameter,units,loop);
     end
     %% 1.2: DETERMINE UNIT RANKING ORDER
     [Parameter, units] = unit_ranking_order(Parameter,units);
     %% 1.3: UNIT ADAPTATION
     [Parameter, units,k] = unit_adaptation(Parameter,units);   
     %% 0.2: DRAW CURRENT NETWORK STATE
     if(Parameter.plt == 1 && loop > 0 && mod(loop, Parameter.t_show) == 0)
        [Parameter, units] = drawupdate(Parameter,units,loop);
     end
     if loop == Parameter.N
     %% Testing
         CI = centroidIndexMeasure(units, Parameter);
         [DU_score,nmi] = NMI_DU(units, Parameter);
     end
     %% 1.4 Plot purpose
     for a = 1 : Parameter.M
        learningrate_plot(loop,a) = units{a}.epsilon;
        activity_plot(loop,a) = min(units{a}.activity,1);
        ybarplot(loop,a) = units{a}.y_bar(1);
        lbarplot(loop,a) = units{a}.l_bar(1);
     end
end 
%% Plots for Paper 
pause(0.001)
figure;
plot(learningrate_plot(:,1),'-')
hold on
plot(learningrate_plot(:,2),'--')
plot(learningrate_plot(:,3),'-.')
plot(learningrate_plot(:,4),'--.')
plot(learningrate_plot(:,5),':')
ylabel('$\epsilon$','Interpreter','latex')
xlabel('Datapoints','Interpreter','latex')
xlim([0, size(learningrate_plot,1)])
legend("PCA unit 1", "PCA unit 2", "PCA unit 3", "PCA unit 4", "PCA unit 5")
pause(0.001)

figure;
plot(activity_plot(:,1),'-')
hold on
plot(activity_plot(:,2),'--')
plot(activity_plot(:,3),'-.')
plot(activity_plot(:,4),'--.')
plot(activity_plot(:,5),':')
ylabel('activity','Interpreter','latex')
xlabel('Datapoints','Interpreter','latex')
xlim([0, size(activity_plot,1)])
legend("PCA unit 1", "PCA unit 2", "PCA unit 3", "PCA unit 4", "PCA unit 5",'Location','southeast')