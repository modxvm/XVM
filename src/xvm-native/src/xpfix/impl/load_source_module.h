#pragma once

#define Py_BUILD_CORE 1

#include "pythonwrapper.h"
#include "xvmnativexpfix_export.h"

XVMNATIVEXPFIX_EXPORT
PyObject *
load_source_module_replacement(char *name, char *pathname, FILE *fp);