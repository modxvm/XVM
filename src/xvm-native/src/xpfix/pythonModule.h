/**
 * XVM Native ping module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#pragma once

#define Py_BUILD_CORE 1

#include "pythonwrapper.h"
#include "xvmnativexpfix_export.h"

XVMNATIVEXPFIX_EXPORT PyMODINIT_FUNC initXVMNativeXPFix(void);