function obj = validate_CI(obj, gt, eigenvalues, eigenvectors)

%% CI_1
len = size(gt,1);
winner = zeros(len,1);
frequency = zeros(len,1);
for z = 1:len
    % Take one ground truth cluster center and calculcate the distances to
    % all units given the units eigenvalue and eigenvector
    x = gt(z,:);
    for k = 1:obj.numberUnits
       obj.units{k}.x_c = x' - obj.units{k}.center;
       obj.units{k}.y   = obj.units{k}.weight' * obj.units{k}.x_c; 
       obj.r(k,:) = [k, potentialFunction(obj.units{k},obj.dataDimensionality, "N", 0)];
    end
    obj.r = sortrows(abs(obj.r), 2);
    winner(z) = obj.r(1,1);
end
for k = 1:obj.numberUnits
   frequency(k) = sum(winner == k);
end
CI_1 = sum(frequency == 0); 

%% CI_2
winner = zeros(len,1);
frequency = zeros(len,1);
for k = 1:obj.numberUnits
    % Take one unit center and calculcate the distance to all ground truth
    % centers given the eigenvalue and eigenvector of the respective ground
    % truth cluster
    x = obj.units{k}.center;
    for z = 1:len
        x_c = x - gt(z,:)';
        y   = eigenvectors{z}' * x_c; 
        obj.r(z, :) = [z, y' * (y ./ diag(eigenvalues{z}))];
    end
    obj.r = sortrows(abs(obj.r), 2);
    winner(k) = obj.r(1,1);
end

for k = 1:obj.numberUnits
   frequency(k) = sum(winner == k);
end
CI_2 = sum(frequency == 0); 

obj.CI = max(CI_1, CI_2);
disp("CI:" + round(obj.CI,2))

