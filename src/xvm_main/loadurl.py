"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# cpython
import datetime
import logging

# OpenWG
import openwg_network

# XFW
from xfw import XFW_NO_TOKEN_MASKING

# XVM Main
from .consts import XVM
from .utils import hide_guid



#
# Public
#

def loadUrl(url, req=None, body=None, content_type='text/plain; charset=utf-8', showLog=True, api=XVM.API_VERSION):
    logger = logging.getLogger('XVM/Main/LoadUrl')

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
        "User-Agent": 'xvm-{0}#{1}'.format(XVM.XVM_VERSION, XVM.XVM_REVISION),
        "Content-Type": content_type
    }

    # response
    response_body = None
    response_errmsg = ''
    response_status = 0

    try:
        (response_status, _, response_body) = openwg_network.request(url, method=req_type, headers=req_headers, body=body, timeout=XVM.TIMEOUT)
    except Exception as ex:
        logger.exception('on request')
        response_errmsg = str(ex)

    # log
    time_elapsed = datetime.datetime.now() - time_start
    time_elapsed_ms = time_elapsed.seconds * 1000 + time_elapsed.microseconds / 1000
    if showLog:
        logger.info('RESP: status=%s, time=%s', response_status, time_elapsed_ms)

    # return
    if response_status in [200, 202, 204, 401]:
        return (response_body, time_elapsed_ms, response_errmsg)
    else:
        return (None, time_elapsed_ms, response_errmsg)



#
# Initialization
#

def init():
    """called on modAdd"""
    pass

def fini():
    """called on modDel"""
    pass
