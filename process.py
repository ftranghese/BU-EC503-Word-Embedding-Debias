file = open('filtered_subl.txt','r')
fileContent = file.read()

for word in fileContent.split():
	print word + '*'