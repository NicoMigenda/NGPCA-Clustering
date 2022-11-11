%normalized mahalanobis distance
function [r, lambda_rest] = vconstTest(columns, m, y, eigenvalue, sigma, x_c, logArgMinLimit,k,r)
if columns == m
    r(k, :) = [k, y' * (y ./ eigenvalue)];
    lambda_rest = 0;
else
    lambda_rest = sigma ./ (columns - m);
    if lambda_rest <= 0.0 
        lambda_rest = logArgMinLimit;
    end  
    r(k, :) = [k, ...
        (y' * (y ./ eigenvalue)) ...
         + (1 ./ lambda_rest) * (x_c' * x_c - y' * y)];
end


