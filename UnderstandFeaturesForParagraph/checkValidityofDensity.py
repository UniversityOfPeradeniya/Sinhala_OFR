'''
This will check the density-.txt data
with random number of words for their margin
'''
import random

fd = open('density-.txt','r')

rawdata = (fd.read()).split('\n')

dataArrays = {}

#now iterate through rawdata

for row in rawdata:
    if(len(row)>0):
        rowNumbers = row.split(',')
        fontName = rowNumbers[0]
        dataArrays[fontName] = map(float,rowNumbers[1:])
#print dataArrays

iterations = 10
sizesArray = [10,20,30,40,50]


keyArray = dataArrays.keys()
TopicStr = 'Font'
for numOfRandomElements in sizesArray:
    TopicStr = TopicStr+','+'min'+str(numOfRandomElements)
    TopicStr = TopicStr+','+'max'+str(numOfRandomElements)

totalDataStr=''
for key in keyArray:
    print key
    data = dataArrays[key]
    dataStr=key
    for numOfRandomElements in sizesArray:
        #here num of random elements should be 5,10,15
        #this should iterate iterations time
        print 'For size ',numOfRandomElements
        averageArray = []
        for it in range(0,iterations):
            randList = []
            dataList = []
            for rnd in range(0,numOfRandomElements):
                randNum = random.randint(0,len(data)-1)
                dataFromSingleData = data[randNum]
                randList.append(randNum)
                dataList.append(dataFromSingleData)
            #print randList
            #print dataList
            average = sum(dataList)/len(dataList)
            #print average
            averageArray.append(average)
        print min(averageArray),max(averageArray)
        dataStr = dataStr+','+str(min(averageArray))
        dataStr = dataStr+','+str(max(averageArray))
    dataStr+='\n'
    totalDataStr+=dataStr
print TopicStr
print totalDataStr

#save data

fd = open('minMaxOfRandom.txt','w')
fd.write(TopicStr+'\n')
fd.write(totalDataStr)
fd.close()
        
