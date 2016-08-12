#pragma once

#define Py_BUILD_CORE 1

#include "pythonwrapper.h"
#include "xvmnativeping_export.h"

XVMNATIVEPING_EXPORT PyMODINIT_FUNC initXVMNativePing(void);