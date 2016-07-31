""" XVM (c) www.modxvm.com 2013-2016 """

import httplib
from urlparse import urlparse
import tlslite
import traceback
import gzip
import StringIO
import re
import locale
import datetime

from xfw import IS_DEVELOPMENT, XFW_NO_TOKEN_MASKING

from consts import *
from logger import *
import utils


_USER_AGENT = 'xvm'
try:
    from __version__ import __branch__, __revision__
    _USER_AGENT += '-{0}/{1}'.format(__branch__, __revision__)
except Exception, ex:
    pass

# result: (response, duration)
def loadUrl(url, req=None, body=None, showLog=True, api=XVM.API_VERSION):
    url = url.replace("{API}", api)
    if req is not None:
        url = url.replace("{REQ}", req)
    u = urlparse(url)
    ssl = url.lower().startswith('https://')
    if showLog:
        # hide some chars of token in the log
        path_log = utils.hide_guid(u.path) if not XFW_NO_TOKEN_MASKING else u.path
        log('  HTTP%s: %s' % ('S' if ssl else '', path_log), '[INFO]  ')
    # import time
    # time.sleep(3)

    startTime = datetime.datetime.now()

    (response, compressedSize, errStr) = _loadUrl(u, XVM.TIMEOUT, XVM.FINGERPRINTS, body)

    elapsed = datetime.datetime.now() - startTime
    msec = elapsed.seconds * 1000 + elapsed.microseconds / 1000
    duration = None
    if response:
        if showLog:
            log("  Time: %d ms, Size: %d (%d) bytes" % (msec, compressedSize, len(response)), '[INFO]  ')
        # debug('response: ' + response)
        if not response.lower().startswith('onexception'):
            duration = msec

    return (response, duration, errStr)

def _loadUrl(u, timeout, fingerprints, body):  # timeout in msec
    response = None
    compressedSize = None
    errStr = None
    conn = None
    try:
        # log(u)
        if u.scheme.lower() == 'https':
            checker = tlslite.CheckerXfw(x509Fingerprint=fingerprints) if fingerprints else None
            conn = tlslite.HTTPTLSConnection(u.netloc, timeout=timeout / 1000, checker=checker)
        else:
            conn = httplib.HTTPConnection(u.netloc, timeout=timeout / 1000)
        global _USER_AGENT
        headers = {
            "User-Agent": _USER_AGENT,
            "Connection": "Keep-Alive",
            "Accept-Encoding": "gzip",
            "Content-Type": "text/plain; charset=utf-8"}
        conn.request("POST" if body else "GET", u.path, body, headers)
        resp = conn.getresponse()
        # log(resp.status)

        response = resp.read()
        compressedSize = len(response)

        encoding = resp.getheader('content-encoding')

        if encoding is None:
            pass  # leave response as is
        elif encoding == 'gzip':
            response = gzip.GzipFile(fileobj=StringIO.StringIO(response)).read()
        else:
            raise Exception('Encoding not supported: %s' % encoding)

        # log(response)
        if resp.status not in [200, 202, 204, 401]:  # 200 OK, 202 Accepted, 204 No Content
            m = re.search(r'<body[^>]+?>\r?\n?(.+?)</body>', response, flags=re.S | re.I)
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

    except tlslite.TLSFingerprintError as ex:
        response = None
        err('loadUrl failed: %s' % utils.hide_guid(traceback.format_exc()))
        errStr = str(ex)

    except Exception as ex:
        response = None
        errStr = str(ex)
        if not isinstance(errStr, unicode):
            errStr = errStr.decode(locale.getdefaultlocale()[1]).encode("utf-8")
        # log(errStr)
        tb = traceback.format_exc(1).split('\n')
        err('loadUrl failed: %s%s' % (utils.hide_guid(errStr), tb[1]))

    # finally:
        # if conn is not None:
        #    conn.close()

    return (response, compressedSize, errStr)
