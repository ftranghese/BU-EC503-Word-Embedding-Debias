%{
    EC503 - Learning from Data
    March 2018
    Word Embeddings De-biasing
    Function for quantifying indirect bias
    Worked on by: Frank Tranghese
%}

function [beta] = indirectBias(W,V,g)
% INPUTS
% W - co-occurance matrix of words to test for direct bias (n x d)
% V - co-occurance matrix of different set of words to test (n x d)
% g - the gender direction (1 x d)
% OUTPUTS
% beta - the vector of quanitifed indirect bias for all words in w (n x 1)

% we first define the gender components of each word in sets W, V
% assumes already normalized.
Wg = (W*g').*g; %vector of gender components of words in W
Vg = (V*g').*g; %vector of gender components of words in V

% get components of words perpendicular to the gender direction
Wt = W-Wg;
Vt = V-Vg;

beta = (W*V' - (Wt*Vt')./(diag(Wt*Wt')*diag(Vt*Vt')))./(W*V');

end