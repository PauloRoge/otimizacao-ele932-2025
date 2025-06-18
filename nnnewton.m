close all
clear
clc

% Critério de parada
eps = 0.1;

% Ponto inicial
x_k = [0; 0];
k = 0;

% Armazenar histórico de iterados e de valores de f
vetor_x  = x_k;
% Define a função em amarelo como handle
f_val = @(x1,x2) x1.^2 + 4*x2.^2 + x1.*x2 - 2*x1 - x2;
vetor_f = f_val(x_k(1), x_k(2));

% Gradiente da função amarela
g = @(x) [ 2*x(1) + x(2) - 2;
           8*x(2) + x(1) - 1 ];

% Hessiana da função amarela (constante)
H = [ 2  1;
      1  8 ];

% Norma inicial do gradiente
norma_g = norm( g(x_k) );

while norma_g >= eps
    % Passo de Newton
    x_k = x_k - H\g(x_k);    % mais eficiente que inv(H)*g
    
    % Atualiza histórico
    vetor_x(:,end+1) = x_k;
    vetor_f(end+1)   = f_val(x_k(1), x_k(2));
    
    % Atualiza critério de parada
    norma_g = norm( g(x_k) );
    k = k + 1;
end

% Ao final, vetor_x e vetor_f contêm todo o histórico para plotar.
