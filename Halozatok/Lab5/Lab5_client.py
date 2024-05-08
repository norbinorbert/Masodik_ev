# Boda Norbert, 521, bnim2219
from socket import *
import numpy as np

serverName = 'localhost'
serverPort = 12345
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))

message = clientSocket.recv(1024).decode().split()

MAXIMUM_ITERATIONS = int(message[0])
WIDTH = int(message[1])
HEIGHT = int(message[2])
SECTION = int(message[3])
NUMBER_OF_PARTITIONS = int(message[4])

start = int(np.floor(SECTION * HEIGHT / NUMBER_OF_PARTITIONS))
end = int(np.floor((SECTION + 1) * HEIGHT / NUMBER_OF_PARTITIONS))
for i in range(start, end):
    for j in range(WIDTH):
        x0 = j / WIDTH * 2.5 - 2
        y0 = i / HEIGHT * 2 - 1
        x = 0
        y = 0
        iteration = 0
        while x*x + y*y <= 4 and iteration < MAXIMUM_ITERATIONS:
            temp_x = x * x - y * y + x0
            y = 2 * x * y + y0
            x = temp_x
            iteration += 1
        hue = int(255 * iteration / MAXIMUM_ITERATIONS)
        saturation = 255
        value = 255 if iteration < MAXIMUM_ITERATIONS else 0
        clientSocket.send((str(hue) + " " + str(saturation) + " " + str(value) + ",").encode())
clientSocket.close()
