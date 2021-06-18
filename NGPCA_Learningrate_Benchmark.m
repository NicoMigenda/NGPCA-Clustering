%% Änderungen am Algorithmus:
%{
Units nicht auf Datenpunkten der Verteilung initialisieren
Units nicht zufällig präsentieren
Adaptive Lernrate
Unit Split/Merge
Anpassung der Lernregel?
%}


%% Implementierung
close all
clear variables
addpath('data sets','helperFunctions');

reps = 10;
%% 0.1: PREALLOCATION AND INITIALIZATION
nmi_total = zeros(reps,1);
CI_score_total = zeros(reps,1);

%% Datasets
for dd = 8:10
    [shape, gt, number, dim, dataset] = pickDataset(dd);
    disp(["dd" dd])
    %% 32 LR + PT Function combinations
    for aa = 29:44
        disp(["aa" aa])
        [Method,expThreshold,potentialFunction] = DOE_DistanceMeasures(aa);
        parfor (OL = 1:reps,6)
            rng(OL)
            [Parameter, units] = init_benchmark (Method,expThreshold,potentialFunction,shape,number,dim,gt); 
            for loop = 1:Parameter.T  
                 %% 1: SET DATASET
                 if loop == 1 || loop == Parameter.Change
                     [Parameter, units] = set_data_distribution(Parameter,units,loop);
                 end
                 %% 2: DETERMINE UNIT RANKING ORDER
                 [Parameter, units] = unit_ranking_order(Parameter,units);
                 %% 3: UNIT ADAPTATION
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
                          imwrite(imind,cm,'NGPCAGIF.gif','gif', 'Loopcount',inf,'DelayTime',1); 
                      else 
                          imwrite(imind,cm,'NGPCAGIF.gif','gif','WriteMode','append','DelayTime',1); 
                      end 
                 end
                 if loop == Parameter.T
                     %% Testing vortex
                     %[nllh(2), deadUnits(2)] = testing(units, Parameter.Test, Parameter.N, Parameter.columns, Parameter.r);   
                     [CI_score,nmi] = centroidIndexMeasure(units, Parameter);
                 end
            end 
            nmi_total(OL) = nmi;
            CI_score_total(OL) = CI_score;
        end
        %% Save
        path = strcat('Results\', Method, '_', expThreshold, '\', dataset,'_',Method,'_',expThreshold,'_',potentialFunction);
        save(path ,'nmi_total','CI_score_total')
    end
end
