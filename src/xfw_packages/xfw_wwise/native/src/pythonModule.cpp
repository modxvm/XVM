/**
 * This file is part of the XVM Framework project.
 * Copyright (c) 2016-2019 XVM Team.
 *
 * XVM Framework is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, version 3.
 *
 * XVM Framework is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <string>

#include <Windows.h>
#include <Python.h>

#include <AK/Comm/AkCommunication.h>
#include <AK/SoundEngine/Common/AkSoundEngine.h>

#include "path.h"

#define BUF_SIZE 256
char error_string[BUF_SIZE]{};

using namespace std;

bool Bank_Load_FromMemory(const wchar_t* filename, AKRESULT& result, AkBankID& bankID)
{
	FILE* file_stream = nullptr;
	long  file_size = 0;
	void* file_content = nullptr;

	file_stream = _wfopen(filename, L"rb");
	if (file_stream == nullptr)	{
		snprintf(error_string, BUF_SIZE, "[XFW_WWISE_Bank_Load_Memory] Cannot open file\n");
		return false;
	}

    fseek(file_stream, 0, SEEK_END);
    file_size = ftell(file_stream);
    fseek(file_stream, 0, SEEK_SET);

	file_content = malloc(file_size + 1);
	if (file_content == nullptr) {
		snprintf(error_string, BUF_SIZE, "[XFW_WWISE/Bank_Load_Memory] Cannot allocate memory\n");
		return false;
	}

	fread(file_content, file_size, 1, file_stream);
	fclose(file_stream);

	result = AK::SoundEngine::LoadBank(file_content, file_size, AK_DEFAULT_POOL_ID, bankID);

	free(file_content);

	return true;
}


bool Bank_Load_FromPath(const wchar_t* filename, AKRESULT& result, AkBankID& bankID)
{
	result = AK::SoundEngine::LoadBank(filename, AK_DEFAULT_POOL_ID, bankID);
	return true;
}


bool Bank_Load_UpdateFile(const wchar_t* path_bank, const wchar_t* dir_audioww, const wchar_t* name_bank)
{
	bool update = true;

	wstring path_old = Path::GetAbsolute(path_bank);
	wstring path_audioww = Path::GetAbsolute(dir_audioww);
	wstring path_new = path_audioww;

	path_new += L"\\";
	path_new += name_bank;

	if(!Path::FileExists(path_old))
	{
		snprintf(error_string, BUF_SIZE, "[LoadBank] File does not exists.");
		return false;
	}

	if (Path::DirectoryExists(path_audioww))
	{
		if (Path::FileExists(path_new))
		{
			if (Path::AreEqual(path_old, path_new))
			{
				update = false;
			}
			else
			{
				if (!Path::DeleteFile(path_new))
				{
					snprintf(error_string, BUF_SIZE, "[LoadBank] Cannot delete old bank.");
					return false;
				}
			}
		}
	}
	else
	{
		if (!Path::CreateDirectory(path_audioww))
		{
			snprintf(error_string, BUF_SIZE, "[LoadBank] Cannot create audioww directory.");
			return false;
		}
	}

	if (update)
	{
		Path::CreateHardlink(path_old, path_new);

		if (!Path::FileExists(path_new))
		{
			if (!Path::CopyFile(path_old, path_new))
			{
				snprintf(error_string, BUF_SIZE, "[LoadBank] Cannot link or copy bank file.");
				return false;
			}
		}
	}

	return true;
}


static PyObject* Py_Bank_Load(PyObject* self, PyObject* args)
{
	bool result = false;

	wchar_t* path_bankpath = nullptr;
	wchar_t* path_audioww = nullptr;

	enum AKRESULT returnCode = AK_NotImplemented;
	AkBankID bankID = 0;

	memset(&error_string[0], 0, sizeof(error_string));

    if (!PyArg_ParseTuple(args, "uu", &path_bankpath, &path_audioww)) {
        PyErr_SetString(PyExc_RuntimeError, "[LoadBank] Cannot parse tuple. Expected (uu)\n");
        return nullptr;
    }

    if (!AK::SoundEngine::IsInitialized()) {
        Py_RETURN_FALSE;
    }

	wstring str_bankname(Path::GetFilename(path_bankpath));

	Py_BEGIN_ALLOW_THREADS;
	result = Bank_Load_UpdateFile(path_bankpath, path_audioww, str_bankname.c_str());
	Py_END_ALLOW_THREADS;

	if (!result) {
		PyErr_SetString(PyExc_RuntimeError, error_string);
		return nullptr;
	}

	Py_BEGIN_ALLOW_THREADS;
	result = Bank_Load_FromPath(str_bankname.c_str(), returnCode, bankID);

	if (returnCode == AK_FileNotFound) {
		result = Bank_Load_FromMemory((Path::GetAbsolute(path_audioww) + L"\\" + str_bankname).c_str(), returnCode, bankID);
	}
	Py_END_ALLOW_THREADS;

	if(!result) {
		PyErr_SetString(PyExc_RuntimeError, error_string);
		return nullptr;
	}

	if (returnCode != AK_Success) {
		snprintf(error_string, BUF_SIZE, "[LoadBank] Cannot load sound bank. Audiokinetic error code: %d \n", returnCode);
		PyErr_SetString(PyExc_RuntimeError, error_string);
		return nullptr;
	}

	return Py_BuildValue("I", bankID);
}


static PyObject* Py_Bank_Unload(PyObject* self, PyObject* args)
{
	AkBankID bankID = 0;
	AKRESULT returnCode = AK_NotImplemented;

	memset(&error_string[0], 0, sizeof(error_string));

	if (!AK::SoundEngine::IsInitialized()) {
		Py_RETURN_FALSE;
	}

	if (!PyArg_ParseTuple(args, "I", &bankID)) {
		PyErr_SetString(PyExc_RuntimeError, "[XFW_WWISE/Bank_Unload] Cannot parse tuple\n");
		return nullptr;
	}

	Py_BEGIN_ALLOW_THREADS;
	returnCode = AK::SoundEngine::UnloadBank(bankID, nullptr, nullptr);
	Py_END_ALLOW_THREADS;

	if (returnCode != AK_Success) {
		snprintf(error_string, BUF_SIZE, "[XFW_WWISE/Bank_Unload] Cannot unload sound bank. Audiokinetic error code: %d \n", returnCode);
		PyErr_SetString(PyExc_RuntimeError, error_string);
		return nullptr;
	}

	Py_RETURN_TRUE;
}

static PyObject* Py_Communication_Init(PyObject* self, PyObject* args)
{
	AkCommSettings commSettings{};
	AK::Comm::GetDefaultInitSettings(commSettings);
	if (AK::Comm::Init(commSettings) != AK_Success) {
		PyErr_SetString(PyExc_RuntimeError, "[XFW_WWISE/Communication_Init] Could not initialize communication\n");
		return nullptr;
	}

	Py_RETURN_TRUE;
}

static PyMethodDef XFW_WWISEMethods[] = {
	{ "bank_load"   , Py_Bank_Load          , METH_VARARGS, "Load WWise bank by filepath relative to WorldOfTanks.exe" },
	{ "bank_unload" , Py_Bank_Unload        , METH_VARARGS, "Unload WWise bank by bankID." },
	{ "comm_init"   , Py_Communication_Init , METH_VARARGS, "Init communication." },
	{ NULL, NULL, 0, NULL}
};

PyMODINIT_FUNC initXFW_WWISE(void)
{
	Py_InitModule("XFW_WWISE", XFW_WWISEMethods);
}
