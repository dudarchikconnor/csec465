# Zhi-Han Ling
# Python Port Scanner

import socket
import ipaddress

def main():
    iprange = input('Enter IP Address Range: ')
    portrange = input('Enter Port Range: ')


    if "-" in iprange:
        ipAddr = iprange.split("-")
        print(ipAddr)
        ipStart = int(ipaddress.IPv4Address(ipAddr[0]))
        ipEnd = int(ipaddress.IPv4Address(ipAddr[1]))

    elif "/" in iprange:
        ipAddr = iprange.split("/")
        ipStart = int(ipaddress.IPv4Address(ipAddr[0]))
        if ipAddr[1] == "8":
            ipEnd = ipStart + 16777214
        elif ipAddr[1] == "16":
            ipEnd = ipStart + 65534
        elif ipAddr[1] == "24":
            ipEnd = ipStart + 254
        print(ipStart, " ", ipEnd)

    else:
        ipStart = int(ipaddress.IPv4Address(iprange))
        ipEnd = ipStart

    if "-" in portrange:
        port = portrange.split("-")
        print(port)
        startPort = int(port[0])
        endPort = int(port[1])

    else:
        port = portrange
        startPort = int(port)
        endPort = int(port)

    while ipStart <= ipEnd:
        print("IP Addess is: ", str(ipaddress.IPv4Address(ipStart)))
        openPorts = []
        currentPort = startPort
        while currentPort <= endPort:
            openClose = pScan(str(ipaddress.IPv4Address(ipStart)), int(currentPort))
            if openClose == True:
                openPorts.append(currentPort)
            currentPort += 1
        print("Open ports are: ", end='')
        i = 0
        while i < len(openPorts):
            if i == (len(openPorts) - 1):
                print(openPorts[i], end='')
            else:
                print(openPorts[i], ", ", end='')
            i += 1
        print("\n")
        ipStart += 1



def pScan(ip, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(.01)
    try:
        sock.connect((ip, port))
        return True
    except socket.error:
        return False
    except socket.timeout:
        return False


if __name__ == '__main__':
    main()