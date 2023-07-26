"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2022 XVM Contributors
"""

#
# Imports
#

# cpython
import datetime
import logging
import urllib

# certifi
import certifi

# urllib3
import urllib3

# XFW
from xfw import XFW_NO_TOKEN_MASKING

# XVM Main
from .consts import XVM
from .utils import hide_guid



#
# Globals
#

_urllib_pool = None

_USER_AGENT = 'xvm-{0}#{1}'.format(XVM.XVM_VERSION, XVM.XVM_REVISION)



#
# Public
#

def loadUrl(url, req=None, body=None, content_type='text/plain; charset=utf-8', showLog=True, api=XVM.API_VERSION):
    logger = logging.getLogger('XVM/Main/LoadUrl')

    if not _urllib_pool:
        logger.error('URL loader is not initialized')
        return (None, None, None)

    # prepare URL
    url = url.replace("{API}", api)
    if req is not None:
        url = url.replace("{REQ}", req)

    # log
    if showLog:
        logger.info('REQ: %s', url if XFW_NO_TOKEN_MASKING else hide_guid(url))
    time_start = datetime.datetime.now()

    # prepare request
    req_type = "POST" if body else "GET"
    req_headers = {
        "User-Agent": _USER_AGENT,
        "Accept-Encoding": "gzip",
        "Content-Type": content_type
    }
    
    # response
    response = None
    response_errmsg = ''
    response_status = 0

    try:
        response = _urllib_pool.request(req_type, url, headers = req_headers, body = body, retries = XVM.RETRIES, timeout = XVM.TIMEOUT)
    except urllib3.exceptions.TimeoutError:
        logger.warning('TimeoutError')
        response_errmsg = 'timeout'
    except urllib3.exceptions.MaxRetryError:
        logger.warning('MaxRetryError')
        response_errmsg = 'maximum retries count'
    except Exception as ex:
        logger.exception('on request')
        response_errmsg = str(ex)

    if response is not None:
        response_status = response.status

    # log
    time_elapsed = datetime.datetime.now() - time_start
    time_elapsed_ms = time_elapsed.seconds * 1000 + time_elapsed.microseconds / 1000
    if showLog:
        logger.info('RESP: status=%s, time=%s', response_status, time_elapsed_ms)

    # return
    if response is not None and response_status in [200, 202, 204, 401]:
        return (response.data, time_elapsed_ms, response_errmsg)
    else:
        return (None, time_elapsed_ms, response_errmsg)



#
# Initialization
#

def init():
    global _urllib_pool

    proxy = None
    #TODO: reenable after WoT py2->py3 transition
    #if not proxy:
    #    proxy = urllib.getproxies().get("https")
    if not proxy:
        proxy = urllib.getproxies().get("http")
    
    opts =  {
        "num_pools": 2,
        "cert_reqs": "CERT_REQUIRED",
        "ca_certs": certifi.where(),
    }

    if proxy:
        _urllib_pool = urllib3.ProxyManager(proxy, **opts)
    else:
        _urllib_pool = urllib3.PoolManager(**opts)

    logging.getLogger("urllib3").setLevel(logging.ERROR)

def fini():
    global _urllib_pool
    _urllib_pool = None
