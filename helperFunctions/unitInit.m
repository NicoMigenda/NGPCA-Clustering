function [units,Parameter] = unitInit(Parameter)

%-------------------------------------------------------------------------%
% UNIT INITIALIZATION                                                     %
%-------------------------------------------------------------------------%

% init data structure for units
units = cell(Parameter.N, 1);

for k = 1:Parameter.N
    
    units{k}.check = 0;
    
    % Protecs a Unit for n Iterations after the Dimension changed
    units{k}.protect = 100;
    
    % Use the eFunction on first loop
    units{k}.eFunctionDimension = 1;
    
    %Unit specific Output Dimension
    units{k}.outdimension = Parameter.StartDim;
    
    % init centers by choosing N data points at random 
    units{k}.center = Parameter.shape(ceil(Parameter.rows .* rand), :)';
    
    % first m principal axes (weights)
    % orhonormal (as needed by distance measure)        
    units{k}.weight = orth(rand(Parameter.columns, units{k}.outdimension));
    % first m eigenvalues                                
    units{k}.eigenvalue = repmat(Parameter.lambda_init, units{k}.outdimension, 1);
    
    % residual variance in the minor (d - m) eigendirections
    units{k}.sigma = Parameter.lambda_init;
    
    % deviation between input and center
    units{k}.x_c = zeros(Parameter.columns, 1);
    
    % unit output (activation) for input x_c
    units{k}.y = zeros(units{k}.outdimension, 1);
    
    % unit "age" (for unit reset heuristic)
    Parameter.allAges(k) = Parameter.ageMax;
    
    % unit matching measure
    units{k}.mt = zeros(units{k}.outdimension, 1);
    
    % unit summarized matching measure
    units{k}.Dt = 1.0;
    
    % adapt steps for this unit                       
    units{k}.t = 0;
    
    % gy
    units{k}.gy = zeros(units{k}.outdimension,1);
    
    % matching parameter
    units{k}.mp = 0;
    
    % Unit variance
    units{k}.variance = 0;
    
    % Unit total variance
    units{k}.totalVariance = 0;

    % global learning rate 
    units{k}.alpha = Parameter.epsilon_init;
    
    % global learning rate 
    units{k}.highestDimension = 1;
   
end


end

