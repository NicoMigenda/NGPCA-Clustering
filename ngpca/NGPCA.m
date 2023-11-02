classdef NGPCA
    properties
        % Set in Constructor
        potentialFunction % Defines the potential function used during the ranking process
        temperature       % 0 = Softclustering more accurate but slower, 1 = Hardclustering  
        learningRate      % Defines the initial learning rate for all units. 
        activity          % Defines the initial activity for all units  
        rho_init          % Defines the initial neighborhood range 
        rho_final         % Defines the final neighborhood range. Has to be smaller than rho_init
        mu                % Low pass filter
        rmax              % Defines the strength of the adaptive term in the potential function. No effect in "N" and "H"
        % Set in initUnits
        numberUnits       % Defines the number of units to be initialized
        PCADimensionality % Sets the dimensionality for all units
        iterations        % Sets the number of update cycles, one data point per iteration
        % Allocation of variables that are not subject to be set prior the training
        rho               % Neighborhood range is set adaptivly based on the learningrate and rho_init, rho_final
        units             % An array of local PCA units, length based on numberUnits
        lambda            % Initial eigenvalue
        r                 % Ranking array 
        CI                % Validation: Centroid Index
        DU                % Validation: Dead Units
        NMI               % Validation: Normalized Mutual information
        filename          % Filename
        data              % Data 
        initialized       % Bool variable to only initialize the model once
        dataDimensionality % Data dimensionality set to the size of input data
    end

    methods
        %-------
        % Constructor
        %-------
        function obj = NGPCA(varargin)
            for i = 1:2:nargin
                property_name = varargin{i};
                property_value = varargin{i+1};
                switch property_name
                    case 'potentialFunction'
                        obj.potentialFunction = property_value;
                    case 'temperature'
                        obj.temperature = property_value;
                    case 'learningRate'
                        obj.learningRate = property_value;
                    case 'activity'
                        obj.activity = property_value;
                    case 'rho_init'
                        obj.rho_init = property_value;
                    case 'rho_final'
                        obj.rho_final = property_value;
                    case 'mu'
                        obj.mu = property_value;
                    case 'rmax'
                        obj.rmax = property_value;
                    case 'lambda'
                        obj.lambda = property_value;
                end
            end
            
            % Set default values for properties if not provided
            if isempty(obj.potentialFunction)
                obj.potentialFunction = "AR";
            end
            if isempty(obj.temperature)
                obj.temperature = 0.0;
            end
            if isempty(obj.learningRate)
                obj.learningRate = 0.99;
            end
            if isempty(obj.activity)
                obj.activity = 1;
            end
            if isempty(obj.rho_init)
                obj.rho_init = 0.99; 
            end
            if isempty(obj.rho_final)
                obj.rho_final = 0.02; 
            end
            if isempty(obj.mu)
                obj.mu = 0.005; 
            end
            if isempty(obj.rmax)
                obj.rmax = 200; 
            end
            if isempty(obj.lambda)
                obj.lambda = 1; 
            end
            if isempty(obj.rho)
                obj.rho = 0; 
            end
        end   
        %-------
        % Train on one data point
        %-------
        function obj = fit_single(obj, data, numberUnits, varargin)
            obj.data = data;
            if isempty(obj.numberUnits)
                obj.numberUnits = numberUnits;
            end
            if isempty(obj.initialized)
                for i = 1:2:nargin-3
                    property_name = varargin{i};
                    property_value = varargin{i+1};
                    switch property_name
                        case 'iterations'
                            obj.iterations = property_value;
                        case 'PCADimensionality'
                            obj.PCADimensionality = property_value;
                    end
                end
                if isempty(obj.iterations)
                    obj.iterations = 20000;
                end
                if isempty(obj.PCADimensionality)
                    obj.PCADimensionality = 2; 
                end
                
                if size(obj.data,2) < 2
                    error('Invalid input size.')
                end 
                obj.dataDimensionality = size(obj.data,2);
                obj = init(obj);
            end
            obj = update(obj);
        end

        %-------
        % Train on multiple data points
        %-------
        function obj = fit_multiple(obj, data, numberUnits, varargin)
            obj.data = data;
            obj.numberUnits = numberUnits;
            if isempty(obj.initialized)
                for i = 1:2:nargin-3
                    property_name = varargin{i};
                    property_value = varargin{i+1};
                    switch property_name
                        case 'iterations'
                            obj.iterations = property_value;
                        case 'PCADimensionality'
                            obj.PCADimensionality = property_value;
                    end
                end
                if isempty(obj.iterations)
                    obj.iterations = 20000;
                end
                if isempty(obj.PCADimensionality)
                    obj.PCADimensionality = 2; 
                end
                
                if size(obj.data,2) < 2
                    error('Invalid input size.')
                end
                obj.dataDimensionality = size(obj.data,2);
                obj = init(obj);
            end
            for i = 1 : obj.iterations
                obj = update(obj);
            end
 
        end

        %-------
        % Visualize
        %-------
        function obj = draw(obj)
            obj = drawunits(obj);
        end

        %-------
        % Validate
        %-------
        function obj = validation(obj, varargin)
            for i = 1 : 2 : nargin-1
                property_name = varargin{i};
                property_value = varargin{i+1};
                switch property_name
                    case 'eigenvalues'
                        eigenvalues = property_value;
                    case 'eigenvectors'
                        eigenvectors = property_value;   
                    case 'gt'
                        gt = property_value;
                    case 'label'
                        label = property_value;
                    case 'data'
                        data = property_value;
                end
            end
            % If eigenvalues, eigenvectors and gt are provided, it is
            % possible to calculate the CI 
            if any(strcmp(varargin,'eigenvalues')) && any(strcmp(varargin,'gt')) && any(strcmp(varargin,'eigenvectors'))
                obj = validate_CI(obj, gt, eigenvalues, eigenvectors);
            end
            % If labels exist, calculate NMI and DU
            if any(strcmp(varargin,'label')) && any(strcmp(varargin,'data'))
                obj = validate_NMI_DU(obj, label, data);
            end
        end
      
    end
end