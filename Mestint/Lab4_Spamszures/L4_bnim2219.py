import re
from collections import Counter
import os.path
import numpy as np
from matplotlib import pyplot as plt
import seaborn as sns

stopwords = set()
counter_spam = Counter()
counter_ham = Counter()
counter_all = Counter()


# save the stopwords from the 2 files
def read_stopwords(filename):
    stopwords_file = open(filename, "r")
    while True:
        line = stopwords_file.readline().strip()
        if not line:
            break
        stopwords.add(line)
    stopwords_file.close()


# remove non-letter characters, make string lowercase, count words
def preprocess_file(filename):
    pattern = r"[a-zA-Z]+"
    data = open(filename, "r")
    words = re.findall(pattern, data.read())
    filtered_words = list(filter(lambda word: word not in stopwords, words))
    data.close()
    return Counter(filtered_words)


# fill the global counters using training data
def fill_counters(counter_all, counter_spam, counter_ham, filename):
    training_files = open(filename, "r")
    for filename in training_files.readlines():
        try:
            filename = filename.strip()
            if os.path.isfile("ham/" + filename):
                counter = preprocess_file("ham/" + filename)
                counter_ham += counter
            else:
                counter = preprocess_file("spam/" + filename)
                counter_spam += counter
            counter_all += counter
        except UnicodeDecodeError:
            continue
    training_files.close()


# calculate if email is spam
def is_spam(filename, alpha):
    counter = preprocess_file(filename)
    r = np.log(3)
    for word in counter.keys():
        if counter_spam.get(word) is None and alpha == 0:
            p_spam_word = 0.00000001
        elif counter_spam.get(word) is None:
            p_spam_word = alpha / (alpha * len(counter_all.keys()) + counter_spam.total())
        else:
            p_spam_word = (counter_spam.get(word) + alpha) / (alpha * len(counter_all.keys()) + counter_spam.total())

        if counter_ham.get(word) is None and alpha == 0:
            p_ham_word = 0.00000001
        elif counter_ham.get(word) is None:
            p_ham_word = alpha / (alpha * len(counter_all.keys()) + counter_ham.total())
        else:
            p_ham_word = (counter_ham.get(word) + alpha) / (alpha * len(counter_all.keys()) + counter_ham.total())

        r = r + counter.get(word) * (np.log(p_spam_word) - np.log(p_ham_word))
    return r > 0, r, counter


# calculate error
def calculate_error(filename, alpha, draw):
    emails = open(filename)
    incorrect = 0
    total = 0
    confusion_matrix = [[0, 0], [0, 0]]
    for filename in emails.readlines():
        try:
            filename = filename.strip()
            if os.path.isfile("ham/" + filename):
                result, _, _ = is_spam("ham/" + filename, alpha)
                if result:
                    confusion_matrix[0][1] += 1
                    incorrect += 1
                else:
                    confusion_matrix[0][0] += 1
            else:
                result, _, _ = is_spam("spam/" + filename, alpha)
                if not result:
                    confusion_matrix[1][0] += 1
                    incorrect += 1
                else:
                    confusion_matrix[1][1] += 1
            total += 1
        except UnicodeDecodeError:
            continue
    if draw:
        print("False positive: " + str(confusion_matrix[0][1] / (confusion_matrix[0][0] + confusion_matrix[0][1])))
        print("False negative: " + str(confusion_matrix[1][0] / (confusion_matrix[1][0] + confusion_matrix[1][1])))
        fig = plt.figure()
        fig.add_subplot()
        sns.heatmap(confusion_matrix, cmap="viridis", annot=True)
    emails.close()
    return incorrect / total


read_stopwords("stopwords.txt")
read_stopwords("stopwords2.txt")

fill_counters(counter_all, counter_spam, counter_ham, "train.txt")

print("Training error: " + str(calculate_error("train.txt", 0, False)))
print("Test error: " + str(calculate_error("test.txt", 0, True)))

print("\nAdditive smoothing")
print("Alpha = 0.01")
print("Training error: " + str(calculate_error("train.txt", 0.01, False)))
print("Test error: " + str(calculate_error("test.txt", 0.01, False)))

print("\nAlpha = 0.1")
print("Training error: " + str(calculate_error("train.txt", 0.1, False)))
print("Test error: " + str(calculate_error("test.txt", 0.1, False)))

print("\nAlpha = 1")
print("Training error: " + str(calculate_error("train.txt", 1, False)))
print("Test error: " + str(calculate_error("test.txt", 1, False)))


5 - semi supervised learning
print("\nSupervised learning:")
used = []
number_of_files_used = 1
while number_of_files_used != 0:
    number_of_files_used = 0
    for filename in os.listdir("ssl/"):
        if filename not in used:
            try:
                _, r, counter = is_spam("ssl/" + filename, 0)
                if r >= np.log(5):
                    counter_spam += counter
                    counter_all += counter
                    number_of_files_used += 1
                    used.append(filename)
                if r <= np.log(0.2):
                    counter_ham += counter
                    counter_all += counter
                    number_of_files_used += 1
                    used.append(filename)
            except UnicodeDecodeError:
                continue
    print("Files used for learning: " + str(number_of_files_used))

print("Test error (using supervised learning): " + str(calculate_error("test.txt", 0, False)))


# cross validation
def fill_counters_cross_validation(counter_all, counter_spam, counter_ham, data):
    for filename in data:
        try:
            filename = filename.strip()
            if os.path.isfile("ham/" + filename):
                counter = preprocess_file("ham/" + filename)
                counter_ham += counter
            else:
                counter = preprocess_file("spam/" + filename)
                counter_spam += counter
            counter_all += counter
        except UnicodeDecodeError:
            continue


def calculate_error_cross_validation(data, alpha):
    incorrect = 0
    total = 0
    for filename in data:
        try:
            filename = filename.strip()
            if os.path.isfile("ham/" + filename):
                result, _, _ = is_spam("ham/" + filename, alpha)
                if result:
                    incorrect += 1
            else:
                result, _, _ = is_spam("spam/" + filename, alpha)
                if not result:
                    incorrect += 1
            total += 1
        except UnicodeDecodeError:
            continue
    return incorrect / total


# make the 5 sets of data
emails = os.listdir("ham/")
emails.extend(os.listdir("spam/"))
np.random.shuffle(emails)
data = [np.random.choice(emails, size=1200, replace=False)]
emails = [email for email in emails if email not in data[0]]
data.append(np.random.choice(emails, size=1200, replace=False))
emails = [email for email in emails if email not in data[1]]
data.append(np.random.choice(emails, size=1200, replace=False))
emails = [email for email in emails if email not in data[2]]
data.append(np.random.choice(emails, size=1200, replace=False))
data.append([email for email in emails if email not in data[3]])

print("\nCross validation")
for power in range(5):
    alpha = 10 ** (-power)
    sum_error = 0
    for i in range(len(data)):
        counter_all = Counter()
        counter_spam = Counter()
        counter_ham = Counter()
        training = []
        for j in range(len(data)):
            if i != j:
                training.extend(data[j])
        fill_counters_cross_validation(counter_all, counter_spam, counter_ham, training)
        sum_error += calculate_error_cross_validation(data[i], alpha)
    error = sum_error / len(data)
    print("Alpha: " + str(alpha) + "\tTest error: " + str(error))

plt.show()
