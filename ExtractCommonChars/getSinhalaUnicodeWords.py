
import sys,codecs
import locale
f = codecs.open('courpus.out', encoding='utf-8',errors='ignore')
data = f.readlines()

fd = codecs.open('wordlistNotUnique.txt',mode='w', encoding='utf-8',errors='ignore')



#print data


for line in data:
    #linex = line.decode('utf-8')
    #print linex
    for char in line:
        if (u'\u0df4' >= char >= u'\u0d80'):
            fd.write(char)
        elif(char == u'\u0020'):
            fd.write(u'\n')
        elif(char==u'\n'):
            fd.write(u'\n')
        else:
            pass
fd.close()

'''
#print dataString

SimplifiedDataString = u'\u0020'.join(dataString.split('\n'))

#print SimplifiedDataString

newLineString = u'\n'.join(SimplifiedDataString.split(u'\u0020'))

#print newLineString


fd = codecs.open('wordlistNotUnique.txt',mode='w', encoding='utf-8',errors='ignore')
fd.write(newLineString)
fd.close()
'''

'''

#save every character in array

characterSet = [[]]

#Segment by chars

for char in SimplifiedDataString:
    if (u'\u0d84' >= char >= u'\u0d81') or (u'\u0df3' >=char >= u'\u0dc9'):
        (characterSet[len(characterSet)-1]).append(char)
    elif (u'\u0df4' >= char >= u'\u0d80'):
        newchar = [char]
        characterSet.append(newchar)
    else:
        continue

#print characterSet

#sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout)

for c in characterSet:
    print u''.join(c)+u' '
'''
