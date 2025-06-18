%% Busca Exata (Falsa Posição) e Plotagem em um Único Script
close all
clear
clc

%--- 1) Dados Iniciais ---
alpha0 = 0;         % extremidade esquerda do intervalo
alpha1 = 1;         % chute inicial
x0     = [10; 0];   % ponto inicial

%--- 2) Definição da Função Objetivo (amarela) e Gradiente ---
f     = @(x1,x2)   x1.^2 + 4*x2.^2 + x1.*x2 - 2*x1 - x2;
grad  = @(x) [ 2*x(1) + x(2) - 2;
               8*x(2) + x(1) - 1 ];

%--- 3) Cálculo da Direção de Descida e Derivadas Direcionais ---
g0       = grad(x0);
d0       = -g0;
lambda0  = g0' * d0;          % phi'(0)

x1       = x0 + alpha1*d0;
g1       = grad(x1);
lambda1  = g1' * d0;          % phi'(1)

%--- 4) Falsa Posição para Encontrar α* ---
alpha_star = alpha1 - lambda1*(alpha1 - alpha0)/(lambda1 - lambda0);

%--- 5) Novo Ponto e Valor de f ---
x_star = x0 + alpha_star*d0;
f_star = f(x_star(1), x_star(2));

%--- 6) Histórico de Iterados (para plot) ---
vetor_x = [ x0,     x_star   ];   % 2×2: colunas são [x0 x*]
vetor_f = [ f(x0(1),x0(2)), f_star ];

%--- 7) Preparação da Grade para Plotagem ---
margin = 1;
x1_min = min(vetor_x(1,:)) - margin;
x1_max = max(vetor_x(1,:)) + margin;
x2_min = min(vetor_x(2,:)) - margin;
x2_max = max(vetor_x(2,:)) + margin;
[x1g, x2g] = meshgrid(...
    linspace(x1_min, x1_max, 100), ...
    linspace(x2_min, x2_max, 100) );
Z = f(x1g, x2g);  % retorna matriz 100×100

%--- 8) Gráfico 3D da Superfície + Trajetória ---
figure
surf(x1g, x2g, Z, 'EdgeColor','none', 'FaceAlpha',0.8)
hold on
plot3(vetor_x(1,:), vetor_x(2,:), vetor_f, 'r-o', ...
      'LineWidth',2, 'MarkerSize',8)
hold off
xlabel('x_1'), ylabel('x_2'), zlabel('f(x_1,x_2)')
title('Busca Exata (Falsa Posição): superfície e trajetória')
view(45,30)
grid on

%--- 9) Gráfico de Curvas de Nível + Trajetória ---
figure
contour(x1g, x2g, Z, 50, 'LineWidth',1)
hold on
plot(vetor_x(1,:), vetor_x(2,:), 'r-o', 'LineWidth',2, 'MarkerSize',8)
scatter(vetor_x(1,end), vetor_x(2,end), 100, 'k', 'filled')
hold off
xlabel('x_1'), ylabel('x_2')
title('Busca Exata (Falsa Posição): curvas de nível e trajetória')
axis equal
grid on
