'''
This will make directory for each character
input folder=images
'''



import glob
import os
import shutil

#input directory
inputDir = 'images\\'
outputDir = 'segmentedImages\\'

#clear the output directory

shutil.rmtree(outputDir,ignore_errors=True, onerror=None)

#make again
os.mkdir(outputDir)

#list files in input dir

fileNames = glob.glob(inputDir+'*.png')

#print fileNames

#now get the font name
for i in fileNames:
    dirName = i.split(inputDir)[1].split('.pdf')[0]
    print dirName
    os.mkdir(outputDir+dirName)
