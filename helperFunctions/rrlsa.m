function [units] = rrlsa(units,k,p)
% RRLSA; Ouyang et al., 2000
for i = 1:units{k}.outdimension
    V(:,i) = units{k}.weight(:,i) .* units{k}.eigenvalue(i);
end
V =units{k}.alpha .* (units{k}.x_c*units{k}.y' - units{k}.weight*triu(units{k}.y*units{k}.y', 1)) + (1 -units{k}.alpha) .* V;
% re-normalize weight vectors and determine variances
% TODO: replace loop by matrix ops
for i = 1:units{k}.outdimension
    units{k}.eigenvalue(i)   = norm(V(:,i));
    units{k}.weight(:,i) = V(:,i) ./ units{k}.eigenvalue(i);
end
end

