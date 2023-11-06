function obj = update(obj)
%-------------------------------------------------------------------------%
% 1st PART OF MAIN LOOP: DETERMINE UNIT RANKING ORDER                     %
%-------------------------------------------------------------------------% 
    % Helper variable that sums up all learning rates to calculate
    % neighborhood after
    DtAllUnits = 0;
    % Sample a random data point from the provided distribution
    x = obj.data(ceil(size(obj.data,1) .* rand), :);
    % for each unit k...
    for k = 1:obj.numberUnits
      % calculate neuron input and output (activation)
      obj.units{k}.x_c = x' - obj.units{k}.center;
      obj.units{k}.y   = obj.units{k}.weight' * obj.units{k}.x_c;
    
      % Potential Function according to section 6
      obj.r(k,:) = [k, potentialFunction(obj.units{k},obj.dataDimensionality, obj.potentialFunction, obj.rmax)];

      DtAllUnits = DtAllUnits + obj.units{k}.epsilon;
    end
    
    % Calculate neighborhood range according to eq. 21; DtAllUnits is the
    % sum of all learning rates
    obj.rho = (obj.rho_init - obj.rho_final) * DtAllUnits/obj.numberUnits + obj.rho_final;

    % perform ranking (for the soft-competition between units)
    obj.r = sortrows(obj.r, 2);

    %-------------------------------------------------------------------------%
    % 2nd PART OF MAIN LOOP: UNIT ADAPTATION                                  %
    %-------------------------------------------------------------------------%
    
    % exponentially declining term that ensures that not only the winner is updated (soft-clustering)
    h = exp((1-(1:obj.numberUnits)) ./ obj.rho);
    
    % for each rank j...
    for j = 1:obj.numberUnits
          % get corresponding unit index
          k = obj.r(j, 1); 
          
          a_lowpass = obj.mu * h(j);
           
          % Update activity according to eq. 39
          obj.units{k}.activity = obj.units{k}.activity + a_lowpass;
    
          % Only update the top placed units
          if (h(j) < obj.softhard)
             break;
          end
    
          %% Learning rate control    
          % Our Learning rate according to chapter 5 and eq. 17 - eq. 20
          gamma = obj.units{k}.y.^2 - obj.units{k}.eigenvalue;
          obj.units{k}.mt = obj.units{k}.mt*(1-a_lowpass) + a_lowpass * gamma;
          obj.units{k}.y_bar = obj.units{k}.y_bar*(1-a_lowpass) + a_lowpass * obj.units{k}.y.^2;
          obj.units{k}.l_bar = obj.units{k}.l_bar*(1-a_lowpass) + a_lowpass * obj.units{k}.eigenvalue;
          D = obj.units{k}.mt ./ (obj.units{k}.y_bar + obj.units{k}.l_bar);
          obj.units{k}.epsilon = sum(abs(D)) / obj.units{k}.m;
          
          % helper variable for eq. 16 and eforrlsa
          obj.units{k}.alpha = obj.units{k}.epsilon * h(j);
          
          % Update unit center according to eq. 16 
          obj.units{k}.center = obj.units{k}.center + obj.units{k}.alpha .* obj.units{k}.x_c;

          % Update unit PCA estimates according to reference [31]
          obj.units = eforrlsa(obj.units,k); 
    
          % update residual variance/spread acording to eq. 8 
          if(obj.dataDimensionality ~= obj.units{k}.m)
              obj.units{k}.sigma = obj.units{k}.sigma + obj.units{k}.alpha * (obj.units{k}.x_c' * obj.units{k}.x_c - obj.units{k}.y' * obj.units{k}.y - obj.units{k}.sigma);
          end
    end
    
    % Update activity according to eq. 40
    activity_sum = sum(cellfun(@(x) sum(x.activity), obj.units));
    for k = 1 : obj.numberUnits
        obj.units{k}.activity = obj.units{k}.activity * obj.numberUnits / activity_sum;
    end

