import os
import string
import pandas as pd
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.linear_model import SGDClassifier
from sklearn.metrics import accuracy_score, confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.naive_bayes import MultinomialNB, ComplementNB
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import FunctionTransformer
from sklearn.neighbors import KNeighborsClassifier, RadiusNeighborsClassifier

# 1. Adathalmaz előkészítése
frames = []
for file in os.listdir('YouTube-Spam-Collection-v1'):
    frames.append(pd.read_csv('YouTube-Spam-Collection-v1/' + file))
data = pd.concat(frames)

test_data, train_data = train_test_split(data, train_size=0.7, test_size=0.3)


# 3. Adatok előfeldolgozása
# nltk.download('stopwords')
# nltk.download('punkt')
def preprocess(text):
    stop_words = set(stopwords.words('english'))
    punctuation = set(string.punctuation)
    tokens = word_tokenize(text)
    filtered_tokens = [word for word in tokens if
                       word.lower() not in stop_words and word not in punctuation and not word.isdigit()]
    return ' '.join(filtered_tokens)


# 4. Adatok vektorizálása / feature extraction
vectorizer = CountVectorizer()

# 2. Pipeline létrehozása
pipeline1 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', MultinomialNB())
])

pipeline2 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', ComplementNB())
])

pipeline3 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', SGDClassifier(loss='log_loss'))
])

pipeline4 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', SGDClassifier(loss='hinge'))
])

# 5. Modell betanítása, 6. Modellek tesztelése
pipeline1.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline1.predict(test_data['CONTENT'])
print('\nMultinomialNB')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline2.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline2.predict(test_data['CONTENT'])
print('\nComplementNB')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline3.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline3.predict(test_data['CONTENT'])
print('\nSGDClassifier, log_loss')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline4.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline4.predict(test_data['CONTENT'])
print('\nSGDClassifier, hinge')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

# 7. Használjunk n-grammokat az adathalmaz vektorizálásához
print('\nusing n-grams')
vectorizer = CountVectorizer(ngram_range=(1, 2))
pipeline1 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', MultinomialNB())
])

pipeline2 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', ComplementNB())
])

pipeline3 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', SGDClassifier(loss='log_loss'))
])

pipeline4 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', SGDClassifier(loss='hinge'))
])

# 5. Modell betanítása
pipeline1.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline1.predict(test_data['CONTENT'])
print('\nMultinomialNB, n=2')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline2.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline2.predict(test_data['CONTENT'])
print('\nComplementNB, n=2')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline3.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline3.predict(test_data['CONTENT'])
print('\nSGDClassifier, log_loss, n=2')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline4.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline4.predict(test_data['CONTENT'])
print('\nSGDClassifier, hinge, n=2')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

vectorizer = CountVectorizer(ngram_range=(1, 3))
pipeline1 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', MultinomialNB())
])

pipeline2 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', ComplementNB())
])

pipeline3 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', SGDClassifier(loss='log_loss'))
])

pipeline4 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', SGDClassifier(loss='hinge'))
])

# 5. Modell betanítása
pipeline1.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline1.predict(test_data['CONTENT'])
print('\nMultinomialNB, n=3')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline2.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline2.predict(test_data['CONTENT'])
print('\nComplementNB, n=3')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline3.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline3.predict(test_data['CONTENT'])
print('\nSGDClassifier, log_loss, n=3')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline4.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline4.predict(test_data['CONTENT'])
print('\nSGDClassifier, hinge, n=3')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

# 8. Használjuk a KNeighborsClassifier és RadiusNeighborsClassifier módszereket
pipeline5 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', KNeighborsClassifier())
])

pipeline5.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline5.predict(test_data['CONTENT'])
print('\nKNeighborsClassifier')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))

pipeline6 = Pipeline([
    ('preprocess', FunctionTransformer(lambda x: x.apply(preprocess))),
    ('vectorizer', vectorizer),
    ('classifier', RadiusNeighborsClassifier(radius=5, outlier_label="most_frequent"))
])

pipeline6.fit(train_data['CONTENT'], train_data['CLASS'])
prediction = pipeline6.predict(test_data['CONTENT'])
print('\nRadiusNeighborsClassifier')
print('Accuracy:' + str(accuracy_score(test_data['CLASS'], prediction)))
print('Confusion Matrix:\n' + str(confusion_matrix(test_data['CLASS'], prediction)))