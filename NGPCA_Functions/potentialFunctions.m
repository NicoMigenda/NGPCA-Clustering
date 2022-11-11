function [ranking, control] = potentialFunctions(unit,p,k)

%% Basisterm that is always considered. For m < n the reconstruction error is added.
basisTerm = unit.y' * (unit.y ./ unit.eigenvalue);
if unit.m < p.columns
    lambda_rest = unit.sigma / (p.columns - unit.m);
    if( lambda_rest <= 0.0 )
        lambda_rest = p.logArgMinLimit;
    end  
    basisTerm = basisTerm + (1 ./ lambda_rest) * (unit.x_c' * unit.x_c - unit.y' * unit.y);
end

%% Desired volume / radius / alpha / beta control
adaptiveControl = p.rmax ^ (1 - min(unit.activity,1)); 
switch p.v_control
    % (A)daptive (R)adius
    case "AR"
        control = adaptiveControl^(-2) * (prod(unit.eigenvalue))^(1/p.columns);
        if unit.m < p.columns
           control = control * lambda_rest^( (p.columns - unit.m) / p.columns);
        end
    % (N)o Control
    case "N"
        control = 1;
    % (A)djustable (V)olume
    case "AV"
        control = (adaptiveControl^(-2) * prod(unit.eigenvalue))^(1/p.columns);
        if unit.m < p.columns
          control = control * lambda_rest^( (p.columns - unit.m) / p.columns);
        end
    % (V)ariable (R)elative (V)olume 
    case "VRV"
        control = adaptiveControl^(-2/p.columns);
    % (V)ariable (R)elative (R)adius
    case "VRR"
        control = adaptiveControl^(-2);
    % (H)offmann
    case "H"
        %control = sqrt(prod(unit.eigenvalue))^(2/p.columns);
        if unit.m < p.columns
            control = (prod(unit.eigenvalue) * lambda_rest^(p.columns-unit.m))^(1/p.columns);
        else
            control = (sqrt(prod(unit.eigenvalue)))^(2/p.columns);
        end
end

%% Log terms
% With Log-Term
if p.logTerms == "M"
    switch p.v_control
        case "N"
            logTerm = sum(log(unit.eigenvalue));
            if unit.m < p.columns
                logTerm = logTerm + (p.columns - unit.m) * log(lambda_rest);
            end
        case "AV"
            logTerm = 2 * log(adaptiveControl);
        case "AR"
            logTerm = 2 * p.columns * log(adaptiveControl);
        case "VRV"
            logTerm = 2 * log ( adaptiveControl ) + log(prod(unit.eigenvalue));
            if unit.m < p.columns
                logTerm = logTerm + (p.columns - unit.m) * log(lambda_rest);
            end
        case "VRR"
            logTerm = 2 * p.columns * log(adaptiveControl) + log(prod(unit.eigenvalue));
            if unit.m < p.columns
                logTerm = logTerm + (p.columns - unit.m) * log(lambda_rest);
            end
        case "H"
            logTerm = 0;
    end
% Without Log-Term
elseif p.logTerms == "G"
    logTerm = 0;
end

%% Combine terms and calculate distance 
ranking = [k, basisTerm * control + logTerm];

