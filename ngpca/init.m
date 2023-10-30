function obj = init(obj)
    obj.units = cell(obj.numberUnits, 1);
    obj.r = zeros(obj.numberUnits, 2);
    for k = 1:obj.numberUnits
        % Unit specific Output Dimension
        obj.units{k}.m = obj.PCADimensionality;
        if obj.units{k}.m > obj.dataDimensionality
            error("PCA dimension greater than data dimension (m>n)");
        end
    
        % Initialize centers by choosing N data points at random within the data space
        if size(obj.data,1) == 1
            for i = 1:obj.dataDimensionality
                obj.units{k}.center(i) = obj.data(:, i) * rand;
            end
        else
            for i = 1:obj.dataDimensionality
                obj.units{k}.center(i) = 2 * (max(obj.data(:, i)) - min(obj.data(:, i))) * rand + 2 * min(obj.data(:, i));
            end
        end
        obj.units{k}.center = obj.units{k}.center';
    
        % First m principal axes (weights) orthonormal (as needed by distance measure)
        obj.units{k}.weight = orth(rand(obj.dataDimensionality, obj.units{k}.m));
    
        % First m eigenvalues
        obj.units{k}.eigenvalue = repmat(obj.lambda, obj.units{k}.m, 1);
    
        % Residual variance in the minor (n - m) eigendirections
        obj.units{k}.sigma = obj.lambda;
    
        % Deviation between input and center
        obj.units{k}.x_c = zeros(obj.dataDimensionality, 1);
        obj.units{k}.x_c_bar = repmat(obj.lambda, obj.dataDimensionality, 1);
    
        % Unit output (activation) for input x_c
        obj.units{k}.y = zeros(obj.units{k}.m, 1);
    
        % Unit activity
        obj.units{k}.activity = obj.activity;
    
        % Unit matching measure
        obj.units{k}.y_bar = obj.lambda^2 * ones(obj.units{k}.m, 1);
        obj.units{k}.l_bar = repmat(obj.lambda, obj.units{k}.m, 1);
        obj.units{k}.mt = obj.units{k}.y_bar + obj.units{k}.l_bar;
    
        % Unit summarized matching measure
        %obj.units{k}.D = obj.DtMax;
    
        % Global learning rate
        obj.units{k}.alpha = obj.learningRate;
        obj.units{k}.epsilon = obj.learningRate;
        obj.units{k}.H = 0;
    end
    obj.initialized = 1;
