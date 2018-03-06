# Zhi-Han Ling
# Python Port Scanner

import socket
import ipaddress
import os
import subprocess


def main():
    """
    Main function that takes input of a range of IP Addresses and a range of ports
    First checks if IP address are up then
    Scans the range of IP Address with the Range of Ports
    """
    iprange = input('Enter IP Address Range: ')
    portrange = input('Enter Port Range: ')

    if "-" in iprange: # IP Address Parsing
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

    else:
        ipStart = int(ipaddress.IPv4Address(iprange))
        ipEnd = ipStart

    if "-" in portrange: # Port range parsing
        port = portrange.split("-")
        startPort = int(port[0])
        endPort = int(port[1])

    else:
        port = portrange
        startPort = int(port)
        endPort = int(port)

    while ipStart <= ipEnd: # Scans IP for range of ports
        FNULL = open(os.devnull)
        reply = subprocess.call(["ping ", str(ipaddress.IPv4Address(ipStart))],
                                stdout=FNULL, stderr=subprocess.STDOUT) # Checks if IP Address is up
        if reply == 0:
            print("IP Address is: ", str(ipaddress.IPv4Address(ipStart)))
            openPorts = []
            currentPort = startPort
            while currentPort <= endPort:
                openClose = pScan(str(ipaddress.IPv4Address(ipStart)), int(currentPort))
                if openClose:
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
        else:
            print("IP Address: ", str(ipaddress.IPv4Address(ipStart)), "is not up.")
        ipStart += 1


def pScan(ip, port):
    """
    Tries to connect with the IP Address through the port given
    :param ip: (String) IP Address to be scanned
    :param port: (Int) Port to be scanned
    :return: True if connection is open. False otherwise.
    """
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
