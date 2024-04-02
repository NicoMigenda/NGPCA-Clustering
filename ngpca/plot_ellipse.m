%{
base function for 2d ellipsoids by:
    Alexander Kaiser

    Copyright (C) 2007
    Computer Engineering Group
    Faculty of Technology
    University of Bielefeld
    www.ti.uni-bielefeld.de

Extended by Nico Migenda for high-dim ellipsoids
%}

function H = plot_ellipse(W, L, Pos, W_orig, L_orig)

DEG2RAD = pi./180.0;

Color     = [0 0 0];

% scale axes
MajorAxis = L(1).*W(:,1);
MinorAxis = L(2).*W(:,2);

% determine angle
PA = atan2(W(:,1)'*[0; 1], W(:,1)'*[1; 0]);

% draw ellipse
Theta = [0:0.5:360]' .* DEG2RAD;

X     = norm(MajorAxis) .* cos(Theta);
Y     = norm(MinorAxis) .* sin(Theta);

% Rotationmatrix 
NX    = Pos(1) + cos(PA).*X - sin(PA).*Y;
NY    = Pos(2) + sin(PA).*X + cos(PA).*Y;

H1    = plot(NX,NY,'k');

MajorAxis_orig = L_orig(1).*W_orig(:,1);
MinorAxis_orig = L_orig(2).*W_orig(:,2);

% draw axes
H2 = line([Pos(1); Pos(1) + MajorAxis_orig(1)], [Pos(2); Pos(2) + MajorAxis_orig(2)]);
set(H2,'Color',Color);

H3 = line([Pos(1); Pos(1) + MinorAxis_orig(1)], [Pos(2); Pos(2) + MinorAxis_orig(2)]);
set(H3,'Color',Color);

H = hggroup;
set(H1, 'Parent', H);
set(H2, 'Parent', H);
set(H3, 'Parent', H);
