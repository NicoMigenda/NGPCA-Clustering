function [p,units,k] = unit_adaptation(p,units)
%-------------------------------------------------------------------------%
% THIRD PART OF MAIN LOOP: UNIT ADAPTATION                                %
%-------------------------------------------------------------------------%

h = exp((1-(1:p.M)) ./ p.rho);
if p.expThreshold == 1
    h_norm = h; 
else
    h_norm = h;% ./ sum(h);
end

% for each rank j...
for j = 1:p.M
      % get corresponding unit index
      k = p.r(j, 1); 
      
      a_lowpass = p.mu * h_norm(j);
       
      % update activity
      units{k}.activity = units{k}.activity + a_lowpass;

     %% Neural Gas update
      if (h(j) < p.expThreshold)
         break;
      end
     
      %% Learning rate control
      if p.LearningAlgo == "V"      
         % Our Learning rate according to chapter 5 and eq.10 - eq.15
         gamma = units{k}.y.^2 - units{k}.eigenvalue;
         units{k}.mt = units{k}.mt*(1-a_lowpass) + a_lowpass * gamma;
         units{k}.y_bar = units{k}.y_bar*(1-a_lowpass) + a_lowpass * units{k}.y.^2;
         units{k}.l_bar = units{k}.l_bar*(1-a_lowpass) + a_lowpass * units{k}.eigenvalue;
         D = units{k}.mt ./ (units{k}.y_bar + units{k}.l_bar);
         units{k}.epsilon = sum(abs(D)) / units{k}.m;
      elseif p.LearningAlgo == "G"
         % Learning rate from [Welsch10]
         for a = 1: units{k}.m
            g = exp(-units{k}.y(a) * (units{k}.y(a) / (2*units{k}.eigenvalue(a))) );
            units{k}.b(a) = (1-a_lowpass) * units{k}.b(a) + a_lowpass * g;
         end
         units{k}.D = 2/units{k}.m * sum( (units{k}.b - (1/sqrt(2))).^2 );
         units{k}.epsilon = (p.epsilon_init - p.epsilon_final) * sqrt(units{k}.D) + p.epsilon_final;
      end
      
      units{k}.alpha = units{k}.epsilon * h_norm(j);
      
      % Update unit center
      units{k}.center = units{k}.center + units{k}.alpha .* units{k}.x_c;
      % Update unit PCA estimates
      units = eforrlsa(units,k); 
      
      % update residual variance/spread 
      if(p.columns ~= units{k}.m)
          units{k}.sigma = units{k}.sigma + units{k}.alpha * (units{k}.x_c' * units{k}.x_c - units{k}.y' * units{k}.y - units{k}.sigma);
      end
end

activity_sum = sum(cellfun(@(x) sum(x.activity), units ));
for k = 1 : p.M
    units{k}.activity = units{k}.activity * p.M / activity_sum;
end
