function [p,units] = set_data_distribution(p,units,loop)
%-------------------------------------------------------------------------%
% FIRST PART OF MAIN LOOP: SET AND PLOT DATA DISTRIBUTION                 %
%-------------------------------------------------------------------------%
if loop == p.Change
    p.shape = p.shape_two;
    p.GT = p.GT_two;
    [p.rows, p.columns] = size(p.shape);
    delete(p.handler)
end
p.handler = figure;
scatter(p.shape(:,1), p.shape(:,2),5,'o','MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
hold on;
scatter(p.GT(:,1), p.GT(:,2),15,'o','filled','r')
xlabel('X');
ylabel('Y');
axis equal;
axis manual;
for k = 1:p.M
    %Ellipsoid graphic handle
    units{k}.H = plot_ellipse(units{k}.weight(1:2,1:2), sqrt(abs(units{k}.eigenvalue(1:2))), units{k}.center(1:2));
end
drawnow;


