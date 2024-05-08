# Boda Norbert, 521, bnim2219
from socket import *
import threading

clients = {}
clientSockets = {}


def login(connection_socket, request, name):
    if name == '':
        # check if request has all parameters
        if len(request) < 2:
            connection_socket.send('Please provide a username when you try to log in\n'.encode())
            return name

        # update clients list
        name = request[1]

        # check if username is not in use
        if clients.get(name) is not None:
            connection_socket.send('Username already in use, please log in with a different alias\n'.encode())
            return ''
        clients.update({name: True})
        clientSockets.update({name: connection_socket})
        connection_socket.send(('Welcome ' + name + '\n').encode())
        return name

    # can't log in twice
    connection_socket.send('You are already logged in. Provide another command\n'.encode())
    return name


def whisper(connection_socket, request, name):
    # check if user is logged in
    if name == '':
        connection_socket.send('Please log in first using the "login" command\n'.encode())
        return

    # check if request has all parameters
    if len(request) < 2:
        connection_socket.send('Please provide the user you''d like to send a whisper to\n'.encode())
        return

    # check if recipient exists
    recipient = request[1]
    if clients.get(recipient) is None:
        connection_socket.send((recipient + ' is not logged in\n').encode())
        return
    if len(request) < 3:
        connection_socket.send('Please provide a message\n'.encode())
        return

    # read the message and send it to the recipient
    message = name + ': '
    for i in range(2, len(request)):
        message = message + request[i] + '\n'
    clientSockets.get(recipient).send(message.encode())


def broadcast(connection_socket, request, name):
    # check if user is logged in
    if name == '':
        connection_socket.send('Please log in first using the "login" command\n'.encode())
        return

    # check if request has all parameters
    if len(request) < 2:
        connection_socket.send('Please provide a message\n'.encode())
        return

    # read the message and send it to all users
    message = name + ': '
    for i in range(1, len(request)):
        message = message + request[i] + '\n'
    for recipient in clients:
        clientSockets.get(recipient).send(message.encode())


def user_list(connection_socket):
    # send a message that contains all usernames
    users = ''
    for user in clients:
        users = users + user + "\n"
    if users == '':
        connection_socket.send('There are no logged in users\n'.encode())
    else:
        connection_socket.send(('All logged in users:\n' + users).encode())


def logout(connection_socket, name):
    # delete the user from the list
    if name != '':
        clients.pop(name, None)
        clientSockets.pop(name, None)
        print(name + " has disconnected\n")
    connection_socket.close()


def request_processing(connection_socket):
    name = ''
    while True:
        try:
            request = connection_socket.recv(1024).decode()
        except ConnectionResetError:
            request = 'logout'
        if not request or request == '':
            break
        request = request.splitlines()
        match request[0]:
            case 'login':
                name = login(connection_socket, request, name)
                continue
            case 'whisper':
                whisper(connection_socket, request, name)
                continue
            case 'broadcast':
                broadcast(connection_socket, request, name)
                continue
            case 'user list':
                user_list(connection_socket)
                continue
            case 'logout':
                logout(connection_socket, name)
                break
            case _:
                connection_socket.send(('Unknown command: "' + request[0] + '"\n').encode())
                continue


serverPort = 12345
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen()
print('The server is up and running')
while True:
    connectionSocket, _ = serverSocket.accept()
    thread = threading.Thread(target=request_processing, args=[connectionSocket])
    thread.start()
