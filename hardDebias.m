function [hard_debiased] = hardDebias(filename, wordvecs_norm,word2Index,words_part)


fname = 'equalize_wordpairs.json'; 
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
equalize = jsondecode(str);

% Implementing hard debias methods
% Considering the gender neutral(occupation) words
occ_g = (occupations*g).*g';
% Re-embedding the gender neutral word vectors as follows
re_embed = zeros(size(occupations,1),300);
for d = 1:size(occupations,1)
    re_embed(d,:) = (occupations(d,:) - occ_g(d,:))./norm(occupations(d,:) - occ_g(d,:));
end

% For equalising the word sets. 
interim2 = {};
interim3 = {};
for k = 1:length(equalize)
    interim2{k,1} = char(equalize{k,1}(1,1));
    interim3{k,1} = char(equalize{k,1}(2,1));
end
arr3 = ismember(interim2,y);
arr4 = ismember(interim3,y);
counter3 = 0;
for i = 1:length(interim2)
    if(arr3(i)==1 && arr4(i)==1)
        counter3 = counter3 + 1;
        equalize_fin(counter3,:,1) = wordvecs_norm(word2Index(interim2{i,1}),:);
        equalize_fin(counter3,:,2) = wordvecs_norm(word2Index(interim3{i,1}),:);
    end
end

arg1(:,300) = (equalize_fin(:,:,1) + equalize_fin(:,:,2))./2;
arg2 = (g*ones(1,45))';

nu = arg1 - (arg2 .* (dot(arg1,arg2,1)/dot(g,g)));
EQ_g1(:,:) = (equalize_fin(:,:,1)*g).*g';
EQ_g2(:,:) = (equalize_fin(:,:,2)*g).*g';
wb_E1 = (EQ_g1 - (dot(arg1,arg2,1)/dot(g,g)))./norm(EQ_g1 - (dot(arg1,arg2,1)/dot(g,g)));
wb_E2 = (EQ_g2 - (dot(arg1,arg2,1)/dot(g,g)))./norm(EQ_g2 - (dot(arg1,arg2,1)/dot(g,g)));
re_embed_E(1:45,300) = nu + (sqrt(1-(norm(nu,2,2))^2)*wb_E1);
re_embed_E(46:90,300) = nu + (sqrt(1-(norm(nu,2,2))^2)*wb_E2);
