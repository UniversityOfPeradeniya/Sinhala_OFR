import os
from sklearn import metrics
from sklearn.cluster import AffinityPropagation
import numpy as np
import shutil

path = 'CharacterGeneration\\charImages\\sa\\'
newPath = 'characterClassifications\\sa\\'

path = 'SimpleTest\\'
newPath = 'WidthClassification\\'

n_digits = 5
algorithm = 'affinity'
pattern = '-width'
#list all the txt files in the folder

data = []
fileNames = []

def main():
    #remove sub folders
    removeSubFolders(newPath+algorithm+'\\')
    
    for file in os.listdir(path):
        if file.endswith(pattern+".txt"):
            text_file = open(path+file,'r')
            
            ar = (text_file.readline().split(' '))
            ar.remove('\n')
            if(len(ar)>0):
                #print map(int,ar)
                row = map(float,ar);
                data.append(row)
                fileNames.append(file)
            #print(row)

    #create np array

    npData = np.array(data)
    n_samples, n_features = npData.shape
    af = AffinityPropagation().fit(npData)
    list1 = af.labels_
    list2 = fileNames
    print af.labels_
    print fileNames

    list1, list2 = zip(*sorted(zip(list1, list2)))

    print list1
    print list2
    '''
    k=0
    lim = len(list1)-1
    for i in range(0,n_digits):
        
        while(list1[k]==i):
            # want to copy these into folders
            copychar(list1[k],list2[k])
            print list1[k],list2[k]
            k+=1
            if k==lim:
                break
    '''
    for i in range(0,len(list1)):
        print list1[i],list2[i]
        copychar(list1[i],list2[i])
def removeSubFolders(subpath):
    if os.path.exists(subpath):
        dirs = next(os.walk(subpath))[1]
        dirs = [subpath+s for s in dirs]
        map(shutil.rmtree,dirs)


def copychar(folder,character):
    folder = str(folder)
    character = character.replace('txt','png')
    filename = newPath+algorithm+'\\'+folder+'\\'+character
    if not os.path.exists(os.path.dirname(filename)):
        try:
            os.makedirs(os.path.dirname(filename))
        except OSError as exc: # Guard against race condition
            if exc.errno != errno.EEXIST:
                raise
    #start copy
    charfile = path+character.replace(pattern,'')
    shutil.copy2(charfile,filename)
    


if __name__=="__main__":
   main()
