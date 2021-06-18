function [CI_score,nmi] = centroidIndexMeasure(units, p)

%% Dead Units
len = size(p.GT,1);
for z = 1:len
    x = p.GT(z,:);
    for k = 1:p.N
       units{k}.x_c = x' - units{k}.center;
       units{k}.y   = units{k}.weight' * units{k}.x_c; 
       [p.r, ~] = ...
       vconstTest(p.columns, units{k}.outdimension, units{k}.y, units{k}.eigenvalue, units{k}.sigma, units{k}.x_c,p.logArgMinLimit,k,p.r);
    end
    p.r = sortrows(abs(p.r), 2);
    winner(z) = p.r(1,1);
end
for k = 1:p.N
   frequency(k) = sum(winner == k); % Zuordnung der Datenpunkte zu der jeweiligen Gewinner unit, sum(prop) = 1
end
CI_score = sum(frequency == 0); % Das ist eig. Deadunits?

for y = 1:size(units,1)
   x = units{y}.center'; 
   for z = 1 : len
       
   end
   
end

%% Orphan Clusters
% Für symetrie eigenschaft: Nicht die Clusterzentren den Units präsentieren
% sondern die units den clusterzentren und dann max funktion

%% NMI
if p.N == len
    nmi = normalizedmi([1:len], sort(winner));
else
%    nmi = normalizedmi(p.GT(:,1), sort(winner));
disp("error");
end

