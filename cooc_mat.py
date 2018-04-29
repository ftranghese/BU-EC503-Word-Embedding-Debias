from gensim import utils, corpora, matutils, models
import glove
# Restrict dictionary to the 30k most common words.
wiki = models.word2vec.LineSentence('/home/aditya/Desktop/ml_proj/20_newsgroups.txt')

id2word = corpora.Dictionary(wiki)
id2word.filter_extremes(keep_n=200000)
word2id = dict((word, id) for id, word in id2word.iteritems())
 
# Filter all wiki documents to contain only those 30k words.
filter_text = lambda text: [word for word in text if word in word2id]
filtered_wiki = lambda: (filter_text(text) for text in wiki)  # generator
 
# Get the word co-occurrence matrix -- needs lots of RAM!!
cooccur = glove.Corpus()
cooccur.fit(filtered_wiki(), window=10)
 
# and train GloVe model itself, using 10 epochs
model_glove = glove.Glove(no_components=600, learning_rate=0.05)
model_glove.fit(cooccur.matrix, epochs=1)

print(cooccur.matrix)
#print(model_glove.matrix)

"""
import sys, os
# */site-packages is where your current session is running its python out of
site_path = ''
for path in sys.path:
    if 'site-packages' in path.split('/')[-1]:
        print(path)
        site_path = path
# search to see if gensim in installed packages
if len(site_path) > 0:
    if not 'gensim' in os.listdir(site_path):
        print('package not found')
    else:
        print('gensim installed') 

   """    