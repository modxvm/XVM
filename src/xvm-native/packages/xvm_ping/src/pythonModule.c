/**
 * XVM Native ping module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#include "pythonmodule.h"
#include "ping.h"

static PyObject* PingFunction(PyObject* self, PyObject* args)
{
    char* address;
    int pingValue;

    //check input value
    if (!PyArg_ParseTuple(args, "s", &address))
    {
        return NULL;
    }

    Py_BEGIN_ALLOW_THREADS
    pingValue = ping(address);
    Py_END_ALLOW_THREADS

    return Py_BuildValue("i", pingValue);
}

static PyMethodDef XVMNativePingMethods[] = {   
    { "ping", PingFunction, METH_VARARGS, "Ping IP address."},     
    { NULL, NULL, 0, NULL} 
};


PyMODINIT_FUNC initXVMNativePing(void)
{
    Py_InitModule("XVMNativePing", XVMNativePingMethods);
}