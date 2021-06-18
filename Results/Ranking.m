clear variables
close all

addpath('Variance_soft','Variance_hard','Gaussian_soft','Gaussian_hard');
datasets = ["s1";"s2";"s3";"s4";"a1";"a2";"a3";"b1";"b2";"b3";"u1";"h32";"h64";"h128";"h256";"h512";"h1024"];
% N0-M-V-S-V = "non-normalized, mixture, volume control, soft-clustering, variance"
% N1-G-N-H-G = "normalized, geometric, no control, hard clustering, gaussian"
header_o = ["N0-G-N-S-V"; "N0-M-N-S-V"; "N1-G-N-S-V"; "N1-G-V-S-V"; "N1-M-V-S-V"; "N0-G-V-S-V"; "N0-M-V-S-V";...
          "N0-G-N-H-V"; "N0-M-N-H-V"; "N1-G-N-H-V"; "N1-G-V-H-V"; "N1-M-V-H-V"; "N0-G-V-H-V"; "N0-M-V-H-V";...
          "N0-G-N-S-G"; "N0-M-N-S-G"; "N1-G-N-S-G"; "N1-G-V-S-G"; "N1-M-V-S-G"; "N0-G-V-S-G"; "N0-M-V-S-G";...
          "N0-G-N-H-G"; "N0-M-N-H-G"; "N1-G-N-H-G"; "N1-G-V-H-G"; "N1-M-V-H-G"; "N0-G-V-H-G"; "N0-M-V-H-G"];
for i = 1: length(datasets)
    f = 1;
    for j = 1 : 4
        if j == 1
            method = "Variance_soft_";
        elseif j == 2
            method = "Variance_hard_";
        elseif j == 3
            method = "Gaussian_soft_";
        elseif j == 4
            method = "Gaussian_hard_";
        end
        methods = [strcat(method, "NGPCA");strcat(method, "NGPCA_withVolume"); strcat(method, "Hoffmann");...
        strcat(method, "Moeller"); strcat(method, "Moeller_withVolume"); strcat(method, "Migenda"); strcat(method, "Migenda_withVolume");...
        strcat(method, "Moeller_radius"); strcat(method, "Moeller_withVolume_radius"); ...
        strcat(method, "Migenda_radius");strcat(method, "Migenda_withVolume_radius")];
        for k = 1 : length(methods)
            filename = strcat(datasets(i), '_', methods(k) );
            load (filename, 'CI_score_total', 'nmi_total');
            header(f) = splitter(filename);
            
            ci_mean = mean(CI_score_total(:,1));
            nmi_mean = mean(nmi_total(:,1));
            results_nmi(f,i) = nmi_mean;
            results_nmi_std(f,i) = std(nmi_total(:,1));
            results_ci (f,i) = ci_mean;
            results_ci_std(f,i) = std(CI_score_total(:,1));
            f = f+1;
        end
    end
end

%% NMI Ranking
clear ranking
for i = 1 : length(datasets)
    data_sorted = sort(results_nmi(:,i),'descend');
    [~, rnk] = ismember(results_nmi(:,i),data_sorted);
    ranking(:,i) = rnk; 
