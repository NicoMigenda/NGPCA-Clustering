function [learningAlgo, logTerms, control, expThreshold] = DOE_DistanceMeasures(i)

%"V" = Variance      , "G" = Gaussian
%"H" = Hardclustering, "S" = Softclustering
%Immer ohne log Term "G"
%"AR" = (A)daptive (R)adius, "VRR" = (V)ariable (R)elative (R)adius, "N" = No control, "H" = Hoffmann
logTerms = "G";
switch i
    case 1
        expThreshold = "hard";
        control = "AR";
        learningAlgo = "V";
    case 2
        expThreshold = "hard";
        control = "VRR";
        learningAlgo = "V";
    case 3
        expThreshold = "hard";
        control = "N";
        learningAlgo = "V";
    case 4
        expThreshold = "hard";
        control = "H";
        learningAlgo = "V";
    case 5
        expThreshold = "hard";
        control = "AR";
        learningAlgo = "G";
    case 6
        expThreshold = "hard";
        control = "VRR";
        learningAlgo = "G";
    case 7
        expThreshold = "hard";
        control = "N";
        learningAlgo = "G";
    case 8
        expThreshold = "hard";
        control = "H";
        learningAlgo = "G";
    case 9
        expThreshold = "soft";
        control = "AR";
        learningAlgo = "V";
    case 10
        expThreshold = "soft";
        control = "VRR";
        learningAlgo = "V";
    case 11
        expThreshold = "soft";
        control = "N";
        learningAlgo = "V";
    case 12
        expThreshold = "soft";
        control = "H";
        learningAlgo = "V";
    case 13
        expThreshold = "soft";
        control = "AR";
        learningAlgo = "G";
    case 14
        expThreshold = "soft";
        control = "VRR";
        learningAlgo = "G";
    case 15
        expThreshold = "soft";
        control = "N";
        learningAlgo = "G";
    case 16
        expThreshold = "soft";
        control = "H";
        learningAlgo = "G";

end
%     case 1
%         potentialFunction = "NGPCA";
%         expThreshold = "hard";
%         Method = "Variance";
%     case 2
%         potentialFunction = "NGPCA_withVolume";
%         expThreshold = "hard";
%         Method = "Variance";
%     case 3
%         potentialFunction = "Hoffmann";
%         expThreshold = "hard";
%         Method = "Variance";
%     case 4
%         potentialFunction = "Moeller";
%         expThreshold = "hard";
%         Method = "Variance";
%     case 5
%         potentialFunction = "Moeller_withVolume";
%         expThreshold = "hard";
%         Method = "Variance";
%     case 6
%         potentialFunction = "Migenda";
%         expThreshold = "hard";
%         Method = "Variance";
%     case 7
%         potentialFunction = "Migenda_withVolume";
%         expThreshold = "hard";
%         Method = "Variance";
%     %% Softclustering Variance LR
%     case 8
%         potentialFunction = "NGPCA";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 9
%         potentialFunction = "NGPCA_withVolume";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 10
%         potentialFunction = "Hoffmann";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 11
%         potentialFunction = "Moeller";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 12
%         potentialFunction = "Moeller_withVolume";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 13
%         potentialFunction = "Migenda";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 14
%         potentialFunction = "Migenda_withVolume";
%         expThreshold = "soft";
%         Method = "Variance";
%     %% Hardclustering Gaussian LR
%     case 15
%         potentialFunction = "NGPCA";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 16
%         potentialFunction = "NGPCA_withVolume";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 17
%         potentialFunction = "Hoffmann";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 18
%         potentialFunction = "Moeller";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 19
%         potentialFunction = "Moeller_withVolume";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 20
%         potentialFunction = "Migenda";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 21
%         potentialFunction = "Migenda_withVolume";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     %% Softclustering Variance LR
%     case 22
%         potentialFunction = "NGPCA";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 23
%         potentialFunction = "NGPCA_withVolume";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 24
%         potentialFunction = "Hoffmann";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 25
%         potentialFunction = "Moeller";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 26
%         potentialFunction = "Moeller_withVolume";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 27
%         potentialFunction = "Migenda";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 28
%         potentialFunction = "Migenda_withVolume";
%         expThreshold = "soft";
%         Method = "Gaussian";
% %% Radius
% % Moeller Radius
%     case 29 
%         potentialFunction = "Moeller_radius";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 30
%         potentialFunction = "Moeller_radius";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 31
%         potentialFunction = "Moeller_radius";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 32  
%         potentialFunction = "Moeller_radius";
%         expThreshold = "hard";
%         Method = "Variance";
% 
% % Moeller Radius mit Volume
%     case 33
%         potentialFunction = "Moeller_withVolume_radius";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 34
%         potentialFunction = "Moeller_withVolume_radius";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 35
%         potentialFunction = "Moeller_withVolume_radius";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 36 
%         potentialFunction = "Moeller_withVolume_radius";
%         expThreshold = "hard";
%         Method = "Variance";
% % Migenda Radius
%     case 37
%         potentialFunction = "Migenda_radius";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 38
%         potentialFunction = "Migenda_radius";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 39
%         potentialFunction = "Migenda_radius";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 40
%         potentialFunction = "Migenda_radius";
%         expThreshold = "hard";
%         Method = "Variance";
% % Migenda Radius mit Volume
%     case 41
%         potentialFunction = "Migenda_withVolume_radius";
%         expThreshold = "soft";
%         Method = "Gaussian";
%     case 42
%         potentialFunction = "Migenda_withVolume_radius";
%         expThreshold = "hard";
%         Method = "Gaussian";
%     case 43
%         potentialFunction = "Migenda_withVolume_radius";
%         expThreshold = "soft";
%         Method = "Variance";
%     case 44 
%         potentialFunction = "Migenda_withVolume_radius";
%         expThreshold = "hard";
%         Method = "Variance";
end