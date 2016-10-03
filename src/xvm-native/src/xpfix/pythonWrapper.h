/**
 * XVM Native XPfix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 * @author Fecell
 */

#pragma once

#define Py_BUILD_CORE 1
#include "Python.h"

void pythonWrapperInit(void);

//9. PyObject_IsTrue
typedef PyAPI_FUNC(int) wrp_PyObject_IsTrue_typedef(PyObject *);
extern wrp_PyObject_IsTrue_typedef* wrp_PyObject_IsTrue_func;
#define PyObject_IsTrue wrp_PyObject_IsTrue_func

//36. PyErr_Format
typedef PyAPI_FUNC(PyObject *) wrp_PyErr_Format_typedef(PyObject *, const char *, ...);
extern wrp_PyErr_Format_typedef* wrp_PyErr_Format_func;
#define PyErr_Format wrp_PyErr_Format_func

//37. PyErr_NoMemory
typedef PyAPI_FUNC(PyObject *) wrp_PyErr_NoMemory_typedef(void);
extern wrp_PyErr_NoMemory_typedef* wrp_PyErr_NoMemory_func;
#define PyErr_NoMemory wrp_PyErr_NoMemory_func

//38. PyErr_NormalizeException
typedef PyAPI_FUNC(void) wrp_PyErr_NormalizeException_typedef(PyObject**, PyObject**, PyObject**);
extern wrp_PyErr_NormalizeException_typedef* wrp_PyErr_NormalizeException_func;
#define PyErr_NormalizeException wrp_PyErr_NormalizeException_func

//39. PyErr_Occurred
typedef PyAPI_FUNC(PyObject *) wrp_PyErr_Occurred_typedef(void);
extern wrp_PyErr_Occurred_typedef* wrp_PyErr_Occurred_func;
#define PyErr_Occurred wrp_PyErr_Occurred_func

//52. Py_InitModule4
typedef PyAPI_FUNC(PyObject *) wrp_Py_InitModule4_typedef(const char *, PyMethodDef *, const char *, PyObject *, int);
extern wrp_Py_InitModule4_typedef* wrp_Py_InitModule4_func;
#define Py_InitModule4 wrp_Py_InitModule4_func

//60. PySys_GetObject
typedef PyAPI_FUNC(PyObject *) wrp_PySys_GetObject_typedef(char *);
extern wrp_PySys_GetObject_typedef* wrp_PySys_GetObject_func;
#define PySys_GetObject wrp_PySys_GetObject_func

//61. PySys_WriteStderr
typedef PyAPI_FUNC(void) wrp_PySys_WriteStderr_typedef(const char *, ...);
extern wrp_PySys_WriteStderr_typedef* wrp_PySys_WriteStderr_func;
#define PySys_WriteStderr wrp_PySys_WriteStderr_func

//62. PyImport_Cleanup
typedef PyAPI_FUNC(void) wrp_PyImport_Cleanup_typedef(void);
extern wrp_PyImport_Cleanup_typedef* wrp_PyImport_Cleanup_func;
#define PyImport_Cleanup wrp_PyImport_Cleanup_func

//63. PyImport_ExecCodeModuleEx
typedef PyAPI_FUNC(PyObject *) wrp_PyImport_ExecCodeModuleEx_typedef(char *, PyObject *, char *);
extern wrp_PyImport_ExecCodeModuleEx_typedef* wrp_PyImport_ExecCodeModuleEx_func;
#define PyImport_ExecCodeModuleEx wrp_PyImport_ExecCodeModuleEx_func

//65. check_compiled_module
typedef FILE * wrp_check_compiled_module_typedef(char *, time_t, char *);
extern wrp_check_compiled_module_typedef* wrp_check_compiled_module_func;
#define check_compiled_module wrp_check_compiled_module_func

//66. find_init_module
typedef int wrp_find_init_module_typedef(char *);
extern wrp_find_init_module_typedef* wrp_find_init_module_func;
#define find_init_module wrp_find_init_module_func

//67. load_source_module
typedef PyObject * wrp_load_source_module_typedef(char *, char *, FILE *);
extern wrp_load_source_module_typedef* wrp_load_source_module_func;
#define load_source_module wrp_load_source_module_func

//68. make_compiled_pathname
typedef char * wrp_make_compiled_pathname_typedef(char *, char *, size_t);
extern wrp_make_compiled_pathname_typedef* wrp_make_compiled_pathname_func;
#define make_compiled_pathname wrp_make_compiled_pathname_func

//69. parse_source_module
typedef PyCodeObject * wrp_parse_source_module_typedef(const char *, FILE *);
extern wrp_parse_source_module_typedef* wrp_parse_source_module_func;
#define parse_source_module wrp_parse_source_module_func

//70. read_compiled_module
typedef PyCodeObject * wrp_read_compiled_module_typedef(char *, FILE *);
extern wrp_read_compiled_module_typedef* wrp_read_compiled_module_func;
#define read_compiled_module wrp_read_compiled_module_func

//71. update_compiled_module
typedef int wrp_update_compiled_module_typedef(PyCodeObject *, char *);
extern wrp_update_compiled_module_typedef* wrp_update_compiled_module_func;
#define update_compiled_module wrp_update_compiled_module_func

//72. win32_mtime
typedef time_t wrp_win32_mtime_typedef(FILE *, char *);
extern wrp_win32_mtime_typedef* wrp_win32_mtime_func;
#define win32_mtime wrp_win32_mtime_func

//73. write_compiled_module
typedef void wrp_write_compiled_module_typedef(PyCodeObject *, char *, struct stat *, time_t);
extern wrp_write_compiled_module_typedef* wrp_write_compiled_module_func;
#define write_compiled_module wrp_write_compiled_module_func

//5. Py_VerboseFlag
extern int* wrp_Py_VerboseFlag_struct;
#define Py_VerboseFlag (*wrp_Py_VerboseFlag_struct)

//10. PyExc_RuntimeError
extern PyObject ** wrp_PyExc_RuntimeError_struct;
#define PyExc_RuntimeError (*wrp_PyExc_RuntimeError_struct)