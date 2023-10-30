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
%if t == p.N
%    for a = 1 : p.M
%        p.a(a) = text(units{a}.center(1),units{a}.center(2), sprintf('%u', a), 'Color', 'r','FontSize',14);
%    end
%end
pause(0.001)

