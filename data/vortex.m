%{
Alexander Kaiser

    Copyright (C) 2007
    Computer Engineering Group
    Faculty of Technology
    University of Bielefeld
    www.ti.uni-bielefeld.de
%}
function D = vortex(a_max, r_max, noise, N);

for i = 1:N
  a = a_max .* rand(1);
  r = r_max .* (a ./ a_max) + noise .* rand(1);

  D(i,1) = r .* cos(a);
  D(i,2) = r .* sin(a);
end
