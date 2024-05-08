# Boda Norbert, 521, bnim2219
from socket import *
import threading

serverName = 'localhost'
serverPort = 12345
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))


def read_messages():
    while True:
        message = clientSocket.recv(1024)
        if not message:
            break
        print(message.decode())


thread = threading.Thread(target=read_messages)
thread.start()
print('Hello, please write your commands here: (end with a comma on an empty line if done typing)')
while True:
    command = ''
    while True:
        line = input()
        if line == ',':
            break
        command = command + line + "\n"
    clientSocket.send(command.encode())
    if command == 'logout\n':
        thread.join()
        break
clientSocket.close()
