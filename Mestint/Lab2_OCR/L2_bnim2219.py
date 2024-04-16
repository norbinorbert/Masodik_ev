import numpy as np
from matplotlib import pyplot as plt
import seaborn as sns


class Data:
    def __init__(self, vector=None, number=-1):
        if vector is None:
            vector = [[0 for _ in range(8)] for _ in range(8)]
        self.vector = vector
        self.number = number


# 1
def euclidean_distance(a: list[[int]], b: list[[int]]):
    sum_ = 0
    for i in range(len(a)):
        for j in range(len(a[i])):
            sum_ = sum_ + (a[i][j] - b[i][j]) ** 2
    return np.sqrt(sum_)


def cosine_similarity(a: list[[int]], b: list[[int]]):
    sum_a = 0
    sum_b = 0
    product = 0
    for i in range(len(a)):
        for j in range(len(a[i])):
            sum_a = sum_a + a[i][j] ** 2
            sum_b = sum_b + b[i][j] ** 2
            product = product + a[i][j] * b[i][j]
    return product / (np.sqrt(sum_a) * np.sqrt(sum_b))


# 2
def process_data(filename):
    file = open(filename)
    dataset = []
    while True:
        line = file.readline().split(",")
        if line == [""]:
            break
        vector = [[0 for _ in range(8)] for _ in range(8)]
        for i in range(8):
            for j in range(8):
                vector[i][j] = int(line[8 * i + j])
        dataset.append(Data(vector, int(line[len(line) - 1])))
    return dataset


def knn(training_data: [Data], test_data: Data, k, distance_function):
    distances = []
    for i in range(len(training_data)):
        distances.append((distance_function(training_data[i].vector, test_data.vector), training_data[i].number))
    distances.sort()
    if distance_function == cosine_similarity:
        distances.reverse()
    frequency = [0 for _ in range(10)]
    maximum = 0
    answer = 0
    for i in range(k):
        index = distances[i][1]
        frequency[index] = frequency[index] + 1
        if frequency[index] > maximum:
            maximum = frequency[index]
            answer = index
    return answer


def calculate_accuracy(training_data, test_data, k_value, distance_function, draw):
    total = [0 for _ in range(10)]
    correct = [0 for _ in range(10)]
    error = [0 for _ in range(10)]
    confusion_matrix = [[0 for _ in range(10)] for _ in range(10)]
    for i in range(len(test_data)):
        number = knn(training_data, test_data[i], k_value, distance_function)
        total[test_data[i].number] = total[test_data[i].number] + 1
        if number == test_data[i].number:
            correct[number] = correct[number] + 1
            confusion_matrix[number][number] = confusion_matrix[number][number] + 1
        else:
            confusion_matrix[number][test_data[i].number] = confusion_matrix[number][test_data[i].number] + 1
    for i in range(10):
        error[i] = correct[i] / total[i]
    if draw:
        fig = plt.figure()
        fig.add_subplot()
        fig.suptitle("Knn " + distance_function.__name__)
        sns.heatmap(confusion_matrix, cmap="viridis")
    return error


def print_accuracy_values(training_data, test_data, k_value, distance_function):
    learning_accuracy = calculate_accuracy(training_data, training_data, k_value, distance_function, False)
    test_accuracy = calculate_accuracy(training_data, test_data, k_value, distance_function, True)

    for i in range(10):
        string = (str(i) + " - Learning accuracy = " + str(learning_accuracy[i]) +
                  "     " + "Test accuracy: " + str(test_accuracy[i]))
        print(string)


# 3
def calculate_prototypes(training_data):
    prototypes = [Data(None, i) for i in range(10)]
    total = [0 for _ in range(10)]
    for k in range(len(training_data)):
        index = training_data[k].number
        total[index] = total[index] + 1
        for i in range(len(prototypes[index].vector)):
            for j in range(len(prototypes[index].vector[i])):
                prototypes[index].vector[i][j] = prototypes[index].vector[i][j] + training_data[k].vector[i][j]
                prototypes[index].number = training_data[k].number
    for k in range(len(prototypes)):
        for i in range(len(prototypes[k].vector)):
            for j in range(len(prototypes[k].vector[i])):
                prototypes[k].vector[i][j] = prototypes[k].vector[i][j] / total[k]
    return prototypes


def centroid_method(prototypes: [Data], test_data: Data, distance_function):
    distances = []
    for i in range(len(prototypes)):
        distances.append((distance_function(prototypes[i].vector, test_data.vector), prototypes[i].number))
    distances.sort()
    if distance_function == cosine_similarity:
        distances.reverse()
    return distances[0][1]


