#pragma once

#define Py_BUILD_CORE 1

#include "python.h"
#include <Windows.h>

long GetModuleSize(const char* lpFilename);
BOOL DataCompare(const char* pData, const char* bMask, const char * szMask);
DWORD FindPattern2(DWORD dwAddress, DWORD dwLen, const char* bMask, const char* szMask);
DWORD FindPattern(const char* pattern, const char* mask);
void pythonwrapper_init(void);

//Py_BuildValue
typedef PyAPI_FUNC(PyObject *) wrp_Py_BuildValue_typedef(const char *, ...);
extern wrp_Py_BuildValue_typedef* wrp_Py_BuildValue_func;
#define Py_BuildValue wrp_Py_BuildValue_func

//Py_InitModule4
typedef PyAPI_FUNC(PyObject *) wrp_Py_InitModule4_typedef(const char *, PyMethodDef *, const char *, PyObject *, int);
extern wrp_Py_InitModule4_typedef* wrp_Py_InitModule4_func;
#define Py_InitModule4 wrp_Py_InitModule4_func

//PyArg_ParseTuple
typedef PyAPI_FUNC(int) wrp_PyArg_ParseTuple_typedef(PyObject *, const char *, ...);
extern wrp_PyArg_ParseTuple_typedef* wrp_PyArg_ParseTuple_func;
#define PyArg_ParseTuple wrp_PyArg_ParseTuple_func

//PyEval_RestoreThread
typedef PyAPI_FUNC(void) wrp_PyEval_RestoreThread_typedef(PyThreadState *);
extern wrp_PyEval_RestoreThread_typedef* wrp_PyEval_RestoreThread_func;
#define PyEval_RestoreThread wrp_PyEval_RestoreThread_func

//PyEval_SaveThread
typedef PyAPI_FUNC(PyThreadState *) wrp_PyEval_SaveThread_typedef(void);
extern wrp_PyEval_SaveThread_typedef* wrp_PyEval_SaveThread_func;
#define PyEval_SaveThread wrp_PyEval_SaveThread_func