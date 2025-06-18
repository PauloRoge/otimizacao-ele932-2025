close all
clear
clc

% Critério de parada
eps = 1e-3;

% Função e gradiente (amarelo)
f_val = @(x)   x(1)^2 + 4*x(2)^2 + x(1)*x(2) - 2*x(1) - x(2);
grad  = @(x) [ 2*x(1) + x(2) - 2;
               8*x(2) + x(1) - 1 ];

% Ponto inicial e histórico
xk       = [0; 0];
vetor_x  = xk;
vetor_f  = f_val(xk);
gk       = grad(xk);
norma_g  = norm(gk);
k        = 0;

while norma_g > eps
    % direção de descida
    d = -gk;
    
    % computa os "lambdas" para a Falsa Posição
    lambda0 = gk' * d;       % phi'(alpha0) em alpha0=0
    alpha0  = 0;
    
    alpha1 = 1;               % chute inicial
    x1     = xk + alpha1*d;
    g1     = grad(x1);
    lambda1 = g1' * d;        % phi'(alpha1)
    
    % fórmula da Falsa Posição para achar alpha ótimo
    alpha = alpha1 - lambda1*(alpha1-alpha0)/(lambda1-lambda0);
    
    % atualiza ponto
    xk = xk + alpha*d;
    
    % salva histórico
    vetor_x(:,end+1) = xk;
    vetor_f(end+1)   = f_val(xk);
    
    % novo gradiente e norma
    gk      = grad(xk);
    norma_g = norm(gk);
    k = k + 1;
end

% Ao final:
%   vetor_x = [x1_iter1 x1_iter2 ...; x2_iter1 x2_iter2 ...]
%   vetor_f = [f_iter1, f_iter2, ...]
