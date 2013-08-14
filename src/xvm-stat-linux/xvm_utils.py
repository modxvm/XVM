#!/usr/bin/env python2
# -*- coding: utf-8 -*-

""" This file contains helper classes and tools for XVM FUSE driver.
    required for XVM mod.

    XVM is popular mod for 'Worls of Tanks' MMO game.
    Original mod is located at http://code.google.com/p/wot-xvm/

    This code is distributed under GNU GPL v3 public license.
"""

import os, logging

XVM_LOG = 'xvmfs.log'
XVM_STAT_LOG = 'xvmfs-stat.log'

Log = None
LogStat = None
parts = {}

def configureLoggers(logDir, level):
    """Create and customize logger objects"""
    global Log, LogStat

    if not os.path.isfile(logDir) and not os.path.isdir(logDir):
        os.makedirs(logDir)

    formatter = logging.Formatter("%(asctime)s %(levelname)-7s: %(message)s")
    handler = logging.FileHandler(os.path.join(logDir, XVM_LOG), mode='w')
    handler.setFormatter(formatter)

    Log = logging.getLogger('XVM')
    Log.setLevel(level)
    Log.addHandler(handler)

    handler = logging.FileHandler(os.path.join(logDir, XVM_STAT_LOG), mode='w')
    handler.setFormatter(formatter)

    LogStat = logging.getLogger('XVM-STAT')
    LogStat.setLevel(level)
    LogStat.addHandler(handler)

def locate_file(filename):
    # Check if exact file exists
    absname = os.path.abspath(filename)
    if os.path.exists(absname):
        return absname

    fdir, fname = os.path.split(absname)

    if not os.path.isdir(fdir):
        # Directory does not exist or have name in other case
        fdir = locate_file(fdir)
        if fdir is None:
            # Directory does not exist
            return None

    fname = fname.lower()
    found = next((x for x in os.listdir(fdir) if x.lower() == fname), None)

    if found:
        return os.path.join(fdir, found)
    else:
        return None

class Parts:
    """    Join together parts of a message and decode it.
    Usage example:
        p = Parts()
        p.SetPart(0,'6c6f72656d2069707')
        p.SetPart(1,'3756d20646f6c6f72207369')
        p.SetPart(2,'7420616d6574')
        p.length = 52
        p.IsComplete()
        print p.value
    The output should be 'lorem ipsum dolor sit amet'
    """
    def __init__(self):
        self.value = None
        self.length = -1
        self.parts = []

    def IsComplete(self):
        if self.value is not None:
            return True
        if None in self.parts:
            return False

        v = ''.join(self.parts)
        self.value = v.decode('hex') if len(v) == self.length else None
        return self.value != None

    def SetPart(self, id, value):
        if len(self.parts) <= id:
            self.parts.extend((id - len(self.parts) + 1) * [None])
        self.parts[id] = value

def CollectParts(parameters):
    param_list = parameters.split(',', 2)
    if len(param_list) != 3:
        Log.error('Malformed parameters: ' + str(parameters))
        return None

    (cmdId, partId, params) = param_list
    try:
        partId = int(partId, 16)
    except ValueError, ve:
        Log.error(str(ve))
        return None
    if cmdId[0] == '_':
        Log.warning('Unknown SWF sandbox ' + cmdId)
    if cmdId not in parts:
        parts[cmdId] = Parts()

    part = parts[cmdId]
    if partId == 0:
        try:
            (length, params) = params.split(',', 1)
            part.length = int(length, 16)
        except ValueError, ve:
            Log.error(str(ve))
            return None
    part.SetPart(partId, params)
    if not part.IsComplete():
        return None

    del parts[cmdId]
    return part.value

