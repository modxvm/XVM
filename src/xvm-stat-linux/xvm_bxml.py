#!/usr/bin/env python2
# -*- coding: utf-8 -*-

""" This file contains binary XML decoder for XVM mod.

    XVM is popular mod for 'Worls of Tanks' MMO game.
    Original mod is located at http://code.google.com/p/wot-xvm/

    This code is distributed under GNU GPL v3 public license.
"""

import sys, os, struct
from xml.dom import minidom
from cStringIO import StringIO

class BxmlDecoder:
    magic = '0x62a14e45'
    intToBase64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

    def __init__(self, filename=None):
        self.filename = filename
        self.stream = None
        self.xmlroot = None
        self.doc = None
        self.dictionary = []

    def decode(self):
        if self.filename is None:
            return None

        self.doc = minidom.Document()
        rname = os.path.basename(self.filename).lower()
        data = ''
        with open(self.filename, 'rb') as f:
            data = f.read()

        magic = hex(struct.unpack('<i', data[0:4])[0])
        if magic != BxmlDecoder.magic:
            raise IOError('File %s have invalid header' % self.filename)

        self.dictionary, ptr = BxmlDecoder.readDict(data)
        self.stream = StringIO(data)
        self.stream.seek(ptr)

        self.xmlroot = self.doc.createElement(rname)
        self.readElement(self.xmlroot)
        self.doc.appendChild(self.xmlroot)

        self.stream.close()
        return self.doc.toxml()

    @staticmethod
    def readDict(data):
        pos = lambda x: data.find('\x00', x + 1)
        prev = pos(0)
        idx = pos(prev)
        res = []
        while idx >= 0:
            if prev + 1 >= idx:
                break
            res.append(data[prev+1:idx])
            prev = idx
            idx = pos(prev)

        return res, idx + 1

    def readElement(self, node):
        childNum = self.readLittleEndianShort()
        dataDesc = self.readDataDescriptor()
        children = self.readElementDescriptors(childNum)

        offset = self.readData(node, 0, dataDesc)

        for elementDescriptor in children:
            child = self.doc.createElement(self.dictionary[elementDescriptor['nameIndex']])
            offset = self.readData(child, offset, elementDescriptor['dataDescriptor'])
            node.appendChild(child)

    def readLittleEndianShort(self):
       return struct.unpack('<h', self.stream.read(2))[0]

    def readLittleEndianInt(self):
       return struct.unpack('<i', self.stream.read(4))[0]

    def readDataDescriptor(self):
        code = self.readLittleEndianInt()
        end = code & 0x0fffffff
        dtype = code >> 28
        addr = self.stream.tell()
        return dict(end=end, type=dtype, address=addr)

    def readElementDescriptors(self, childNum):
        elements = []
        for i in range(childNum):
            idx = self.readLittleEndianShort()
            data = self.readDataDescriptor()
            elements.append(dict(nameIndex=idx, dataDescriptor=data))
        return elements

    def readData(self, node, offset, dataDesc):
        lengthInBytes = dataDesc['end'] - offset
        if dataDesc['type'] == 0x0:
            # Element
            self.readElement(node)

        elif dataDesc['type'] == 0x1:
            # String
            string = self.stream.read(lengthInBytes)
            node.appendChild(self.doc.createTextNode(string))

        elif dataDesc['type'] == 0x2:
            # Integer
            string = self.readNumber(lengthInBytes)
            node.appendChild(self.doc.createTextNode("\t%s\t" % string))

        elif dataDesc['type'] == 0x3:
            # Floats
            arr = self.readFloats(lengthInBytes)
            if len(arr) != 12:
                node.appendChild(self.doc.createTextNode("\t%s\t" % ' '.join(arr)))
            else:
                row0 = self.doc.createElement('row0')
                row1 = self.doc.createElement('row1')
                row2 = self.doc.createElement('row2')
                row3 = self.doc.createElement('row3')

                row0.appendChild(self.doc.createTextNode("\t%s %s %s\t" % (arr[0], arr[1], arr[2])))
                row1.appendChild(self.doc.createTextNode("\t%s %s %s\t" % (arr[3], arr[4], arr[5])))
                row2.appendChild(self.doc.createTextNode("\t%s %s %s\t" % (arr[6], arr[7], arr[8])))
                row3.appendChild(self.doc.createTextNode("\t%s %s %s\t" % (arr[9], arr[10], arr[11])))

                node.appendChild(row0)
                node.appendChild(row1)
                node.appendChild(row2)
                node.appendChild(row3)

        elif dataDesc['type'] == 0x4:
            # Boolean
            node.appendChild(self.doc.createTextNode("\t%s\t" %
                str(self.readBoolean(lengthInBytes)).lower()))

        elif dataDesc['type'] == 0x5:
            # Base64
            string = self.readBase64(lengthInBytes)
            node.appendChild(self.doc.createTextNode("\t%s\t" % string))
        else:
            raise ValueError('Unknown type 0x%x in descriptor %s' %
                (dataDesc['type'], str(dataDesc)))

        return dataDesc['end']

    def readNumber(self, lengthInBytes):
        res = '0'
        if lengthInBytes == 1:
            res = str(struct.unpack('b', self.stream.read(1))[0])
        elif lengthInBytes == 2:
            res = str(self.readLittleEndianShort())
        elif lengthInBytes == 4:
            res = str(self.readLittleEndianInt())
        return res

    def readFloats(self, lengthInBytes):
        buf = ['%1.6f' % struct.unpack('<f', self.stream.read(4))[0]
            for i in range(lengthInBytes / 4)]
        return buf

    def readBoolean(self, lengthInBytes):
        if lengthInBytes != 1:
            return False

        b = struct.unpack('?', self.stream.read(1))[0]
        if not b:
            raise ValueError('Boolean error')
        return b

    def readBase64(self, lengthInBytes):
        def byteArrayToBase64(data):
            byte_data = [struct.unpack('B', data[x])[0] for x in range(len(data))]
            aLen = len(byte_data)
            numFullGroups = aLen / 3
            numBytesInPartialGroup = aLen - 3 * numFullGroups
            result = []
            inCursor = 0

            for i in range(numFullGroups):
                byte0 = byte_data[inCursor]
                byte1 = byte_data[inCursor+1]
                byte2 = byte_data[inCursor+2]
                inCursor += 3

                result.append(BxmlDecoder.intToBase64[byte0 >> 2])
                result.append(BxmlDecoder.intToBase64[(byte0 << 4) & 0x3f | (byte1 >> 4)])
                result.append(BxmlDecoder.intToBase64[(byte1 << 2) & 0x3f | (byte2 >> 6)])
                result.append(BxmlDecoder.intToBase64[byte2 & 0x3f])

            if numBytesInPartialGroup != 0:
                byte0 = byte_data[inCursor]
                inCursor += 1
                result.append(BxmlDecoder.intToBase64[byte0 >> 2])

                if numBytesInPartialGroup == 1:
                    result.append(BxmlDecoder.intToBase64[(byte0 << 4) & 0x3f])
                    result.append('==')
                else:
                    byte1 = byte_data[inCursor]
                    inCursor += 1
                    result.append(BxmlDecoder.intToBase64[(byte0 << 4) & 0x3f | (byte1 >> 4)])
                    result.append(BxmlDecoder.intToBase64[(byte1 << 2) & 0x3f])
                    result.append('=')

            return ''.join(result)

        bin_data = self.stream.read(lengthInBytes)
        return byteArrayToBase64(bin_data)

