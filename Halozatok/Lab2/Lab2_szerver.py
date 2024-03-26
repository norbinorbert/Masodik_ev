# Boda Norbert, 521, bnim2219
import re
from socket import *
import os
import threading


def determine_content_type(file_name: str):
    extension = file_name.split(".")
    extension = extension[len(extension) - 1]
    content_type = "text/plain"
    match extension:
        case "html":
            content_type = "text/html"
        case "css":
            content_type = "text/css"
        case "jpg":
            content_type = "image/jpeg"
        case "png":
            content_type = "image/png"
        case "webp":
            content_type = "image/webp"
        case "mp4":
            content_type = "video/mp4"
    return content_type


def request_processing(connection_socket, addr):
    try:
        while True:
            request = connection_socket.recv(1024).decode()
            request = request.splitlines()
            if not request:
                break
            print('Request from' + str(addr) + "\n" + request[0] +
                  "\nIn thread: " + threading.current_thread().name + "\n")
            file_name = request[0].split()[1].removeprefix("/")
            pattern = re.compile("Connection:.*")
            if file_name == "":
                file_name = "index.html"
            if not os.path.exists(file_name):
                response = ("HTTP/1.1 404 Not Found\r\n" +
                            "Content-Type: text/plain\r\n" +
                            "Content-Length: 14\r\n" +
                            "Connection: keep-alive\r\n" +
                            "\r\nFile Not Found").encode()
            else:
                file = open(file_name, "rb")
                response = ("HTTP/1.1 200 OK\r\n" +
                            "Content-Type: " + determine_content_type(file_name) + "\r\n" +
                            "Content-Length: " + str(os.path.getsize(file_name)) + "\r\n" +
                            "Connection: keep-alive\r\n" +
                            "\r\n").encode() + file.read()
            connection_socket.send(response)
            connection_header = list(filter(pattern.match, request))
            if not connection_header[0].split()[1] == "keep-alive":
                print("\n\nConnection\n\n")
                break
    except TimeoutError:
        pass
    finally:
        print(threading.current_thread().name + " Connection closed\n")
        connection_socket.close()


serverPort = 12345
serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.bind(('', serverPort))
serverSocket.listen()
# serverSocket.settimeout(5)
print('The server is ready to receive')

alive_threads = False
threads = []
try:
    while True:
        connectionSocket, addr = serverSocket.accept()
        connectionSocket.settimeout(5)
        thread = threading.Thread(target=request_processing, args=(connectionSocket, addr))
        thread.start()
        threads.append(thread)
        alive_threads = True
except TimeoutError:
    for thread in threads:
        thread.join()
    print("No requests came for 5 seconds, shutting down")
