#!/usr/bin/env python

from socket import *
import time

from zlib import crc32

import struct
#
# Ethernet Frame:
# [
#   [ Destination address, 6 bytes ]
#   [ Source address, 6 bytes      ]
#   [ Ethertype, 2 bytes           ]
#   [ Payload, 40 to 1500 bytes    ]
#   [ 32 bit CRC chcksum, 4 bytes  ]
# ]
#

# def get_crc32_hex(filename):
#     with open(filename, 'rb') as f:
#         return crc32(f.read())
# checksum = struct.pack('<L', crc32(payload))


s = socket(AF_PACKET, SOCK_RAW)
s.bind(("enp5s0f1", 0))
src_addr = "\x78\x24\xaf\xc8\xa0\xbb"
dst_addr = "\x00\x23\x9e\x03\x6d\x6e"
# # dst_addr = "\x00\x23\x9e\x03\x2f\xdf"
payload = ("["*30)+"PAYLOAD"+("]"*1400)
checksum = "\x00\x00\x00\x00"
ethertype = "\x08\x00"


for x in range(0, 10000*200):
    s.send(dst_addr + src_addr + ethertype + payload + checksum)
    time.sleep(0.0001)
    if x % 100 == 0:
        print x


# s.send(dst_addr+src_addr+ethertype+payload+checksum)

