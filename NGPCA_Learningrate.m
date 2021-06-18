%% Changes made to the original NGPCA-Algorithm [Möller04]:
%{
1. Unit Initialisation:
    Original: Units are initialized on a random data point
    Now: Units are randomly initialized within the input space
2. Learningrate
    Original: Learningrate based on the assumption of a normal distribution in each dimension [Welsch10]
    Now: Adaptive variance-based larningratecontrol
3. Distancefunction
    Original: Normalized Mahalanobis Distance [Hoffmann04]
    Now: Adaptive volume contralable Mahalanobis Distance
%}

%% Cleaning & Add path
close all
clear variables
addpath('data sets','helperFunctions');
rng(2)

%% 0.1: PREALLOCATION AND INITIALIZATION
[Parameter, units] = Init; 
%% 1.0 NGPCA
for loop = 1:Parameter.T  
     %% 1.1: SET DATASET
     if loop == 1 || loop == Parameter.Change
         [Parameter, units] = set_data_distribution(Parameter,units,loop);
     end
     %% 1.2: DETERMINE UNIT RANKING ORDER
     [Parameter, units] = unit_ranking_order(Parameter,units);
     %% 1.3: UNIT ADAPTATION
     [Parameter, units,k] = unit_adaptation(Parameter,units,loop);   
     %% 4: UNIT RESET HEURISTIC   
%          if( mod(loop, Parameter.t_resetCheck) == 0)   
%             [minVal, minIndex] = min( Parameter.allAges );
%             if minVal < 0
%               [Parameter, units] = unit_reset(Parameter,units,minIndex);
%             end
%          end
     %% 0.2: DRAW CURRENT NETWORK STATE
      if(Parameter.plt == 1 && loop > 0 && mod(loop, Parameter.t_show) == 0)
        [Parameter, units] = drawupdate(Parameter,units,loop);
          % Write to the GIF File 
              frame = getframe(Parameter.handler); 
              im = frame2im(frame); 
              [imind,cm] = rgb2ind(im,256); 
              if loop == Parameter.t_show 
              %    imwrite(imind,cm, strcat(Parameter.filename(1:2), '_NGPCAGIF.gif'), 'gif', 'Loopcount',inf,'DelayTime',1); 
              else 
              %    imwrite(imind,cm,strcat(Parameter.filename(1:2), '_NGPCAGIF.gif'),'gif','WriteMode','append','DelayTime',1); 
              end 
              if loop == Parameter.T 
                  export_fig(strcat('Results\gifs\',string(loop),'_',Parameter.filename(1:2)), '-pdf', '-transparent')
              end
     end
     %% 1.4 Testing; only after last training sample
     if loop == Parameter.T      
         [deadUnits,nmi] = centroidIndexMeasure(units, Parameter);
     end
end 