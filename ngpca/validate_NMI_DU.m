function obj = validate_NMI_DU(obj, label, data)

len = size(data,1);
winner = zeros(len,1);
frequency = zeros(length(unique(label)),1);
for z = 1:len
    x = data(z,:);
    for k = 1:obj.numberUnits
       obj.units{k}.x_c = x' - obj.units{k}.center;
       obj.units{k}.y   = obj.units{k}.weight' * obj.units{k}.x_c; 
       obj.r(k,:) = [k, potentialFunction(obj.units{k},obj.dataDimensionality, "N", 0)];    
    end
    obj.r = sortrows(abs(obj.r), 2);
    winner(z) = obj.r(1,1);
end

for k = 1:obj.numberUnits
   frequency(k) = sum(winner == k); % Zuordnung der Datenpunkte zu der jeweiligen Gewinner unit, sum(prop) = 1
end
obj.DU = sum(frequency == 0); 
disp("DU:" + round(obj.DU,2))

obj.NMI = normalizedmi(label', winner);
disp("NMI:" + round(obj.NMI,2))
