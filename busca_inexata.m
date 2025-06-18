%% Busca Inexata (Backtracking) e Plotagem no Mesmo Script
close all
clear
clc

% --- 1) Parâmetros de Backtracking ---
alfab = 0.2;    % passo inicial
rho   = 0.2;    % fator de redução
c     = 1e-4;   % constante de Armijo
cont  = 0;      % contador de reduções

% --- 2) Ponto Inicial ---
x0 = [0; 0];

% --- 3) Handle da Função (amarela) e do Gradiente ---
f_val = @(x)   x(1)^2 + 4*x(2)^2 + x(1)*x(2) - 2*x(1) - x(2);
grad  = @(x) [ 2*x(1) + x(2) - 2;
               8*x(2) + x(1) - 1 ];

% --- 4) Avaliação Inicial ---
f0 = f_val(x0);
g0 = grad(x0);

% --- 5) Cálculo da Direção e Derivada Direcional ---
d0 = -g0;
dd = g0' * d0;

% --- 6) Backtracking Line Search ---
alpha = alfab;
x_new = x0 + alpha*d0;
f1    = f_val(x_new);
while f1 > f0 + c*alpha*dd
    alpha = rho*alpha;
    x_new = x0 + alpha*d0;
    f1    = f_val(x_new);
    cont  = cont + 1;
end

% --- 7) Resultados da Busca ---
alpha_otimo = alpha;
x_otimo     = x_new;
f_otimo     = f1;

fprintf('alpha ótimo: %.6f\n', alpha_otimo);
fprintf('x* = [%.6f; %.6f]\n', x_otimo(1), x_otimo(2));
fprintf('f(x*) = %.6f\n', f_otimo);
fprintf('reduções de passo: %d\n', cont);

% --- 8) Histórico para Plot (inicial + ponto ótimo) ---
vetor_x = [ x0, x_otimo ];            % 2×2: colunas são [x0, x*]
vetor_f = [ f0,   f_otimo ];

% --- 9) Preparação da Grade para Plotagem ---
margin = 1;
x1_min = min(vetor_x(1,:)) - margin;
x1_max = max(vetor_x(1,:)) + margin;
x2_min = min(vetor_x(2,:)) - margin;
x2_max = max(vetor_x(2,:)) + margin;
[x1g, x2g] = meshgrid( ...
    linspace(x1_min, x1_max, 100), ...
    linspace(x2_min, x2_max, 100) );

% redeclara f de forma vetorizada para surf/contour
f_plot = @(x1,x2) x1.^2 + 4*x2.^2 + x1.*x2 - 2*x1 - x2;
Z = f_plot(x1g, x2g);

% --- 10) Gráfico 3D da Superfície + Trajetória ---
figure
surf(x1g, x2g, Z, 'EdgeColor','none','FaceAlpha',0.8)
hold on
plot3(vetor_x(1,:), vetor_x(2,:), vetor_f, 'r-o', ...
      'LineWidth',2,'MarkerSize',8)
hold off
xlabel('x_1'), ylabel('x_2'), zlabel('f(x_1,x_2)')
title('Backtracking: superfície e trajetória')
view(45,30)
grid on

% --- 11) Gráfico de Curvas de Nível + Trajetória ---
figure
contour(x1g, x2g, Z, 50, 'LineWidth',1)
hold on
plot(vetor_x(1,:), vetor_x(2,:), 'r-o', 'LineWidth',2,'MarkerSize',8)
scatter(vetor_x(1,end), vetor_x(2,end), 100, 'k','filled')
hold off
xlabel('x_1'), ylabel('x_2')
title('Backtracking: curvas de nível e trajetória')
axis equal
grid on