end
ranking(:,end+1) = mean(ranking');
[~,b] = sort (ranking(:,end));
rankingSorted = ranking(b,:);
headerSorted = header(b);
headerBinarySorted = [(1:length(headerSorted)),headerSorted];

fprintf('NMI-Results \n &');
fprintf('{%4s} &',datasets);
fprintf('{Avg.} \\\\');
fprintf('\n \\midrule \n')
for i = 1 : size(rankingSorted,1)
    fprintf('%10s &', headerSorted(i)) 
    for j = 1 : size(rankingSorted,2)
       if j < size(rankingSorted,2)
           if rankingSorted(i,j) == 1
               fprintf('\\bfseries %1.0f &',rankingSorted(i,j)) 
           else
               fprintf('%2.0f &',rankingSorted(i,j)) 
           end
       else
         x = mean(rankingSorted(i,:));
         fprintf('%2.2f \\\\',x)   
       end
    end
    fprintf('\n')
end

%% Tabellen 4-7 in Ranking Reihenfolge
sortierer = b;
sorted_results_nmi = results_nmi(b,:);
sorted_nmi_std = results_nmi_std(b,:);

fprintf('{Nomenclature} &');
fprintf(' {%4s} &',datasets);
fprintf('{Avg.} \\\\');
fprintf('\n \\midrule \n')
for i = 1 : size(sorted_results_nmi,1)
    fprintf('{%10s} &', headerSorted(i)) 
    for j = 1 : size(sorted_results_nmi,2)
        if j < size(sorted_results_nmi,2)
            fprintf('%1.2f & ',sorted_results_nmi(i,j)) 
        else
            fprintf('%1.2f & %1.2f \\\\',sorted_results_nmi(i,j), mean(sorted_results_nmi(i,:))) 
        end
    end
    fprintf('\n')
end

%% CI Ranking
clear ranking
for i = 1 : length(datasets)
    data_sorted = sort(results_ci(:,i));
    [~, rnk] = ismember(results_ci(:,i),data_sorted);
    ranking(:,i) = rnk; 
end
ranking(:,end+1) = mean(ranking');
[~,b] = sort (ranking(:,end));
rankingSorted = ranking(b,:);
headerSorted = header(b);
headerBinarySorted = [headerBinarySorted,headerSorted];

fprintf('CI-Results \n & ');
fprintf('{%4s} &',datasets);
fprintf('{Avg.} \\\\');
fprintf('\n \\midrule \n')
for i = 1 : size(rankingSorted,1)
    fprintf('%10s &',headerSorted(i)) 
    for j = 1 : size(rankingSorted,2) 
       if j < size(rankingSorted,2)
           if rankingSorted(i,j) == 1
                fprintf('\\bfseries %1.0f &',rankingSorted(i,j)) 
           else
                fprintf('%2.0f &',rankingSorted(i,j)) 
           end
       else
         x = mean(rankingSorted(i,:));
         fprintf('%2.2f \\\\',x)   
       end
    end
    fprintf('\n')
end

%% Tabelle 4-7 DU
sortierer = b;
sorted_results_ci = results_ci(b,:);
sorted_ci_std = results_ci_std(b,:);

fprintf('{Nomenclature} &');
fprintf(' {%4s} &',datasets);
fprintf('{Avg.} \\\\');
fprintf('\n \\midrule \n')
for i = 1 : size(sorted_results_ci,1)
    fprintf('{%10s} &', headerSorted(i)) 
    for j = 1 : size(sorted_results_ci,2)
        if j < size(sorted_results_ci,2)
            fprintf('%1.2f & ',sorted_results_ci(i,j)) 
        else
            fprintf('%1.2f & %1.2f \\\\',sorted_results_ci(i,j),mean(sorted_results_ci(i,:))) 
        end
    end
    fprintf('\n')
end

%% Rank Correlation
% 'Type','Pearson','Kendall','Spearman'
for i = 1: 28
    for j = 1: 28
        if headerBinarySorted(i,2) == headerBinarySorted(j,3)
            headerBinarySorted(i,4) =  j;
        end
    end
end

corr(double([headerBinarySorted(:,1)'; headerBinarySorted(:,4)']))
%% Spider Plot Top 7 NMI
index = b([1:4 end-2:end]);
close all
s = spider_plot_class(results_nmi(index,:),...
                  'AxesLabels', cellstr(datasets)',...
                   'AxesFont', 'Times New Roman',...
                   'LabelFont', 'Times New Roman', 'AxesDisplay', 'one',... 
                   'LineWidth', [0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75 ], 'Marker', 'none');
drawnow;
s.AxesLimits = [1.000000e-02*zeros(1,15); 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
s.LegendLabels = cellstr(header(index));
s.LegendHandle.Location = 'northeastoutside';
s.LegendHandle.FontName = 'Times New Roman';
%export_fig nmi_spider -pdf -transparent


%% NMI mean ranked ( mean aller NMI eines Verfahrens bestimmen und dann den mit dem höchsten Mean NMI )
means = mean(results_nmi,2);
[sortedMeans,ranking] = sort(means, 'descend');
rankedHeaders = header(ranking);

%% Spider Plot Top 7 CI
% index = [11 12 18 19 22 8 23];
% 
% s = spider_plot_class(results_ci(index,:),...
%                   'AxesLabels', cellstr(datasets)');
% s.AxesLimits = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0; 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
% s.LegendLabels = cellstr(header(index))';
% s.LegendHandle.Location = 'northeastoutside';
% export_fig ci_spider -pdf -transparent