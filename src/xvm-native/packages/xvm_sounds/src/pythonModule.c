/**
 * XVM Native Sounds module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#include "audiokinetic.h"
#include "pythonmodule.h"

#include <Windows.h>

static PyObject* LoadBank(PyObject* self, PyObject* args)
{
	char * file_name;
	char * file_content;
	long file_size;
	FILE* file_stream;

	enum AKRESULT returnCode;
	AkBankID bankID;

	if (!PyArg_ParseTuple(args, "s", &file_name))
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank] Cannot parse tuple\n");
		return NULL;
	}

	file_stream = fopen(file_name, "rb");

	if (file_stream == NULL)
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank] Cannot open file\n");
		return NULL;
	}

	fseek(file_stream, 0, SEEK_END);
	file_size = ftell(file_stream);
	fseek(file_stream, 0, SEEK_SET);

	file_content = malloc(file_size + 1);
	fread(file_content, file_size, 1, file_stream);
	fclose(file_stream);
	file_content[file_size] = 0;

	returnCode = AK_SoundEngine_LoadBank(file_content, file_size, AK_DEFAULT_POOL_ID, &bankID);

	PyMem_Free(&file_name);
	free(file_content);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank/ByMemory] Cannot load sound bank. Audiokinetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
	}

	return Py_BuildValue("I", bankID);
}

static PyObject* UnloadBank(PyObject* self, PyObject* args)
{
	AkBankID bankID;
	enum AKRESULT returnCode;

	if (!PyArg_ParseTuple(args, "I", &bankID))
	{
		PySys_WriteStderr("[XVM][Sounds/UnloadBank] Cannot parse tuple\n");
		return NULL;
	}

	returnCode = AK_SoundEngine_UnloadBank(bankID, NULL, NULL);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/UnloadBank] Cannot unload sound bank. Audiokinetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
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