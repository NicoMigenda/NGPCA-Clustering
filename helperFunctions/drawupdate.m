function [p, units] = drawupdate(p,units, t)
%-------------------------------------------------------------------------%
% DRAWING FUNCTION                                                        %
%-------------------------------------------------------------------------%

for k = 1:p.N
    delete(units{k}.H);
    units{k}.H = plot_ellipse(units{k}.weight(1:2,1:2), sqrt(abs(units{k}.eigenvalue(1:2))), units{k}.center(1:2));
    %set(units{k}.HT, 'Position', units{k}.center(1:2),'Color','red' ,'String' ,sprintf('%u', k));
end
%set(p.ht, 'String', sprintf('t = %d', t));
pause(0.001)
