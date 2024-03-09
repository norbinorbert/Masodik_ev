# Boda Norbert, 521, bnim2219
from socket import *

serverPort = 12345
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen()
print('The server is ready to receive')

while True:
    connectionSocket, _ = serverSocket.accept()
    sentence = connectionSocket.recv(1024).decode()
    capitalizedSentence = sentence.upper()
    connectionSocket.send(capitalizedSentence.encode())
    connectionSocket.close()
    if capitalizedSentence == 'EXIT':
        print('Shutting down server')
        break
