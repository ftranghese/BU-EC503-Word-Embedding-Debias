%{
    EC503 - Learning from Data
    March 2018
    Word Embeddings De-biasing
    Function for soft bias method
    Worked on by: Frank Tranghese
    Requires CVX to be installed
%}

function [Wt] = softDebias(W,g,N)
    % *** INPUTS ***
    % W - entire word embedding set N x D
    % g - gender direction
    % N - gender neutral words we want to debias
    % *** OUTPUTS ***
    % Wt - normalized, linearly transformed word embeddings set
    
    % ensure sparsity
    
    [U,S,V] = svd(W);
    I = eye(300);
    
    %minimize T
    cvx_begin sdp
        variable X(300,300) semidefinite
        minimize(square_pos(norm(S*V'*(X-I)*V*S','fro')) + 0.2*square_pos(norm(g'*X*N','fro')))
        subject to
            X >= 0
    cvx_end
    %minimize(square_pos(norm(W*(X-eye(300))*W','fro')) + 0.2*square_pos(norm(g'*X*N','fro')))
    %return normalized transformed W
    Wt = (W*T')./norm(W*T');
    
end