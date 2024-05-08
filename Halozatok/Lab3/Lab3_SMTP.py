# Boda Norbert, 521, bnim2219
from socket import *

serverName = "localhost"
serverPort = 25
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((serverName, serverPort))
defaultSentence = clientSocket.recv(1024)

helo = "HELO fakeSMTP\r\n"
clientSocket.send(helo.encode())
heloResponse = clientSocket.recv(1024).decode()
if heloResponse.split()[0] != "250":
    clientSocket.close()
    print("Error at HELO command")
    exit(1)

mailFrom = input("MAIL FROM: ")
mailFrom = "MAIL FROM: " + mailFrom + "\r\n"
clientSocket.send(mailFrom.encode())
mailFromResponse = clientSocket.recv(1024).decode()
if mailFromResponse.split()[0] != "250":
    clientSocket.close()
    print(mailFromResponse)
    print("Error at MAIL FROM command")
    exit(1)


recpTo = input("RCPT TO: ")
recpTo = "RCPT TO: " + recpTo + "\r\n"
clientSocket.send(recpTo.encode())
recpToResponse = clientSocket.recv(1024).decode()
if recpToResponse.split()[0] != "250":
    clientSocket.close()
    print("Error at RCPT TO command")
    exit(1)

data = "DATA\r\n"
clientSocket.send(data.encode())
dataResponse = clientSocket.recv(1024).decode()
if dataResponse.split()[0] != "354":
    clientSocket.close()
    print("Error at DATA command")
    exit(1)

from_ = input("Email from: ")
to = input("Email to: ")
subject = input("Subject: ")
print("Email body (press Ctrl-D on a new line if you are done typing):")
emailBody = ''
while True:
    try:
        line = input()
    except EOFError:
        break
    emailBody = emailBody + line + "\r\n"

email = ("From: " + from_ + "\r\nTo: " + to + "\r\nSubject: " +
         subject + "\r\n\r\n" + emailBody + ".\r\n")
clientSocket.send(email.encode())
emailResponse = clientSocket.recv(1024).decode()
if emailResponse.split()[0] != "250":
    clientSocket.close()
    print("Error sending the mail")
    exit(1)

quit_ = 'QUIT\r\n'
clientSocket.send(quit_.encode())
quitResponse = clientSocket.recv(1024)
clientSocket.close()
