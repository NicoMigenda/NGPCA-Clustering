function [p,units,k] = unit_adaptation(p,units,loop)
%-------------------------------------------------------------------------%
% THIRD PART OF MAIN LOOP: UNIT ADAPTATION                                %
%-------------------------------------------------------------------------%

% for each rank j...
for j = 1:p.N
      % get corresponding unit index
      k = p.r(j, 1); 
        
      %% Neural Gas update step based on Schenck dissertation Eq. (3.8)
      h = exp((1 - j) / p.rho);
      if (h < p.expThreshold)
         break;
      end
      % update unit age for unit reset heuristic
      p.allAges(k) = min(p.allAges(k) + abs(floor(h*p.allAges(k))), p.ageMax);
      if p.LearningAlgo == "Variance"
        units{k}.epsilon = (p.epsilon_init - p.epsilon_final) * units{k}.Dt^p.phi + p.epsilon_final;
      elseif p.LearningAlgo == "Gaussian"
        units{k}.epsilon = (p.epsilon_init - p.epsilon_final) * sqrt(units{k}.D) + p.epsilon_final;
      end

      units{k}.alpha = units{k}.epsilon * h;
      
      units{k}.center = units{k}.center + units{k}.alpha .* units{k}.x_c;

      units = eforrlsa(units,k); 

      %units{k}.variance = sum(units{k}.eigenvalue);
      
      %%
      % increase adaptation counter for current unit
      units{k}.t = units{k}.t + 1;

      % update residual variance/spread 
      if(p.columns ~= units{k}.outdimension)
          units{k}.sigma = units{k}.sigma + units{k}.alpha * (units{k}.x_c' * units{k}.x_c - units{k}.y' * units{k}.y - units{k}.sigma);
      end
         
      %% Learning rate control
      a_lowpass = p.mu * h;
      if p.LearningAlgo == "Variance"        
         units{k}.mt = units{k}.mt*(1-a_lowpass) + units{k}.y .* (units{k}.y ./ units{k}.eigenvalue) *a_lowpass;
         units{k}.Dt = (sum(min(abs(log10(units{k}.mt(units{k}.mt > p.logArgMinLimit))), p.DtMax )) + sum(units{k}.mt(units{k}.mt <= p.logArgMinLimit))) / units{k}.outdimension;
      elseif p.LearningAlgo == "Gaussian"
         for a = 1: units{k}.outdimension
            g = exp(-units{k}.y(a) * (units{k}.y(a) / (2*units{k}.eigenvalue(a))) );
            units{k}.b(a) = (1-a_lowpass) * units{k}.b(a) + a_lowpass * g;
         end
         units{k}.D = 2/units{k}.outdimension * sum( (units{k}.b - (1/sqrt(2))).^2 );
      end
end


