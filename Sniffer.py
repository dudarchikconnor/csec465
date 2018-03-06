#Audit Lab 3 interesting enumeration tool
#Aoi Landphere
#Traffic Sniffer with filter function.
#Can be used to monitor traffic in environment where wireshark is not an option.

#Import statement for scapy and sys lib.
import sys
from scapy.all import *

#Specify the interface for the sniffer to scan for traffic.
#If the interface does not get specify print error and exit.
interface  = raw_input(">>>Enter interface to scan: ")
if(len(interface)==0):
	print "No interface specified, exiting..."
	sys.exit(1)

#This will ask the user to pick with method (port or packet type or neither) to filter for.
portOrType = raw_input("Type packet or port to filter for them, press enter if no filter: ")
#If the port option is picked it will ask the user for packet type such as icmp to filter for.
if (portOrType.upper() == "PACKET"):
	filtering = ""
	count = 0
	print ">>>Enter packet type to filter for, or enter to move on:"
	while(True):
		filType = raw_input(">>>")
		if(len(filType)>0):
			if(count > 0):
				filtering += " and "
			filtering += filType
			count+=1
		else:
			break
#Port option will ask the user for port number to filter for such as 80 for http.
elif(portOrType.upper() == "PORT"):
	filtering = ""
	count = 0
	print ">>>Enter TCP ports to filter for, or enter to move on:"
	while(True):
		port = raw_input(">>>")
		if(len(port)>0):
			if(count == 0):
				filtering += "tcp and ("
			if(count > 0):
				filtering += " or "
			filtering += "port " + port
			count+=1
		else:
			if(count > 0):
				filtering += ")"
			break
#If any other combonation of letter is picked it will print error statement and exit.
elif(portOrType.upper() != ""):
	print "Invalid input, exiting..."
	sys.exit(1)
#If no character is entered it assumes that no filter is needed and set it to no filter.
else:
	filtering = ""
#This will output the formatted filter for easier view in the command line.
print filtering

#This will ask the user for duration of the traffic sniffing. Default is set to 5sec.
#I have not added option for infinite duration.
duration = raw_input(">>>Enter duration of search (default=5): ")
if(duration == ""):
	duration = 5
else:
	duration = int(duration)

#This will print and specify that everything has been configured and started to monitor the network.
print "\nMonitoring in progress"
packets = sniff(iface=interface, filter=filtering, timeout=duration, count=0, prn=lambda x: x.summary())

#This function will take all the output the scapy sniff functions gives us into pcap file which can be accessed
#using wireshark for further analysis.
wrpcap('packets.pcap', packets)
