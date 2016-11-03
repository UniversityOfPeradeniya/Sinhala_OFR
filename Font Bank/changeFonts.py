
#replacing word

wordReplacer = 'SinhalaFontHolder'
fontfolder = 'UpdateFonts\\'

with open('Font1.xml') as fd:
    doc = fd.read()
with open('fonts.txt') as fd:
    fonts = fd.readlines()

for i in fonts:
    fontText = i.strip('\n')
    docNew = doc.replace(wordReplacer,fontText)
    fdnew = open(fontfolder+fontText+'.xml','w')
    fdnew.write(docNew)
    fdnew.close()

