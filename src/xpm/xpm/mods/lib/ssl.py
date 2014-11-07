""" XPM wrapper for SSL lib using tlslite (c) www.modxvm.com 2014 """

from xpm import log

CERT_NONE = 0
CERT_REQUIRED = 1
PROTOCOL_SSLv23 = 'SSLv23'
PROTOCOL_TLSv1 = 'TLSv1'

import tlslite
from tlslite.tlsconnection import TLSConnection
from tlslite.integration.clienthelper import ClientHelper

class SSLError(tlslite.TLSError):
    pass

#tlslite.TLSError.strerror = property(lambda: str(self))

def match_hostname(cert, hostname):
    raise NotImplementedError()

def wrap_socket(sock,
    keyfile = None,
    certfile = None,
    server_side = False,
    cert_reqs = CERT_NONE,
    ssl_version = PROTOCOL_SSLv23,
    ca_certs = None,
    do_handshake_on_connect = True,
    suppress_ragged_eofs = True,
    ciphers = None,
    fingerprint = None):

    try:
        sock = TLSConnection(sock)

        if do_handshake_on_connect:
            checker = None if fingerprint is None else tlslite.Checker(x509Fingerprint=fingerprint)
            helper = ClientHelper(checker=checker)
            helper._handshake(sock)
    except:
        sock = None
        raise

    return sock
