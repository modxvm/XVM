/**
 * XVM Native xpfix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 * @author Fecell
 */

#pragma once

#define Py_BUILD_CORE 1

#include "Python.h"

void pythonWrapperInit(void);

//Py_InitModule4
typedef PyAPI_FUNC(PyObject *) wrp_Py_InitModule4_typedef(const char *, PyMethodDef *, const char *, PyObject *, int);
extern wrp_Py_InitModule4_typedef* wrp_Py_InitModule4_func;
#define Py_InitModule4 wrp_Py_InitModule4_func