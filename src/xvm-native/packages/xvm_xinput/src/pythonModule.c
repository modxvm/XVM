/**
 * XVM Native ping module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include <Windows.h>
#include <Xinput.h>

#include "pythonmodule.h"

static PyObject* set_state(PyObject* self, PyObject* args)
{
	DWORD dwUserIndex;
	XINPUT_VIBRATION vibro;

	//check input value
	if (!PyArg_ParseTuple(args, "iHH", &dwUserIndex, &(vibro.wLeftMotorSpeed), &(vibro.wRightMotorSpeed)))
	{
		return NULL;
	}

	if (dwUserIndex >= XUSER_MAX_COUNT)
	{
		PyErr_Warn(PyExc_RuntimeWarning, "Controller user index is higher than maximum allowed (3)");
	}

	Py_BEGIN_ALLOW_THREADS
	XInputSetState(dwUserIndex, &vibro);
	Py_END_ALLOW_THREADS

	Py_INCREF(Py_None);
	return Py_None;
}

static PyMethodDef XVMNativeXInputMethods[] = {
	{ "set_state", set_state, METH_VARARGS, "Set vibration to controller."},
	{ NULL, NULL, 0, NULL}
};


PyMODINIT_FUNC initXVMNativeXInput(void)
{
	Py_InitModule("XVMNativeXInput", XVMNativeXInputMethods);
}