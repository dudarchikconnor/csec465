import sys
from scapy.all import *

interface  = raw_input(">>>Enter interface to scan    : ")
filterType = raw_input(">>>Enter packet type to filter: ")
duration   = raw_input(">>>Enter duration of search   : ")
ports      = raw_input(">>>Enter port to monitor for  : ")



print "\n[*] Sniffing"
packets = sniff(iface=interface, filter='icmp', timeout=5, count=0, prn=lambda x: x.summary())
wrpcap('packets.pcap', packets)
