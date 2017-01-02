#this will rename the files in output folder
#using another helping file that contains unicode names
#therefore I will have unicode tagged images


import sys,codecs
import locale
import glob
import os

globalCount = 0
numofPages = 2515
outputFolder = u'output\\'
inputFileTxt = 'singleSpaceUnique.txt'
copyFolder = u'renamed\\' 

f = codecs.open(inputFileTxt, encoding='utf-8',errors='ignore')
fd = codecs.open('log.txt',mode='w', encoding='utf-8',errors='ignore')
data = f.readlines()
notRenamed = []

for pageNum in range(1,numofPages+1):
    fd.write(str(pageNum)+'\n')
    print pageNum
    numOfRows = len(glob.glob(outputFolder+str(pageNum)+'-'+'*.png'))
    
    for name in glob.glob(outputFolder+str(pageNum)+'-'+'*.png'):
        fd.write(name+'\n')
        #split the name by -
        splitName = name.split('-')
        #take the second one and convert to int
        rownum = int(splitName[1])
        newFileName = (data[globalCount+rownum-1].strip(u'\n')).strip(u'\r')
        #print data[globalCount+rownum-1].strip(u'\n')
        pathPlusFilename = copyFolder+newFileName+u'.png'
        fd.write(pathPlusFilename+u'\n')
        try:
            os.rename(name,pathPlusFilename)
        except:
            print 'did not rename for file',name
            notRenamed.append(name)
            #os.remove(name)
    
    globalCount = globalCount+numOfRows
fd.close()
print notRenamed
