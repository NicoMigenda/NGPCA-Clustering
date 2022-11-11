%normalized mahalanobis distance
function [r, lambda_rest] = vconstpot(columns, m, y, eigenvalue, sigma, x_c, logArgMinLimit,k,r,Age,ageMax,DT,potentialFunction)
helper = y' * (y ./ eigenvalue);
%% n = m
if( columns == m )
    radius = (Age / ageMax)^(DT / m);
    switch potentialFunction
        case "NGPCA" 
            r(k, :) = [k, helper];
        case "NGPCA_withVolume" 
            r(k, :) = [k, helper + sum(log(eigenvalue))];
        case "Hoffmann"   
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/m)];
        case "Moeller"
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/m) * (Age / ageMax)^(2*DT / m)];
        case "Moeller_withVolume"
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/m) * (Age / ageMax)^(2*DT / m) + log( prod( eigenvalue *(Age / ageMax)^DT) )];
        case "Migenda"
            r(k, :) = [k, helper * (Age / ageMax)^(2 * DT/m)];
        case "Migenda_withVolume"
            r(k, :) = [k, helper * (Age / ageMax)^(2 * DT/m) + log( prod( eigenvalue * (Age / ageMax)^DT) )];
        case "Moeller_radius"
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/m) * radius^(2 / m)];
        case "Moeller_withVolume_radius"
            r(k, :) = [k, helper * sqrt(prod(eigenvalue))^(2/m) * radius^(2 / m) + log( prod( eigenvalue *(Age / ageMax)^DT) )];
        case "Migenda_radius"
            r(k, :) = [k, helper * radius^(2 / m)];
        case "Migenda_withVolume_radius"
            r(k, :) = [k, helper * radius^(2 / m) + log( prod( eigenvalue * (Age / ageMax)^DT) )];
    end   
    lambda_rest = 0;
%% m < n
else
    helper = y' * (y ./ eigenvalue);
    lambda_rest = sigma ./ (columns - m);
    if( lambda_rest <= 0.0 )
        lambda_rest = logArgMinLimit;
        %fprintf( 'lambda_rest: %e\n', lambda_rest );
    end  
    helper = helper + (1 ./ lambda_rest) * (x_c' * x_c - y' * y);
    dim = (columns - m);
    volume = sqrt(prod(eigenvalue)) * lambda_rest^dim;
    radius = (Age / ageMax)^(DT / m);
    switch potentialFunction
        case "NGPCA" 
            r(k, :) = [k, helper];
        case "NGPCA_withVolume" 
            r(k, :) = [k, helper + sum(log(eigenvalue)) + dim * log(lambda_rest)];
        case "Hoffmann"   
            r(k, :) = [k, helper * volume^(2/m)];
        case "Moeller"
            r(k, :) = [k, helper * volume^(2/m) * (Age / ageMax)^(2*DT / m)];
        case "Moeller_withVolume"
            dt = (Age / ageMax)^(2*DT / m);
            r(k, :) = [k, helper * volume^(2/m) * dt + log(prod( eigenvalue * dt/ volume ))  +  dim * log(lambda_rest *dt / volume) ];
        case "Migenda"
            r(k, :) = [k, helper * (Age / ageMax)^(2 * DT/m)];
        case "Migenda_withVolume"
            dt = (Age / ageMax)^(2*DT / m);
            r(k, :) = [k, helper * dt + log(prod( eigenvalue * dt ))  +  dim * log(lambda_rest *dt) ];
        case "Moeller_radius"
            dt = radius^(2 / m);
            r(k, :) = [k, helper * volume^(2/m) * dt];
        case "Moeller_withVolume_radius"
            dt = radius^(2 / m);
            r(k, :) = [k, helper * volume^(2/m) * dt + log(prod( eigenvalue * dt/ volume ))  +  dim * log(lambda_rest *dt / volume) ];
        case "Migenda_radius"
            r(k, :) = [k, helper * radius^(2 / m)];
        case "Migenda_withVolume_radius"
            dt = (Age / ageMax)^(2*DT / m^2);
            r(k, :) = [k, helper * dt + log(prod( eigenvalue * dt ))  +  dim * log(lambda_rest *dt) ];
    end  
end