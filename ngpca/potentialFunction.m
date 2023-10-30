function ranking = potentialFunction(unit,dataDimensionality, potentialFunction, rmax)

%% Basisterm that is always considered. For m < n the reconstruction error is added.
basisTerm = unit.y' * (unit.y ./ unit.eigenvalue);
if unit.m < dataDimensionality
    lambda_rest = unit.sigma / (dataDimensionality - unit.m);
    if( lambda_rest <= 0.0 )
        lambda_rest = eps;
    end  
    basisTerm = basisTerm + (1 ./ lambda_rest) * (unit.x_c' * unit.x_c - unit.y' * unit.y);
end

%% Desired volume / radius / alpha / beta control
adaptiveControl = rmax ^ (1 - min(unit.activity,1)); 
switch potentialFunction
    % (A)daptive (R)adius
    case "AR"
        control = adaptiveControl^(-2) * (prod(unit.eigenvalue))^(1/dataDimensionality);
        if unit.m < dataDimensionality
           control = control * lambda_rest^( (dataDimensionality - unit.m) / dataDimensionality);
        end
    % (N)o Control
    case "N"
        control = 1;
    % (A)djustable (V)olume
    case "AV"
        control = (adaptiveControl^(-2) * prod(unit.eigenvalue))^(1/dataDimensionality);
        if unit.m < dataDimensionality
          control = control * lambda_rest^( (dataDimensionality - unit.m) / dataDimensionality);
        end
    % (V)ariable (R)elative (V)olume 
    case "VRV"
        control = adaptiveControl^(-2/dataDimensionality);
    % (V)ariable (R)elative (R)adius
    case "VRR"
        control = adaptiveControl^(-2);
    % (H)offmann
    case "H"
        %control = sqrt(prod(unit.eigenvalue))^(2/dataDimensionality);
        if unit.m < dataDimensionality
            control = (prod(unit.eigenvalue) * lambda_rest^(dataDimensionality-unit.m))^(1/dataDimensionality);
        else
            control = (sqrt(prod(unit.eigenvalue)))^(2/dataDimensionality);
        end
end

%% Combine terms and calculate distance 
ranking = basisTerm * control;