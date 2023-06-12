function [DU,nmi] = NMI_DU(units, p)
%% NMI
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
len = size(pa,2);

for z = 1:len
    x = p.shape(z,:);
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
DU = sum(frequency == 0); 

nmi = normalizedmi(pa, winner);
