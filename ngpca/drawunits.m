function obj = drawunits (obj)
%-------------------------------------------------------------------------%
% DRAWING FUNCTION                                                        %
%-------------------------------------------------------------------------%

for k = 1:obj.numberUnits
    if obj.units{k}.H ~= 0
        delete(obj.units{k}.H);
    end
    obj.units{k}.H = plot_ellipse(obj.units{k}.weight(1:2,1:2), sqrt(abs(obj.units{k}.eigenvalue(1:2))), obj.units{k}.center(1:2));
end
% Force the plot, equal to drawnow
pause(0.001)

