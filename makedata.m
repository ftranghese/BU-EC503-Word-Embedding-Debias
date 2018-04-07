% Load all the word vectors (stored in 10 separate .mat files)
words = [];
wordvecs = [];

% For each of the .mat files...
for i = 1:10
    load(sprintf('model_part_%02d.mat', i));
    
    words = [words, words_part];
    wordvecs = [wordvecs; wordvecs_part];
end

% Create a Map so we can easily lookup the word vector for a given word.
word2Index = containers.Map(words, (1:length(words)));

%new dataset

new_dataset = wordvecs(115873:207141,:);