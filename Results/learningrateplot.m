clear vaiables
close all

a = [1:255]';
b = 255*ones(255,1);
c = a ./ b;
d = [0 : 0.1 : 1];
v = c.^d;
figure;
hold on
plot(0:1/254:1,v)
ylim([0 1.025])
xlim([0 1])

ylabel('$v$','Interpreter','latex')
xlabel('$a/a_{max}$','Interpreter','latex')
legend('$\epsilon = 0.0$','$\epsilon = 0.1$','$\epsilon = 0.2$','$\epsilon = 0.3$','$\epsilon = 0.4$',...
    '$\epsilon = 0.5$','$\epsilon = 0.6$','$\epsilon = 0.7$','$\epsilon = 0.8$','$\epsilon = 0.9$','$\epsilon = 1.0$',...
    'Interpreter','latex','Location','southeast')

export_fig learningrateplot -pdf -transparent
