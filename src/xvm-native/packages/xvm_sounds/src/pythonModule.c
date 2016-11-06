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

	if (!PyArg_ParseTuple(args, "s", &filename))
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank] Cannot parse tuple\n");
		return NULL;
	}

	returnCode = AK_SoundEngine_LoadBank(filename, AK_DEFAULT_POOL_ID, &bankID);
	PyMem_Free(&filename);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank] Cannot load sound bank. Audiokinetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
	}

	Py_RETURN_TRUE;
}

static PyObject* UnloadBank(PyObject* self, PyObject* args)
{
	char * filename;
	enum AKRESULT returnCode;

	if (!PyArg_ParseTuple(args, "s", &filename))
	{
		PySys_WriteStderr("[XVM][Sounds/UnloadBank] Cannot parse tuple\n");
		return NULL;
	}

	returnCode = AK_SoundEngine_UnloadBank(filename, NULL, NULL);
	PyMem_Free(&filename);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/UnoadBank] Cannot unload sound bank. Audiokinetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
	}

	Py_RETURN_TRUE;
}

static PyMethodDef XVMNativeSoundsMethods[] = {   
	{ "load_bank", LoadBank, METH_VARARGS, "Load WWise bank."},
	{ "unload_bank", UnloadBank, METH_VARARGS, "Unload WWise bank." },
	{ NULL, NULL, 0, NULL} 
};


PyMODINIT_FUNC initXVMNativeSounds(void)
{
	Py_InitModule("XVMNativeSounds", XVMNativeSoundsMethods);
}