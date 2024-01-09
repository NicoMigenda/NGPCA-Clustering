function [units] = eforrlsa(units,k)
% EFORRLSA (Moeller, 2002)
% Interlocking of learning and orthonormalization in RRLSA
V = units{k}.weight;
EFO_L2 = zeros(units{k}.m,1);
EFO_p = zeros(units{k}.m,1);
EFO_q = zeros(units{k}.m,units{k}.m);
EFO_r = zeros(units{k}.m,units{k}.m);
%Algorithmus Eq. 3-12
for i = 1:units{k}.m
    
    % Helper variables
    alpha_L = (1-units{k}.alpha)*units{k}.eigenvalue(i);
    beta_y = units{k}.alpha * units{k}.y(i);
    
    % Init und update of t and d according to eq. 5+6
    if i == 1
        EFO_t = 0;
        EFO_d = units{k}.x_c'*units{k}.x_c;
    else
        EFO_t = EFO_t + EFO_p(i-1)*EFO_p(i-1);
        EFO_d = EFO_d - units{k}.y(i-1)*units{k}.y(i-1);
        if EFO_d < 0
           EFO_d = 0; 
        end
    end
    % According to eq. 7
    EFO_s = (alpha_L+units{k}.alpha*EFO_d)*units{k}.y(i);
    %According to eq. 8
    EFO_L2(i) = alpha_L*alpha_L ...
        + beta_y * (alpha_L*units{k}.y(i) + EFO_s);
    %According to eq. 9
    EFO_n2 = EFO_L2(i) - EFO_s*EFO_s*EFO_t;
    % ensure that EFO_n2 > 0
    if( EFO_n2 < eps )
        EFO_n2 = eps;
    end
    EFO_n = sqrt( EFO_n2 );
    %According to eq. 12
    EFO_p(i) = (beta_y - EFO_s*EFO_t) / EFO_n;
    % Calculation of the 2 additive terms in eq. 4 (notice index)
    units{k}.weight(:,i) = EFO_p(i) * units{k}.x_c;
    for i2 = 1:i
        %According to eq. 10+11
        if i2 < i 
            EFO_r(i,i2) = EFO_r(i-1,i2) + EFO_p(i-1)*EFO_q(i-1,i2);
            EFO_q(i,i2) = -(beta_y*units{k}.y(i2)+EFO_s*EFO_r(i,i2)) / EFO_n;
        elseif i2 == i
            EFO_r(i,i2) = 0;
            EFO_q(i,i2) = alpha_L / EFO_n;
        else
            EFO_r(i,i2) = 0;
            EFO_q(i,i2) = 0;
        end
        % According to eq. 4
        units{k}.weight(:,i) = units{k}.weight(:,i) + EFO_q(i,i2) * V(:,i2);
    end
end
units{k}.eigenvalue = sqrt(EFO_L2);
if ~isreal(units{k}.eigenvalue)
        units{k}.eigenvalue = abs(units{k}.eigenvalue);
end
end

