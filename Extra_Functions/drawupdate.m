function [p, units] = drawupdate(p,units, t)
%-------------------------------------------------------------------------%
% DRAWING FUNCTION                                                        %
%-------------------------------------------------------------------------%

for k = 1:p.M
    delete(units{k}.H);
    units{k}.H = plot_ellipse(units{k}.weight(1:2,1:2), sqrt(abs(units{k}.eigenvalue(1:2))), units{k}.center(1:2));
end
if t == p.N
    for a = 1 : p.M
        p.a(a) = text(units{a}.center(1),units{a}.center(2), sprintf('%u', a), 'Color', 'r','FontSize',14);
    end
end
pause(0.001)
if p.makeGIF == 1
    makegif(p, t)
     %if loop == Parameter.Change-1 || loop == Parameter.Change || loop == Parameter.N
     %    for k = 1:Parameter.M
     %       Parameter.a(k) = text(units{k}.center(1),units{k}.center(2), sprintf('%u', k), 'Color', 'r','FontSize',14);
     %    end
     %    save_plot(Parameter, loop)
     %    delete(Parameter.a)
     %end
end