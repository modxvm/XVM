/**
 * XVM Native WOTFix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#include "Python.h"
#include "PythonWrapper.h"
#include <Windows.h>

void ReplacePythonFunction(const char* original_name, const char* forward_name, HMODULE forward_dll)
{
    DWORD OriginFunctionAddress;
    DWORD ReplaceFunctionAddress;

    OriginFunctionAddress = WRAPPER_GetFunctionRealAddress(original_name);
    ReplaceFunctionAddress = (DWORD)GetProcAddress(forward_dll, forward_name);
    if (OriginFunctionAddress > 0 && ReplaceFunctionAddress > 0)
    {
        WRAPPER_ReplaceFunction(OriginFunctionAddress, ReplaceFunctionAddress);
    }
}

PyObject* Py_Fix_Common(PyObject* self, PyObject* args)
{
    ReplacePythonFunction("_PyImport_GetDynLoadFunc", "_PyImport_GetDynLoadFunc_replacement", GetModuleHandle(TEXT("XVMNativeWOTFix.pyd")));
    Py_RETURN_NONE;
}

PyObject* Py_Fix_XP(PyObject* self, PyObject* args)
{
    ReplacePythonFunction("load_source_module", "load_source_module_replacement", GetModuleHandle(TEXT("XVMNativeWOTFix.pyd")));
    ReplacePythonFunction("find_init_module"  , "find_init_module"              , GetModuleHandle(TEXT("XVMNativeWOTFix.pyd")));
    Py_RETURN_NONE;
}

PyMethodDef XVMNativeWOTFixMethods[] = {
    { "fix_common"   , Py_Fix_Common , METH_VARARGS, "Apply common fixes." },
    { "fix_xp"       , Py_Fix_XP     , METH_VARARGS, "Apply fixes for Windows XP." },
    { NULL           , NULL          ,            0, NULL} 
};

PyMODINIT_FUNC initXVMNativeWOTFix(void)
{
    Py_InitModule("XVMNativeWOTFix", XVMNativeWOTFixMethods);
}