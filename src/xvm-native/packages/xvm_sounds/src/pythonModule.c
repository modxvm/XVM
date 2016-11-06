/**
 * XVM Native Sounds module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */
 
#include "audiokinetic.h"
#include "pythonmodule.h"

#include <Windows.h>

static PyObject* LoadBank_ByFilename(PyObject* self, PyObject* args)
{
	char * filename;
	enum AKRESULT returnCode;
	AkBankID bankID;

	if (!PyArg_ParseTuple(args, "s", &filename))
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank/ByFilename] Cannot parse tuple\n");
		return NULL;
	}

	returnCode = AK_SoundEngine_LoadBank_ByFilename(filename, AK_DEFAULT_POOL_ID, &bankID);
	PyMem_Free(&filename);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank/ByFilename] Cannot load sound bank. Audiokinetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
	}

	return Py_BuildValue("I", bankID);
}

static PyObject* LoadBank_ByMemory(PyObject* self, PyObject* args)
{
	char * file_name;
	char * file_content;
	long file_size;
	FILE* file_stream;

	enum AKRESULT returnCode;
	AkBankID bankID;

	if (!PyArg_ParseTuple(args, "s", &file_name))
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank/ByMemory] Cannot parse tuple\n");
		return NULL;
	}

	file_stream = fopen(file_name, "rb");

	if (file_stream == NULL)
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank/ByMemory] Cannot open file\n");
		return NULL;
	}

	fseek(file_stream, 0, SEEK_END);
	file_size = ftell(file_stream);
	fseek(file_stream, 0, SEEK_SET);

	file_content = malloc(file_size + 1);
	fread(file_content, file_size, 1, file_stream);
	fclose(file_stream);
	file_content[file_size] = 0;

	returnCode = AK_SoundEngine_LoadBank_ByMemory_OutOfPlace(file_content, file_size, AK_DEFAULT_POOL_ID, &bankID);

	PyMem_Free(&file_name);
	free(file_content);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/LoadBank/ByMemory] Cannot load sound bank. Audiokinetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
	}

	return Py_BuildValue("I", bankID);
}

static PyObject* UnloadBank_ByFilename(PyObject* self, PyObject* args)
{
	char * filename;
	enum AKRESULT returnCode;

	if (!PyArg_ParseTuple(args, "s", &filename))
	{
		PySys_WriteStderr("[XVM][Sounds/UnloadBank] Cannot parse tuple\n");
		return NULL;
	}

	returnCode = AK_SoundEngine_UnloadBank_ByFilename(filename, NULL, NULL);
	PyMem_Free(&filename);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/UnloadBank/ByFilename/ByFilename] Cannot unload sound bank. Audiokinetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
	}

	Py_RETURN_TRUE;
}

static PyObject* UnloadBank_ByBankID(PyObject* self, PyObject* args)
{
	AkBankID bankID;
	enum AKRESULT returnCode;

	if (!PyArg_ParseTuple(args, "I", &bankID))
	{
		PySys_WriteStderr("[XVM][Sounds/UnloadBank/ByID] Cannot parse tuple\n");
		return NULL;
	}

	returnCode = AK_SoundEngine_UnloadBank_ByBankID(bankID, NULL, NULL);

	if (returnCode != AK_Success)
	{
		PySys_WriteStderr("[XVM][Sounds/UnloadBank/ByID] Cannot unload sound bank. Audiokinetic error code: %d \n", returnCode);
		Py_RETURN_FALSE;
	}

	Py_RETURN_TRUE;
}

static PyMethodDef XVMNativeSoundsMethods[] = {   
	{ "bank_load_by_filename"  , LoadBank_ByFilename  , METH_VARARGS, "Load WWise bank using bank filename."},
	{ "bank_load_by_memory"    , LoadBank_ByMemory    , METH_VARARGS, "Load WWise bank with loading bank in memory." },
	{ "bank_unload_by_filename", UnloadBank_ByFilename, METH_VARARGS, "Unload WWise bank using bank filename." },
	{ "bank_unload_by_bankid"  , UnloadBank_ByBankID  , METH_VARARGS, "Unload WWise bank using bank ID." },
	{ NULL, NULL, 0, NULL} 
};


PyMODINIT_FUNC initXVMNativeSounds(void)
{
	Py_InitModule("XVMNativeSounds", XVMNativeSoundsMethods);
}