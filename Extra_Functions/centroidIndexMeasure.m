function [CI] = centroidIndexMeasure(units, p)

%% CI_1
len = size(p.GT,1);
for z = 1:len
    x = p.GT(z,:);
    for k = 1:p.M
       units{k}.x_c = x' - units{k}.center;
       units{k}.y   = units{k}.weight' * units{k}.x_c; 
       [p.r, ~] = ...
       vconstTest(p.columns, units{k}.m, units{k}.y, units{k}.eigenvalue, units{k}.sigma, units{k}.x_c,p.logArgMinLimit,k,p.r);
    end
    p.r = sortrows(abs(p.r), 2);
    winner(z) = p.r(1,1);
end
for k = 1:p.M
   frequency(k) = sum(winner == k); % Zuordnung der Datenpunkte zu der jeweiligen Gewinner unit, sum(prop) = 1
end
CI_1 = sum(frequency == 0); 

%% CI_2
idx = 1;
id = fopen(p.pa);
while ~feof(id)
   tline = fgetl(id);
   if feof(id)
        break;
   end
   pa(idx) = str2num(tline);
   idx = idx + 1;
end

for k = 1 : p.M
    cluster_cov = cov(p.shape(pa == k,:));
    [eigenvectors{k},eigenvalues{k}] = eig(cluster_cov);
end

for k = 1:p.M
    for z = 1:len
        x = p.GT(z,:);
        x_c = units{k}.center - x';
        y   = eigenvectors{k}' * x_c; 
        [p.r, ~] = ...
        vconstTest(2, 2, y, diag(eigenvalues{k}), units{k}.sigma, x_c, p.logArgMinLimit, k, p.r);
    end
    p.r = sortrows(abs(p.r), 2);
    winner(z) = p.r(1,1);
end

for k = 1:p.M
   frequency(k) = sum(winner == k); % Zuordnung der Datenpunkte zu der jeweiligen Gewinner unit, sum(prop) = 1
end
CI_2 = sum(frequency == 0); 

CI = max(CI_1, CI_2);