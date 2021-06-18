function [nllh,deadUnits] = testing(units, testData, N, columns, r)
logArgMinLimit = 1e-323;
hh = (2 * pi)^(-units{1}.outdimension / 2);
len = length(testData);
winner = zeros(len,1);
allDistances = zeros(1,N);
probabilitiyGauss = zeros(len,N);
for z = 1:len
    x = testData(z,:);
    for k = 1:N
       units{k}.x_c = x' - units{k}.center;
       units{k}.y   = units{k}.weight' * units{k}.x_c; 
       [r, ~] = ...
       vconstTest(columns, units{k}.outdimension, units{k}.y, units{k}.eigenvalue, units{k}.sigma, units{k}.x_c,logArgMinLimit,k,r);
    end
    r = sortrows(abs(r), 2);
    for k = 1:N
       allDistances(r(r(:,1) == k,1)) = r(r(:,1) == k,2); 
    end
    winner(z) = r(1,1);
    probabilitiyGauss(z,:) = hh * exp( -.5 * allDistances);
end

for k = 1:N
   prop(k) = sum(winner == k) / len; % Zuordnung der Datenpunkte zu der jeweiligen Gewinner unit, sum(prop) = 1
end
%probabilityWeighted = sum(probabilitiyGauss) .* prop;
deadUnits = sum(prop == 0);
%nllh = -sum(log(probabilityWeighted(probabilityWeighted > 0)));

probabilityWeighted = sum((probabilitiyGauss .* prop)') ;
nllh = -sum(log(probabilityWeighted));
