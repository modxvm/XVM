""" XVM (c) https://modxvm.com 2013-2021 """

import base64
import datetime
import gzip
import httplib
import locale
import os
import re
import StringIO
import traceback
from urlparse import urlparse

from xfw import IS_DEVELOPMENT, XFW_NO_TOKEN_MASKING

from consts import *
from logger import *
import utils

try:
    _proxy = os.environ.get('XVM_HTTPS_PROXY')
    if _proxy:
        _proxy = urlparse(_proxy)
except Exception, ex:
    _proxy = None
    err(traceback.format_exc())

_USER_AGENT = 'xvm-{0}#{1}'.format(XVM.XVM_VERSION, XVM.XVM_REVISION)

# result: (response, duration)
def loadUrl(url, req=None, body=None, content_type='text/plain; charset=utf-8', showLog=True, api=XVM.API_VERSION):
    url = url.replace("{API}", api)
    if req is not None:
        url = url.replace("{REQ}", req)
    u = urlparse(url)
    ssl = url.lower().startswith('https://')
    if showLog:
        # hide some chars of token in the log
        path_log = utils.hide_guid(u.path) if not XFW_NO_TOKEN_MASKING else u.path
        log('  HTTP%s: %s%s' % ('S' if ssl else '', path_log, '?' + u.query if u.query else ''), '[INFO]  ')

    startTime = datetime.datetime.now()

    #import time
    #time.sleep(3)

    (response, compressedSize, errStr) = _loadUrl(u, XVM.TIMEOUT, body, content_type)
    # repeat request on timeout
    if errStr is not None and 'timed out' in errStr:
        (response, compressedSize, errStr) = _loadUrl(u, XVM.TIMEOUT, body, content_type)

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

def _loadUrl(u, timeout, body, content_type): # timeout in msec
    response = None
    compressedSize = None
    errStr = None
    conn = None
    try:
        #log(u)
        cls = httplib.HTTPSConnection if u.scheme.lower() == 'https' else httplib.HTTPConnection
        global _proxy
        #log(_proxy)
        if _proxy:
            conn = cls(_proxy.hostname, _proxy.port, timeout=timeout / 1000)
            headers = {}
            if _proxy.username and _proxy.password:
                auth = '%s:%s' % (_proxy.username, _proxy.password)
                headers['Proxy-Authorization'] = 'Basic ' + base64.b64encode(auth)
            #log(headers)
            conn.set_tunnel(u.hostname, u.port, headers=headers)
        else:
            conn = cls(u.netloc, timeout=timeout / 1000)

        global _USER_AGENT
        headers = {
            "User-Agent": _USER_AGENT,
            "Accept-Encoding": "gzip",
            "Content-Type": content_type}
        conn.request("POST" if body else "GET", u.path + ('?' + u.query if u.query else ''), body, headers)
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

    except Exception as ex:
        response = None
        errStr = str(ex)
        if not isinstance(errStr, unicode):
            errStr = errStr.decode(locale.getdefaultlocale()[1]).encode("utf-8")
        # log(errStr)
        tb = traceback.format_exc(1).split('\n')
        err('loadUrl failed: %s%s' % (utils.hide_guid(errStr), tb[1]))

    finally:
        if conn is not None:
           conn.close()

    return (response, compressedSize, errStr)
