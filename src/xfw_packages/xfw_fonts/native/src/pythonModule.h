/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2018-2021 XVM Team.
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

#pragma once

#include <Windows.h>
#include <Python.h>

#include <map>
#include <string>

extern std::map<std::wstring, std::wstring> fontMap;


PyObject* Py_InitHook(PyObject* self, PyObject* args);
PyObject* Py_DeinitHook(PyObject* self, PyObject* args);
PyObject* Py_RegisterFont(PyObject* self, PyObject* args);
PyObject* Py_UnregisterFont(PyObject* self, PyObject* args);

extern PyMethodDef XFWFontManagerMethods[];

PyMODINIT_FUNC initXFW_Fonts(void);

std::string ConvertUTF16ToUTF8(const wchar_t* pszTextUTF16);

