classdef NGPCA
    properties
        % Optional parameters that are overwritten in Constructor if parsed
        potentialFunction = "AR"    % Defines the potential function used during the ranking process
                                    % Allowed values: "AR", "H", "N", "AV",
                                    % "VRV", "VRR" - We refer to our paper
                                    % for an explanation
        softhard          = 0       % 0 = Softclustering more accurate but slower, 1 = Hardclustering  
        learningRate      = 0.99    % Defines the initial learning rate for all units. 
        activity          = 1.00    % Defines the initial activity for all units  
        rho_init          = 0.99    % Defines the initial neighborhood range 
        rho_final         = 0.22    % Defines the final neighborhood range. Has to be smaller than rho_init
        mu                = 0.005   % Low pass filter
        rmax              = 200     % Defines the strength of the adaptive term in the potential function. No effect in "N" and "H"
        lambda            = 1       % Initial eigenvalue
        % Set in initUnits
        numberUnits                 % Defines the number of units to be initialized
        PCADimensionality = 2       % Sets the dimensionality for all units
        iterations        = 20000   % Sets the number of update cycles, one data point per iteration
        % Allocation of variables that are not subject to be set prior the training
        rho                         % Neighborhood range is set adaptivly based on the learningrate and rho_init, rho_final
        units                       % An array of local PCA units, length based on numberUnits
        r                           % Ranking array 
        CI                          % Validation: Centroid Index
        DU                          % Validation: Dead Units
        NMI                         % Validation: Normalized Mutual information
        data                        % Data 
        initialized                 % Bool variable to only initialize the model once
        dataDimensionality          % Data dimensionality set to the dimensionality of input data
    end

    methods
        %-------
        % Constructor
        %-------
        function obj = NGPCA(varargin)
            for i = 1:2:nargin
                property_name = varargin{i};
                property_value = varargin{i+1};
                switch lower(property_name)
                    case 'potentialfunction'
                        obj.potentialFunction = property_value;
                    case 'softhard'
                        obj.softhard = property_value;
                    case 'learningrate'
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
                    otherwise
                        error('Parsed wrong parameter to constructor ngpca: ' + property_name)
                end
            end
        end   
        %-------
        % Init Units
        %-------
        function obj = init_units(obj, data, numberUnits, varargin)
            for i = 1:2:nargin-3
                property_name = varargin{i};
                property_value = varargin{i+1};
                switch lower(property_name)
                    case 'iterations'
                        obj.iterations = property_value;
                    case 'pcadimensionality'
                        obj.PCADimensionality = property_value;
                    otherwise
                        error('Parsed wrong parameter to init_units: ' + property_name)
                end
            end
            if size(data,2) < 2
                error('Invalid input size. Data dimensionality lesser than 2.')
            end 
            obj.data = data;
            obj.dataDimensionality = size(obj.data,2);
            obj.numberUnits = numberUnits;
            obj = init(obj);
        end
        
        %-------
        % Train on one data point
        %-------
        function obj = fit_single(obj, data)
            if size(data,2) < 2
                error('Invalid input size. Data dimensionality lesser than two.')
            end
            obj.data = data;
            obj = update(obj);
        end

        %-------
        % Train on multiple data points
        %-------
        function obj = fit_multiple(obj, data)
            if size(data,1) < 2
                warning("We suggest fit_single when training on single data point")
            end
            if size(data,2) < 2
                error('Invalid input size. Data dimensionality lesser than two.')
            end
            obj.data = data;
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
                switch lower(property_name)
                    case 'eigenvalues'
                        eigenvalues = property_value;
                    case 'eigenvectors'
                        eigenvectors = property_value;   
                    case 'gt'
                        gt = property_value;
                    case 'label'
                        label = property_value;
                    case 'data'
                        data_valid = property_value;
                    otherwise
                        error('Parsed wrong parameter to validation: ' + property_name)
                end
            end
            % If eigenvalues, eigenvectors and gt are provided, it is
            % possible to calculate the CI 
            if any(strcmp(varargin,'eigenvalues')) && any(strcmp(varargin,'gt')) ...
               && any(strcmp(varargin,'eigenvectors'))
                obj = validate_CI(obj, gt, eigenvalues, eigenvectors);
            end
            % If labels exist, calculate NMI and DU
            if any(strcmp(varargin,'label')) && any(strcmp(varargin,'data'))
                obj = validate_NMI_DU(obj, label, data_valid);
            end
        end
      
    end
end