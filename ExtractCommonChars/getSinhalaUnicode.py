import sys,codecs
import locale
f = codecs.open('simple.html', encoding='utf-8',errors='ignore')
data = f.readlines()

#sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout) 
for line in data:
    for char in line:
        if (u'\u0df4' >= char >= u'\u0d80'):
            print char
