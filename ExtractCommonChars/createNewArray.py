import sys,codecs
import locale
from collections import Counter
import operator


f = codecs.open('wordlistNotUnique.txt', encoding='utf-8',errors='ignore')
data = f.readlines()

newdata = codecs.open('singleSpaceUnique.txt',mode='w', encoding='utf-8',errors='ignore')

counts = Counter(data)
most = counts.most_common()


for i in most:
    if i[0]!=u'':
        newdata.write(i[0])
newdata.close()
