function [Parameter] = memAloc(Parameter)

[Parameter.rows, Parameter.columns] = size(Parameter.shape);
Parameter.xvalue = 0;
Parameter.x = 0;
Parameter.logArgMinLimit = 1e-323;
Parameter.udmLogBase = 10.0;
Parameter.log_precomp = log( Parameter.udmLogBase );
Parameter.DtAllUnits = 0 ;
Parameter.DtMax =  0.99;
Parameter.Dsum = 0;
Parameter.r = zeros(Parameter.M, 2);
%Parameter.activityMax = Parameter.age_constant * Parameter.M;

Parameter.LearningAlgo = Parameter.LR;
if Parameter.c_type == "H"
    Parameter.expThreshold = 1.0;
elseif Parameter.c_type == "S"
    Parameter.expThreshold = 0.0;
else
    error("Clustering type only supports (H)ardclustering and (S)oftclustering")
end