def calculate_accuracy_c(prototypes, test_data, distance_function, draw):
    total = [0 for _ in range(10)]
    correct = [0 for _ in range(10)]
    error = [0 for _ in range(10)]
    confusion_matrix = [[0 for _ in range(10)] for _ in range(10)]
    for i in range(len(test_data)):
        number = centroid_method(prototypes, test_data[i], distance_function)
        total[test_data[i].number] = total[test_data[i].number] + 1
        if number == test_data[i].number:
            correct[number] = correct[number] + 1
            confusion_matrix[number][number] = confusion_matrix[number][number] + 1
        else:
            confusion_matrix[number][test_data[i].number] = confusion_matrix[number][test_data[i].number] + 1
    for i in range(10):
        error[i] = correct[i] / total[i]
    if draw:
        fig = plt.figure()
        fig.add_subplot()
        fig.suptitle("Centroid  " + distance_function.__name__)
        sns.heatmap(confusion_matrix, cmap="viridis")
    return error


def print_accuracy_values_c(prototypes, training_data, test_data, distance_function):
    learning_accuracy = calculate_accuracy_c(prototypes, training_data, distance_function, False)
    test_accuracy = calculate_accuracy_c(prototypes, test_data, distance_function, True)

    for i in range(10):
        string = (str(i) + " - Learning accuracy = " + str(learning_accuracy[i]) +
                  "     " + "Test accuracy: " + str(test_accuracy[i]))
        print(string)


# 4
# 4.1
def prototype_heatmap(prototype):
    fig = plt.figure()
    fig.add_subplot()
    sns.heatmap(prototype, cmap="viridis")


# 4.2
def distance_from_prototype_heatmap(prototypes: [Data], test_data: [Data]):
    distances_indexed = [[] for _ in range(10)]
    for i in range(len(prototypes)):
        # calculate the distances from all points to the nth prototype
        distances = [[] for _ in range(10)]
        for j in range(len(test_data)):
            distance = euclidean_distance(prototypes[i].vector, test_data[j].vector)
            distances[test_data[j].number].append(distance)
        tmp = []
        for j in range(len(distances)):
            tmp.extend(distances[j])
        distances_indexed[i].append(tmp)

    # put all data into a single 2D array
    data_to_plot = []
    for data in distances_indexed:
        data_to_plot.extend(data)
    fig = plt.figure()
    fig.add_subplot()
    fig.suptitle("Euclidean distance from centroids")
    plt.imshow(data_to_plot, cmap="viridis", interpolation="nearest")
    plt.gca().set_aspect("auto")


# 4.3
def cosine_similarity_heatmap(test_data: [Data]):
    distances_indexed = [[] for _ in range(10)]
    for i in range(len(test_data)):
        # calculate all distances from 1 point to the rest
        distances = [[[] for _ in range(10)] for _ in range(10)]
        for j in range(len(test_data)):
            cos_sim = cosine_similarity(test_data[i].vector, test_data[j].vector)
            distances[test_data[i].number][test_data[j].number].append(cos_sim)
        # add the calculated distances to the according index
        tmp = []
        for j in range(10):
            for k in range(10):
                if distances[j][k]:
                    tmp.extend(distances[j][k])
        distances_indexed[test_data[i].number].append(tmp)
    # put all data into a single 2D array
    data_to_plot = []
    for data in distances_indexed:
        data_to_plot.extend(data)
    fig = plt.figure()
    fig.add_subplot()
    fig.suptitle("Cosine similarity between all data")
    plt.imshow(data_to_plot, cmap="viridis", interpolation="nearest")


k_value = 5
training_data = process_data("optdigits.tra")
test_data = process_data("optdigits.tes")

print("\nEuclidean distance, knn")
print_accuracy_values(training_data, test_data, k_value, euclidean_distance)
print("\nCosine similarity, knn")
print_accuracy_values(training_data, test_data, k_value, cosine_similarity)

prototypes = calculate_prototypes(training_data)

print("\nEuclidean distance, centroid")
print_accuracy_values_c(prototypes, training_data, test_data, euclidean_distance)
print("\nCosine similarity, centroid")
print_accuracy_values_c(prototypes, training_data, test_data, cosine_similarity)

for i in range(len(prototypes)):
    prototype_heatmap(prototypes[i].vector)

distance_from_prototype_heatmap(prototypes, test_data)

cosine_similarity_heatmap(test_data)

plt.show()
