clear variables
close all

%% Variance - HARDCLUSTERING
method = "Variance_hard_";
datasets = ["s1";"s2";"s3";"s4";"a1";"a2";"a3";"b1";"b2";"b3";"u1";"h32";"h64";"h128";"h256"];
methods = [strcat(method, "NGPCA");strcat(method, "NGPCA_withVolume"); strcat(method, "Hoffmann");...
           strcat(method, "Moeller"); strcat(method, "Moeller_withVolume"); strcat(method, "Migenda"); strcat(method, "Migenda_withVolume")];
combinations = ["s1$_\text{nmi}$";"s1$_\text{CI}$";"s2$_\text{nmi}$";"s2$_\text{CI}$";"s3$_\text{nmi}$";"s3$_\text{CI}$";"s4$_\text{nmi}$";"s4$_\text{CI}$";...
                "a1$_\text{nmi}$";"a1$_\text{CI}$";"a2$_\text{nmi}$";"a2$_\text{CI}$";"a3$_\text{nmi}$";"a3$_\text{CI}$"; ...
                "b1$_\text{nmi}$";"b1$_\text{CI}$";"b2$_\text{nmi}$";"b2$_\text{CI}$";"b3$_\text{nmi}$";"b3$_\text{CI}$"; ...
                "u1$_\text{nmi}$";"u1$_\text{CI}$"; ...
                "h32$_\text{nmi}$";"h32$_\text{CI}$";"h64$_\text{nmi}$";"h64$_\text{CI}$";"h128$_\text{nmi}$";"h128$_\text{CI}$";"h256$_\text{nmi}$";"h256$_\text{CI}$";];
%% NGPCA
f = 1;
for i = 1: length(datasets)
    j=1;
    for k = 1 : length(methods)
        filename = strcat(datasets(i), '_', methods(k) );
        load (filename, 'CI_score_total', 'nmi_total');
        ci_mean = mean(CI_score_total(:,1));
        ci_std = std(CI_score_total(:,1));
        nmi_mean = mean(nmi_total(:,1));
        nmi_std = std(nmi_total(:,1));
        Variance_hard_NGPCA([f,f+1],[j,j+1]) = [nmi_mean, nmi_std; ci_mean, ci_std];
        j = j + 2;
    end
        f = f + 2;
end
outputVariable = Variance_hard_NGPCA;
for i = 1 : size(outputVariable,1)
    fprintf('%15s &',combinations(i)) 
    for j = 1 : size(outputVariable,2)
       if j < size(outputVariable,2)
         fprintf('%2.2f &',outputVariable(i,j)) 
       else
         fprintf('%2.2f \\\\',outputVariable(i,j))   
       end
    end 
    fprintf('\n')
end
