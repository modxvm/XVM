#pragma once

#include <Python.h>
#include "CrashRpt.h"

PyObject* Py_CrashRpt_Install(PyObject* self, PyObject* args);
PyObject* Py_CrashRpt_IsSupported(PyObject* self, PyObject* args);
PyObject* Py_CrashRpt_SetLanguage(PyObject* self, PyObject* args);

PyObject* Py_CrashRpt_AddFile(PyObject* self, PyObject* args);
PyObject* Py_CrashRpt_AddProp(PyObject* self, PyObject* args);
