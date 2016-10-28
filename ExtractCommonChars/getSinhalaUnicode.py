
import sys,codecs
import locale
f = codecs.open('NPFEOT0001.TXT', encoding='utf-8',errors='ignore')
data = f.readlines()

print data

dataString = ''

for line in data:
    #linex = line.decode('utf-8')
    for char in line:
        if (u'\u0df4' >= char >= u'\u0d80') or char == u'\u0020':
            dataString+=char

SimplifiedDataString = u'\u0020'.join(dataString.split())

#print SimplifiedDataString


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
