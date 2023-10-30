%{
Alexander Kaiser

    Copyright (C) 2007
    Computer Engineering Group
    Faculty of Technology
    University of Bielefeld
    www.ti.uni-bielefeld.de
%}

function H = plot_ellipse(W, L, Pos)

DEG2RAD = pi./180.0;

Color     = [0 0 0];
FaceColor = 'none';

% scale axes
MajorAxis = L(1).*W(:,1);
MinorAxis = L(2).*W(:,2);

% determine angle
PA = atan2(W(:,1)'*[0; 1], W(:,1)'*[1; 0]);

% draw ellipse
Theta = [0:5:360]' .* DEG2RAD;

X     = norm(MajorAxis) .* cos(Theta);
Y     = norm(MinorAxis) .* sin(Theta);

% Rotationsmatrix 
NX    = Pos(1) + cos(PA).*X - sin(PA).*Y;
NY    = Pos(2) + sin(PA).*X + cos(PA).*Y;

H1    = plot(NX,NY,'k');
%set(H1,'EdgeColor',Color,'FaceColor',FaceColor);

% draw axes
H2 = line([Pos(1); Pos(1) + MajorAxis(1)], [Pos(2); Pos(2) + MajorAxis(2)]);
set(H2,'Color',Color);

H3 = line([Pos(1); Pos(1) + MinorAxis(1)], [Pos(2); Pos(2) + MinorAxis(2)]);
set(H3,'Color',Color);

H = hggroup;
set(H1, 'Parent', H);
set(H2, 'Parent', H);
set(H3, 'Parent', H);
