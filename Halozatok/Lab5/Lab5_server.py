# Boda Norbert, 521, bnim2219
import sys
from socket import *
import threading
from PIL import Image
import numpy as np

NUMBER_OF_THREADS = int(sys.argv[1])
MAXIMUM_ITERATIONS = sys.argv[2]
WIDTH = int(sys.argv[3])
HEIGHT = int(sys.argv[4])
color_matrix = [0 for _ in range(WIDTH * HEIGHT)]


def request_processing(connection_socket, section):
    connection_socket.send((MAXIMUM_ITERATIONS + " " + str(WIDTH) + " " +
                            str(HEIGHT) + " " + str(section) + " " + str(NUMBER_OF_THREADS)).encode())

    values = ""
    while True:
        string = connection_socket.recv(1024).decode()
        values += string
        if string == "":
            break
    values = values.strip().split(",")
    index = 0
    start = int(np.floor(section * HEIGHT / NUMBER_OF_THREADS))
    end = int(np.floor((section + 1) * HEIGHT / NUMBER_OF_THREADS))
    for i in range(start, end):
        for j in range(WIDTH):
            color = tuple(map(int, values[index].split(" ")))
            index += 1
            color_matrix[i * WIDTH + j] = color


serverPort = 12345
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen()
print('The server is up and running')
clients = []
for i in range(NUMBER_OF_THREADS):
    connectionSocket, _ = serverSocket.accept()
    thread = threading.Thread(target=request_processing, args=[connectionSocket, i])
    thread.start()
    clients.append(thread)

for i in range(NUMBER_OF_THREADS):
    clients[i].join()

image = Image.new("HSV", (WIDTH, HEIGHT))
image.putdata(color_matrix)
image = image.convert("RGB")
image.save("mandelbrot.png")
