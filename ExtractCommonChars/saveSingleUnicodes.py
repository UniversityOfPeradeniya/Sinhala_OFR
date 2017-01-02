import sys,codecs
import locale

sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout)


f = codecs.open('simple.html', encoding='utf-8',errors='replace')
data = f.readlines()

print data


dataString = u''

for line in data:
    print line
