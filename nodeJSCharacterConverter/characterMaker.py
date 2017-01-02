from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

import sys,codecs
import os,shutil
import numpy as np

inputFile = 'officeCharSimp.txt'
outFolder = 'outputFonts'

#remove all the content in output folder
shutil.rmtree(outFolder, ignore_errors=True, onerror=None)
os.mkdir(outFolder)

#opening font list

fp = open('font-30.txt','r')
fontList = fp.readlines()



f = codecs.open(inputFile, encoding='utf-8',errors='ignore')

data = f.readlines()

for singleFont in fontList:
    singleFont = singleFont.strip('\n')
    print "fontdir/"+singleFont+".ttf"
    font = ImageFont.truetype("fontdir/"+singleFont+".ttf", 90)
    outputFolderNew = outFolder+'\\'+singleFont
    os.mkdir(outputFolderNew)
    count = 0
    for oneline in data:
        line = oneline
        words = line.split(' ')
        for word in words:
            im = Image.new("RGB", (800, 200), "black")
            draw = ImageDraw.Draw(im)
            #font = ImageFont.truetype("fontdir/0KDNAMAL.ttf", 40)
            draw.text((5, 0),u'  '+word+u'   ',(255,255,255),font=font)
            #print np.array(im.getdata(),np.uint8).sum().sum()
            
            im.save(outputFolderNew+'\\'+str(count)+'.png')
            count+=1
