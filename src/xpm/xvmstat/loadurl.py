""" xvm (c) sirmax 2013-2014 """

from pprint import pprint
import httplib
from urlparse import urlparse
import tlslite
import traceback
import gzip
import StringIO
import re

from constants import *
from logger import *

# result: (response, duration)
def loadUrl(url, req=None):
    url = url.replace("{API}", XVM_STAT_API_VERSION)
    if req is not None:
        url = url.replace("{REQ}", req)
    u = urlparse(url)
    ssl = url.lower().startswith('https://')
    # hide some chars of token in the log
    path_log = re.sub('([0-9A-Fa-f]{8}-)[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}(-[0-9A-Fa-f]{12})', \
        '\\1****-****-****\\2', u.path)
    log('  HTTP%s: %s' % ('S' if ssl else '', path_log), '[INFO]  ')
    #time.sleep(5)

    startTime = datetime.datetime.now()

    (response, compressedSize) = _loadUrl(u, XVM_STAT_TIMEOUT, XVM_STAT_FINGERPRINT)

    elapsed = datetime.datetime.now() - startTime
    msec = elapsed.seconds * 1000 + elapsed.microseconds / 1000
    if response:
        log("  Time: %d ms, Size: %d (%d) bytes" % (msec, compressedSize, len(response)), '[INFO]  ')
        #debug('response: ' + response)
        if not response.lower().startswith('onexception'):
            duration = msec
    else:
        duration = None

    return (response, duration)

def _loadUrl(u, timeout, fingerprint): # timeout in msec
    response = None

    response = None
    compressedSize = None
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
            "Accept-Encoding":"gzip"} # deflate
        conn.request("GET", u.path, None, headers)
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

        if not resp.status in [200, 202]: # 200 OK, 202 Accepted
            raise Exception('HTTP Error: [%i] %s. Response: %s' % (resp.status, resp.reason, response[:100]))

    except tlslite.TLSLocalAlert:
        err('loadUrl failed: %s' % traceback.format_exc())
    
    except Exception:
        response = None
        tb = traceback.format_exc(1).split('\n')
        err('loadUrl failed: %s %s' % (tb[2], tb[1]))
    
    #finally:
        #if conn is not None:
        #    conn.close()

    return (response, compressedSize)
