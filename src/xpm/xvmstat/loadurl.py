""" xvm (c) sirmax 2013-2014 """

from pprint import pprint
import httplib
import tlslite
import traceback
import gzip
import StringIO

from logger import *

def LoadUrl(u, timeout, fingerprint): # timeout in msec
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
        #conn.request("GET", u.path, None, {"Connection":"Keep-Alive","Accept-Encoding":"gzip"}) # deflate
        headers = {
            "Connection":"Keep-Alive",
            "Accept-Encoding":"gzip"} # deflate
        conn.request("GET", u.path, None, headers)
        resp = conn.getresponse()
        #log(resp.status)

        if resp.status in [200, 202]:
            # 200 OK, 202 Accepted

            response = resp.read()
            compressedSize = len(response)

            encoding = resp.getheader('content-encoding')

            if encoding is None:
                pass # leave response as is
            elif encoding == 'gzip':
                response = gzip.GzipFile(fileobj=StringIO.StringIO(response)).read()
            else:
                raise Exception('Encoding not supported: %s' % (encoding))
        else:
            raise Exception('HTTP Error: [%i] %s' % (resp.status, resp.reason))
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
