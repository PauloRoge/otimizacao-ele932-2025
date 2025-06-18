%% Gráfico 3D da superfície + trajetória (função do relatório)
% vetor_x deve estar no workspace (2×N: [x1; x2] de cada iteração)

% Definição da função objetivo (em amarelo)
f = @(x1,x2) x1.^2 + 4*x2.^2 + x1.*x2 - 2*x1 - x2;

% Cálculo dos limites de plot a partir de vetor_x
margin = 1;
x1_min = min(vetor_x(1,:)) - margin;
x1_max = max(vetor_x(1,:)) + margin;
x2_min = min(vetor_x(2,:)) - margin;
x2_max = max(vetor_x(2,:)) + margin;

% Geração da grade
[x1g,x2g] = meshgrid(linspace(x1_min,x1_max,100), linspace(x2_min,x2_max,100));
Fg = f(x1g,x2g);

% Valores de f nos iterados (recalcula se vetor_f não existir)
if exist('vetor_f','var')
    f_iters = vetor_f;
else
    f_iters = arrayfun(@(k) f(vetor_x(1,k), vetor_x(2,k)), 1:size(vetor_x,2));
end

% Plot 3D
figure
surf(x1g, x2g, Fg, 'EdgeColor','none', 'FaceAlpha',0.8)
hold on
plot3(vetor_x(1,:), vetor_x(2,:), f_iters, 'r-o', 'LineWidth',2, 'MarkerSize',6)
hold off
xlabel('x_1'), ylabel('x_2'), zlabel('f(x_1,x_2)')
title('Superfície de f e trajetória dos iterados')
view(45,30)
grid on

%% Gráfico de curvas de nível + trajetória (função do relatório)
% Reusa f, vetor_x, e as variáveis x1g,x2g,Fg definidas acima

levels = 30;  % quantidade de isolinhas

figure
contour(x1g, x2g, Fg, levels, 'LineWidth',1)
hold on
plot(vetor_x(1,:), vetor_x(2,:), 'r-o', 'LineWidth',2, 'MarkerSize',6)
scatter(vetor_x(1,end), vetor_x(2,end), 80, 'k', 'filled')  % marca o ponto final
hold off
xlabel('x_1'), ylabel('x_2')
title('Curvas de nível de f e trajetória dos iterados')
grid off
axis equal
