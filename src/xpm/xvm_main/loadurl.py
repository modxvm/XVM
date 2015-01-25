""" XVM (c) www.modxvm.com 2013-2015 """

from pprint import pprint
import httplib
from urlparse import urlparse
import tlslite
import traceback
import gzip
import StringIO
import re
import locale
import datetime

from xfw import IS_DEVELOPMENT
from constants import *
from logger import *
import utils

# result: (response, duration)
def loadUrl(url, req=None, body=None, showLog=True):
    url = url.replace("{API}", XVM_API_VERSION)
    if req is not None:
        url = url.replace("{REQ}", req)
    u = urlparse(url)
    ssl = url.lower().startswith('https://')
    if showLog or IS_DEVELOPMENT:
        # hide some chars of token in the log
        path_log = utils.hide_guid(u.path) if not IS_DEVELOPMENT else u.path
        log('  HTTP%s: %s' % ('S' if ssl else '', path_log), '[INFO]  ')
    #import time
    #time.sleep(3)

    startTime = datetime.datetime.now()

    (response, compressedSize, errStr) = _loadUrl(u, XVM_TIMEOUT, XVM_FINGERPRINT, body)

    elapsed = datetime.datetime.now() - startTime
    msec = elapsed.seconds * 1000 + elapsed.microseconds / 1000
    if response:
        log("  Time: %d ms, Size: %d (%d) bytes" % (msec, compressedSize, len(response)), '[INFO]  ')
        #debug('response: ' + response)
        if not response.lower().startswith('onexception'):
            duration = msec
    else:
        duration = None

    return (response, duration, errStr)

def _loadUrl(u, timeout, fingerprint, body): # timeout in msec
    response = None

    response = None
    compressedSize = None
    errStr = None
    conn = None
    try:
        #log(u)
        if u.scheme.lower() == 'https':
            checker = tlslite.Checker(x509Fingerprint=fingerprint)
            conn = tlslite.HTTPTLSConnection(u.netloc, timeout=timeout/1000, checker=checker)
        else:
            conn = httplib.HTTPConnection(u.netloc, timeout=timeout/1000)
        headers = {
            "Connection":"Keep-Alive",
            "Accept-Encoding":"gzip",
            "Content-Type": "text/plain; charset=utf-8"}
        conn.request("POST" if body else "GET", u.path, body, headers)
        resp = conn.getresponse()
        #log(resp.status)

        response = resp.read()
        compressedSize = len(response)

        encoding = resp.getheader('content-encoding')

        if encoding is None:
            pass # leave response as is
        elif encoding == 'gzip':
            response = gzip.GzipFile(fileobj=StringIO.StringIO(response)).read()
        else:
            raise Exception('Encoding not supported: %s' % (encoding))

        #log(response)
        if not resp.status in [200, 202]: # 200 OK, 202 Accepted
            m = re.search(r'<body[^>]+?>\r?\n?(.+?)</body>', response, flags=re.S|re.I)
            if m:
                response = m.group(1)
            response = re.sub(r'<[^>]+>', '', response)
            response = re.sub(r'nginx/\d+\.\d+\.\d+', '', response)
            response = response.strip()
            raise Exception('HTTP Error: [%i] %s. Response: %s' % (resp.status, resp.reason, response[:256]))

    except tlslite.TLSLocalAlert as ex:
        response = None
        err('loadUrl failed: %s' % utils.hide_guid(traceback.format_exc()))
        errStr = str(ex)

    except Exception as ex:
        response = None
        errStr = str(ex)
        if not isinstance(errStr, unicode):
            errStr = errStr.decode(locale.getdefaultlocale()[1]).encode("utf-8")
        #log(errStr)
        tb = traceback.format_exc(1).split('\n')
        err('loadUrl failed: %s%s' % (utils.hide_guid(errStr), tb[1]))

    #finally:
        #if conn is not None:
        #    conn.close()

    return (response, compressedSize, errStr)
