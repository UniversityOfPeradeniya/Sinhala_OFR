#using pandas to import data
import pandas as pd

#this will split the set into training sets
from sklearn.cross_validation import train_test_split

#to measure the cross validation score
from sklearn. cross_validation import cross_val_score

#my classifiere tree
from sklearn.naive_bayes import GaussianNB
import numpy as np

#confusion metrix
from pandas_ml import ConfusionMatrix

#getting the label encoder for preprocessing
from sklearn import preprocessing, metrics

#counter
import collections

#cm plotter
import matplotlib.pyplot as plt


datafile = '../InputData/newPython.csv'
n_neighbors = 3

#read the file
df = pd.read_csv(datafile, sep=',')
df = df.dropna();
#print df.describe()

#-----------Drop the C99 >0.8 to remove effect from non rendered fonts
#print df[df.C99>0.6].index
df = df.drop(df[df.C99>0.6].index)

#-----------Dropping classes
#df = df.drop(df[df.label=='0KDNAMAL'].index)
#df = df.drop(df[df.label=='0KDSAMAN'].index)
#df = df.drop(df[df.label=='4u-Amantha'].index)

df.describe()

X = df[list(df.columns)[1:-1]]
y = df['label']

#apply preprocessing to X
#X = preprocessing.scale(X)

X_train, X_test, y_train, y_test = train_test_split(X, y,test_size=0.2, random_state=0)

clf = GaussianNB()
clf.fit(X, y)

y_predictions = clf.predict(X_test)

#for i in range(0,len(y_predictions)):
    #print y_predictions[i], y_test.as_matrix()[i]

print 'Accuracy:', clf.score(X_test, y_test)

#printing the training data size for each element
print collections.Counter(y_train.factorize()[0])


#draw confusion matrix
#get all labels
le = preprocessing.LabelEncoder()
le.fit(y.as_matrix())
labels = le.classes_
cm =  ConfusionMatrix(y_test.as_matrix(),y_predictions)
cm.plot(normalized=True)




#cross validation scores
scores = cross_val_score(clf, X, y, cv=4)
print scores.mean(), scores

from sklearn.metrics import classification_report
le = preprocessing.LabelEncoder()
le.fit(y.as_matrix())
target_names = le.classes_

print classification_report(y_test, y_predictions, target_names=target_names)

print collections.Counter(y_test.factorize()[0])


'''
This will plot the correlation between the attributes
from pandas.tools.plotting import scatter_matrix
scatter_matrix(df, alpha=0.2, figsize=(6, 6), diagonal='kde')
plt.show()

'''
'''
from pandas.tools.plotting import scatter_matrix
scatter_matrix(df, alpha=0.2, figsize=(6, 6), diagonal='kde')
plt.show()


-----------Printing the stats--------------
cm.stats()
'''




#show plots
plt.show()
