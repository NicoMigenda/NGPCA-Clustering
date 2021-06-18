%normalized mahalanobis distance
function [r, lambda_rest] = vconstpot(columns, outdimension, y, eigenvalue, sigma, x_c, logArgMinLimit,k,r,Age,ageMax,DT,potentialFunction)
helper = y' * (y ./ eigenvalue);
%% n = m
if( columns == outdimension )
    radius = (Age / ageMax)^(DT / outdimension);
    switch potentialFunction
        case "NGPCA" 
            r(k, :) = [k, helper];
        case "NGPCA_withVolume" 
            r(k, :) = [k, helper + sum(log(eigenvalue))];
        case "Hoffmann"   
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/outdimension)];
        case "Moeller"
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/outdimension) * (Age / ageMax)^(2*DT / outdimension)];
        case "Moeller_withVolume"
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/outdimension) * (Age / ageMax)^(2*DT / outdimension) + log( prod( eigenvalue *(Age / ageMax)^DT) )];
        case "Migenda"
            r(k, :) = [k, helper * (Age / ageMax)^(2 * DT/outdimension)];
        case "Migenda_withVolume"
            r(k, :) = [k, helper * (Age / ageMax)^(2 * DT/outdimension) + log( prod( eigenvalue * (Age / ageMax)^DT) )];
        case "Moeller_radius"
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/outdimension) * radius^(2 / outdimension)];
        case "Moeller_withVolume_radius"
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/outdimension) * radius^(2 / outdimension) + log( prod( eigenvalue *(Age / ageMax)^DT) )];
        case "Migenda_radius"
            r(k, :) = [k, helper * radius^(2 / outdimension)];
        case "Migenda_withVolume_radius"
            r(k, :) = [k, helper * radius^(2 / outdimension) + log( prod( eigenvalue * (Age / ageMax)^DT) )];
    end   
    lambda_rest = 0;
%% m < n
else
    helper = y' * (y ./ eigenvalue);
    lambda_rest = sigma ./ (columns - outdimension);
    if( lambda_rest <= 0.0 )
        lambda_rest = logArgMinLimit;
        %fprintf( 'lambda_rest: %e\n', lambda_rest );
    end  
    helper = helper + (1 ./ lambda_rest) * (x_c' * x_c - y' * y);
    dim = (columns - outdimension);
    volume = sqrt(prod(eigenvalue)) * lambda_rest^dim;
    radius = (Age / ageMax)^(DT / outdimension);
    switch potentialFunction
        case "NGPCA" 
            r(k, :) = [k, helper];
        case "NGPCA_withVolume" 
            r(k, :) = [k, helper + sum(log(eigenvalue)) + dim * log(lambda_rest)];
        case "Hoffmann"   
            r(k, :) = [k, helper * volume^(2/outdimension)];
        case "Moeller"
            r(k, :) = [k, helper * volume^(2/outdimension) * (Age / ageMax)^(2*DT / outdimension)];
        case "Moeller_withVolume"
            dt = (Age / ageMax)^(2*DT / outdimension);
            r(k, :) = [k, helper * volume^(2/outdimension) * dt + log(prod( eigenvalue * dt/ volume ))  +  dim * log(lambda_rest *dt / volume) ];
        case "Migenda"
            r(k, :) = [k, helper * (Age / ageMax)^(2 * DT/outdimension)];
        case "Migenda_withVolume"
            dt = (Age / ageMax)^(2*DT / outdimension);
            r(k, :) = [k, helper * dt + log(prod( eigenvalue * dt ))  +  dim * log(lambda_rest *dt) ];
        case "Moeller_radius"
            dt = radius^(2 / outdimension);
            r(k, :) = [k, helper * volume^(2/outdimension) * dt];
        case "Moeller_withVolume_radius"
            dt = radius^(2 / outdimension);
            r(k, :) = [k, helper * volume^(2/outdimension) * dt + log(prod( eigenvalue * dt/ volume ))  +  dim * log(lambda_rest *dt / volume) ];
        case "Migenda_radius"
            r(k, :) = [k, helper * radius^(2 / outdimension)];
        case "Migenda_withVolume_radius"
            dt = (Age / ageMax)^(2*DT / outdimension^2);
            r(k, :) = [k, helper * dt + log(prod( eigenvalue * dt ))  +  dim * log(lambda_rest *dt) ];
    end  
end