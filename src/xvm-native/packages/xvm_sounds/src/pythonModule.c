/**
 * XVM Native Sounds module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#include "audiokinetic.h"
#include "pythonmodule.h"

#include <Windows.h>

static PyObject* LoadBank(PyObject* self, PyObject* args)
{
	char * filename;
	enum AKRESULT returnCode;
	AkBankID bankID;

	PySys_WriteStderr("[XVM][Sounds/LoadBank]\n");

	if (!PyArg_ParseTuple(args, "s", &filename))
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank] Cannot parse tuple\n");
		Py_RETURN_FALSE;
	}

	returnCode = AK_SoundEngine_LoadBank(filename, AK_DEFAULT_POOL_ID, &bankID);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank] Cannot load sound bank. Audiokenetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
	}

	Py_RETURN_TRUE;
}

static PyObject* UnloadBank(PyObject* self, PyObject* args)
{
	Py_RETURN_NONE;
}

static PyMethodDef XVMNativeSoundsMethods[] = {   
    { "load_bank", LoadBank, METH_VARARGS, "Load WWise bank."},
	{ "unload_bank", UnloadBank, METH_VARARGS, "Unload WWise bank." },
    { NULL, NULL, 0, NULL} 
};


PyMODINIT_FUNC initXVMNativeSounds(void)
{
	MessageBoxA(NULL, "Time to attach", "Time to attach", MB_OK);
    Py_InitModule("XVMNativeSounds", XVMNativeSoundsMethods);
}