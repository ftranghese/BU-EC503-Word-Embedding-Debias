%{
    EC503 - Learning from Data
    March 2018
    Word Embeddings De-biasing
    Main script
    Work by: Frank Tranghese, Nidhi Tiwari, Aditya Singh
%}

% CODE GOES HERE
num_dataFiles = 1;
words = [];
wordVectors = [];
% Loading dataset from each matfile into different lists containing words and wordvectors
for i = 1:num_dataFiles
    load(sprintf('model_part_%02d.mat',i));
    words = [words, words_part];
    wordVectors = [wordVectors; wordvecs_part];
end

wordIndex = containers.Map(words, (1:length(words)));
% Normalising the word vectors
normalised_wordVecs = zeroes(size(wordVectors,1),1);
for j = 1:size(wordVectors,1)
    vector = wordVectors(j,:);
    % Normalising
    normalised_wordVecs(j,:) = vector./norm(vector);
end


 