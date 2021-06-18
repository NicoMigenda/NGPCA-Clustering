%normalized mahalanobis distance
function [r, lambda_rest] = vconstTest(columns, outdimension, y, eigenvalue, sigma, x_c, logArgMinLimit,k,r)
if columns == outdimension
    r(k, :) = [k, y' * (y ./ eigenvalue) ];
    lambda_rest = 0;
else
    %2. Formel Schenck Diss Seite 93 - Lambda Stern (Restvarianz)
    lambda_rest = sigma ./ (columns - outdimension);
    if lambda_rest <= 0.0 
        lambda_rest = logArgMinLimit;
        %fprintf( 'lambda_rest: %e\n', lambda_rest );
    end  
    % Volumenunabhängige Mahalnobisdistanz nach Gleichung 3.9 Schenck Diss
    r(k, :) = [k, ...
        (y' * (y ./ eigenvalue)) ...
         + (1 ./ lambda_rest) * (x_c' * x_c - y' * y)];
end


