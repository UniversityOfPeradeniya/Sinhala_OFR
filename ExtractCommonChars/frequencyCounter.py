import sys,codecs
import locale
from collections import Counter
import operator


f = codecs.open('wordlist1.txt', encoding='utf-8',errors='ignore')
data = f.readlines()

#print data

counts = Counter(data)



most = counts.most_common(50)

#print counts

sumof = 0

for i in counts.items():
    sumof+=i[1]

sumtwo = 0
for i in most:
    print i[0].strip(u'\n'),'-',str((i[1]/(sumof*1.0))*100)[:4]+'%'
    sumtwo+=(i[1]/(sumof*1.0))*100




