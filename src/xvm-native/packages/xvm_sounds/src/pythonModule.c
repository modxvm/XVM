/**
 * XVM Native Sounds module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#include "audiokinetic.h"
#include "pythonmodule.h"

#include <Windows.h>

#define BUF_SIZE 128

static PyObject* LoadBank(PyObject* self, PyObject* args)
{
	char * file_name;
	char * file_content;
	long file_size;
	FILE* file_stream;

	char buf[BUF_SIZE];

	enum AKRESULT returnCode;
	AkBankID bankID;

	if (!AK_SoundEngine_IsInitialized())
	{
		Py_RETURN_FALSE;
	}

	if (!PyArg_ParseTuple(args, "s", &file_name))
	{
		PyErr_SetString(PyExc_RuntimeError, "[LoadBank] Cannot parse tuple\n");
		return NULL;
	}

	file_stream = fopen(file_name, "rb");

	if (file_stream == NULL)
	{		
		snprintf(&buf, BUF_SIZE, "[LoadBank] Cannot open file %s\n", file_name);
		PyErr_SetString(PyExc_RuntimeError, buf);
		return NULL;
	}

	Py_BEGIN_ALLOW_THREADS

	fseek(file_stream, 0, SEEK_END);
	file_size = ftell(file_stream);
	fseek(file_stream, 0, SEEK_SET);

	file_content = malloc(file_size + 1);
	fread(file_content, file_size, 1, file_stream);
	fclose(file_stream);
	file_content[file_size] = 0;

	returnCode = AK_SoundEngine_LoadBank(file_content, file_size, AK_DEFAULT_POOL_ID, &bankID);

	Py_END_ALLOW_THREADS

	free(file_content);

	if (returnCode != AK_Success)
	{
		snprintf(&buf, BUF_SIZE, "[LoadBank] Cannot load sound bank. Audiokinetic error code: %d \n", returnCode);
		PyErr_SetString(PyExc_RuntimeError, buf);
		return NULL;
	}

	return Py_BuildValue("I", bankID);
}

static PyObject* UnloadBank(PyObject* self, PyObject* args)
{
	AkBankID bankID;
	enum AKRESULT returnCode;

	char buf[BUF_SIZE];

	if (!AK_SoundEngine_IsInitialized())
	{
		Py_RETURN_FALSE;
	}

	if (!PyArg_ParseTuple(args, "I", &bankID))
	{
		PyErr_SetString(PyExc_RuntimeError, "[UnloadBank] Cannot parse tuple\n");
		return NULL;
	}

	Py_BEGIN_ALLOW_THREADS

	returnCode = AK_SoundEngine_UnloadBank(bankID, NULL, NULL);

	Py_END_ALLOW_THREADS

	if (returnCode != AK_Success)
	{
		snprintf(&buf, BUF_SIZE, "[UnloadBank] Cannot unload sound bank. Audiokinetic error code: %d \n", returnCode);
		PyErr_SetString(PyExc_RuntimeError, buf);
		return NULL;
	}

	Py_RETURN_TRUE;
}

static PyMethodDef XVMNativeSoundsMethods[] = {   
	{ "bank_load"    , LoadBank    , METH_VARARGS, "Load WWise bank by filepath relative to WorldOfTanks.exe" },
	{ "bank_unload"  , UnloadBank  , METH_VARARGS, "Unload WWise bank by bankID." },
	{ NULL, NULL, 0, NULL} 
};


PyMODINIT_FUNC initXVMNativeSounds(void)
{
	Py_InitModule("XVMNativeSounds", XVMNativeSoundsMethods);
}