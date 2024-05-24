# Boda Norbert, 521, bnim2219
import struct
from socket import *


# creates a DNS request message
def create_message(domain):
    # headers are hard-coded
    transaction = 1
    flags = 0x0100
    questions = 1
    answerRRs = 0
    authorityRRs = 0
    additionalRRs = 0
    header = (transaction.to_bytes(2) + flags.to_bytes(2) + questions.to_bytes(2) +
              answerRRs.to_bytes(2) + authorityRRs.to_bytes(2) + additionalRRs.to_bytes(2))

    # encode the domain
    question = b''
    for part in domain.split('.'):
        question += len(part).to_bytes()
        question += part.encode()

    # hard code some more headers
    question += (0).to_bytes()
    typeA = 1
    classIN = 1
    question += typeA.to_bytes(2) + classIN.to_bytes(2)
    return header + question


# decodes a DNS response
def decode_response(response):
    # how many answers we got
    answerRRs = int.from_bytes(response[6:8])

    # skip headers
    offset = 12

    # build up the domain that got resolved
    domain = ""
    top_level_domain = ""
    while True:
        length = response[offset]
        if length == 0:
            break
        domain = domain + response[offset + 1: offset + 1 + length].decode() + "."
        if length == 3:
            top_level_domain = response[offset + 1: offset + 1 + length].decode() + "."
        offset += length + 1
    domain = domain[0:len(domain)-1]

    # skip rest of the headers in question
    offset += 5

    # save aliases and ips
    aliases = []
    ips = []
    name = domain
    for _ in range(answerRRs):
        # skip name
        offset += 2
        type_header = int.from_bytes(response[offset:offset + 2])
        # skip rest of headers
        offset += 10
        # A = 1
        if type_header == 1:
            ip = ""
            for i in range(4):
                ip += str(int.from_bytes(response[offset:offset + 1])) + "."
                offset += 1

            ip = ip[0:len(ip) - 1]
            ips.append(ip)
        # CNAME = 5
        if type_header == 5:
            aliases.append(name)
            cname = ""
            missing_top_level_domain = False
            while True:
                length = response[offset]
                if length == 192:
                    missing_top_level_domain = True
                    offset += 1
                    length = 0
                if length == 0:
                    offset += 1
                    break
                cname = cname + response[offset + 1: offset + 1 + length].decode() + "."
                if length == 3:
                    top_level_domain = response[offset + 1: offset + 1 + length].decode() + "."
                offset += length + 1
            if missing_top_level_domain:
                cname = cname + top_level_domain
            name = cname[0:len(cname)-1]

    # output to console
    print('Name: ' + name)
    print('Addresses: ')
    for ip in ips:
        print(ip)
    if len(aliases):
        print('Aliases: ')
        for alias in aliases:
            print(alias)


serverName = '8.8.8.8'
serverPort = 53
clientSocket = socket(AF_INET, SOCK_DGRAM)
clientSocket.connect((serverName, serverPort))

domain = input('Domain: ')
request = create_message(domain)
clientSocket.send(request)

response = clientSocket.recv(1024)
decode_response(response)

clientSocket.close()
