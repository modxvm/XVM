/**
 * XVM Native xpfix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#include "pythonmodule.h"

static PyMethodDef XVMNativeXPFixMethods[] = {
    { NULL, NULL, 0, NULL} 
};


PyMODINIT_FUNC initXVMNativeXPFix(void)
{
    Py_InitModule("XVMNativeXPFix", XVMNativeXPFixMethods);
}