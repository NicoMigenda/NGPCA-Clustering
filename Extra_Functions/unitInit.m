function [Parameter, units] = unitInit(Parameter)
    units = cell(Parameter.M, 1);
    for k = 1:Parameter.M
        %Unit specific Output Dimension
        units{k}.m = Parameter.StartDim;
        if units{k}.m > Parameter.columns
            error("PCA dimension greater than data dimension (m>n)");
        end

        % init centers by choosing N data points at random witihn the data
        % space
        for i = 1 : Parameter.columns
            units{k}.center(i) = 2*(max(Parameter.shape(:,i)) - min(Parameter.shape(:,i)))*rand + 2*min(Parameter.shape(:,i));
        end
        units{k}.center = units{k}.center';

        % first m principal axes (weights)
        % orhonormal (as needed by distance measure)        
        units{k}.weight = orth(rand(Parameter.columns, units{k}.m));

        % first m eigenvalues                                
        units{k}.eigenvalue = repmat(Parameter.lambda_init, units{k}.m, 1);

        % residual variance in the minor (d - m) eigendirections
        units{k}.sigma = Parameter.lambda_init;

        % deviation between input and center
        units{k}.x_c = zeros(Parameter.columns, 1);
        units{k}.x_c_bar = repmat(Parameter.lambda_init, Parameter.columns, 1);

        % unit output (activation) for input x_c
        units{k}.y = zeros(units{k}.m, 1);

        % unit activity
        units{k}.activity = Parameter.activity;

        % unit matching measure
        units{k}.y_bar = Parameter.lambda_init^2 * ones(units{k}.m, 1);%zeros(units{k}.m, 1);
        units{k}.l_bar = repmat(Parameter.lambda_init, units{k}.m, 1);
        units{k}.mt = units{k}.y_bar + units{k}.l_bar; %0;%

        units{k}.b = zeros(units{k}.m, 1);

        % unit summarized matching measure
        units{k}.D = Parameter.DtMax;

        % global learning rate 
        units{k}.alpha = Parameter.epsilon_init;
        units{k}.epsilon = Parameter.epsilon_init;

    end