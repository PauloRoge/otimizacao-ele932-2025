close all
clear
clc

% Critério de parada
eps = 0.001;

% Passo inicial, fatores de backtracking e Armijo
alfab = 0.2;
rho   = 0.2;
c     = 0.001;

% Ponto inicial
xk = [0; 0];

% Histórico de iterados e valores de f
vetor_x = xk;
f_val   = @(x) x(1)^2 + 4*x(2)^2 + x(1)*x(2) - 2*x(1) - x(2);
vetor_f = f_val(xk);

% Gradiente da função amarela
grad = @(x) [ 2*x(1) + x(2) - 2;
              8*x(2) + x(1) - 1 ];

gk     = grad(xk);
norma_g = norm(gk);

while norma_g >= eps
    % valor atual de f
    f0 = f_val(xk);
    % direção de descida
    d  = -gk;
    dd = gk' * d;
    
    % backtracking
    alfa = alfab;
    x    = xk + alfa*d;
    f1   = f_val(x);
    while f1 > f0 + c*alfa*dd
        alfa = rho*alfa;
        x    = xk + alfa*d;
        f1   = f_val(x);
    end
    
    % atualiza ponto
    xk = x;
    % salva histórico
    vetor_x(:,end+1) = xk;
    vetor_f(end+1)   = f1;
    % novo gradiente e critério
    gk     = grad(xk);
    norma_g = norm(gk);
end

% Ao final você terá:
%   vetor_x = [x1_iter1 x1_iter2 ...; x2_iter1 x2_iter2 ...]
%   vetor_f = [f_iter1, f_iter2, ...]
