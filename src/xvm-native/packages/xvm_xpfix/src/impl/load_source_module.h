#pragma once

#include "Python.h"
#include "PythonInternal.h"

__declspec(dllexport)
PyObject *
load_source_module_replacement(char *name, char *pathname, FILE *fp);
