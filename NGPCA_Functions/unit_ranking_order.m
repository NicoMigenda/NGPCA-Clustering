function [p,units] = unit_ranking_order(p,units)
%-------------------------------------------------------------------------%
% SECOND PART OF MAIN LOOP: DETERMINE UNIT RANKING ORDER                  %
%-------------------------------------------------------------------------%
    % randomly select current input vector (stimulus)
    p.xvalue = ceil(p.rows .* rand);
    p.x = p.shape(p.xvalue, :)';
    
    % set lambdaSum and sigmaSum to zero; these variables are accumulated
    % in the following loop (required for unit reset heuristic)
    p.DtAllUnits = 0;
    p.Dsum = 0;
    
    % for each unit k...
    for k = 1:p.M
        
      % calculate neuron input and output (activation)
      units{k}.x_c = p.x - units{k}.center;
      units{k}.y   = units{k}.weight' * units{k}.x_c;
    
      % Potential Function
      [p.r(k,:), p.control(k)] = potentialFunctions(units{k},p,k);

      p.DtAllUnits = p.DtAllUnits + units{k}.epsilon;
      p.Dsum = p.Dsum + units{k}.D;
    end
    
    if p.LearningAlgo == "V"
        p.rho = (p.rho_init - p.rho_final) * p.DtAllUnits/p.M + p.rho_final;
    elseif p.LearningAlgo == "G"
        p.rho = (p.rho_init - p.rho_final) * sqrt(1/p.M * p.Dsum) + p.rho_final;    
    end

    % perform ranking (for the soft-competition between units)
    p.r = sortrows(p.r, 2);


