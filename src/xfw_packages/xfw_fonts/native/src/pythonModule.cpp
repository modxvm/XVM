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

#include <algorithm>

#include "pythonModule.h"

#include "winapi_CreateFont.h"
#include "winapi_EnumFontsFamiliesEx.h"
#include "ttfInfo.h"

#include <xfw_hooks.h>
#include <Windows.h>

std::map<std::wstring, std::wstring> fontMap;

std::string ConvertUTF16ToUTF8(const wchar_t* pszTextUTF16) {
    if (pszTextUTF16 == NULL)
        return "";

    const int utf16len = wcslen(pszTextUTF16);
    int utf8_len = WideCharToMultiByte(CP_UTF8, 0, pszTextUTF16, utf16len, NULL, 0, NULL, NULL);

    std::string str;
    str.resize(utf8_len, '\0');

    WideCharToMultiByte(CP_UTF8, 0, pszTextUTF16, utf16len, &str[0], utf8_len, 0, 0);

    return str;
}

PyObject* Py_InitHooks(PyObject* self, PyObject* args)
{
    if (!XFW::Hooks::HookCreate(&CreateFontW, &CreateFontW_Detour, reinterpret_cast<void**>(&CreateFontW_trampoline)))
        return NULL;

    if (!XFW::Hooks::HookEnable(&CreateFontW))
        return NULL;

    if (!XFW::Hooks::HookCreate(&EnumFontFamiliesExW, &EnumFontFamiliesExW_Detour, reinterpret_cast<void**>(&EnumFontFamiliesExW_trampoline)))
        return NULL;

    if (!XFW::Hooks::HookEnable(&EnumFontFamiliesExW))
        return NULL;

    Py_RETURN_TRUE;
}


PyObject* Py_DeinitHooks(PyObject* self, PyObject* args)
{
    XFW::Hooks::HookDisable(&CreateFontW);
    XFW::Hooks::HookDisable(&EnumFontFamiliesExW);

    Py_RETURN_TRUE;
}

PyObject* Py_RegisterFont(PyObject* self, PyObject* args)
{
    wchar_t* font_path = NULL;
    BOOL isPrivate = FALSE;
    BOOL not_enumerable = FALSE;

    if (!PyArg_ParseTuple(args, "uii", &font_path, &isPrivate, &not_enumerable))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW_Fonts/RegisterFont] Cannot parse tuple\n");
        return NULL;
    }

    DWORD flags = 0;

    if (isPrivate)
        flags |= FR_PRIVATE;

    if (not_enumerable)
        flags |= FR_NOT_ENUM;

    int fontsAdded = AddFontResourceExW(font_path, flags, 0);
    if (fontsAdded > 0)
    {
        return Py_BuildValue("s", GetFontFamilyFromFile(std::wstring(font_path)).c_str());
    }

    Py_RETURN_FALSE;

}

PyObject* Py_UnregisterFont(PyObject* self, PyObject* args)
{
    wchar_t* font_path = NULL;
    BOOL isPrivate = FALSE;
    BOOL not_enumerable = FALSE;

    if (!PyArg_ParseTuple(args, "uii", &font_path, &isPrivate, &not_enumerable))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW_Fonts/UnregisterFont] Cannot parse tuple\n");
        return NULL;
    }

    DWORD flags = 0;

    if (isPrivate)
        flags |= FR_PRIVATE;

    if (not_enumerable)
        flags |= FR_NOT_ENUM;

    int fontsAdded = RemoveFontResourceExW(font_path, flags, 0);
    if (fontsAdded > 0)
        Py_RETURN_TRUE;

    Py_RETURN_FALSE;
}

PyObject* Py_AddAlias(PyObject* self, PyObject* args)
{
    wchar_t* alias = nullptr;
    wchar_t* realfont = nullptr;

    if (!PyArg_ParseTuple(args, "uu", &alias, &realfont))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW_Fonts/AddAlias] Cannot parse tuple\n");
        return NULL;
    }

    std::wstring fontName(alias);
    std::transform(fontName.begin(), fontName.end(), fontName.begin(), towlower);
    fontMap[fontName] = realfont;

    Py_RETURN_TRUE;
}


PyObject* Py_RemoveAlias(PyObject* self, PyObject* args)
{
    wchar_t* alias = nullptr;

    if (!PyArg_ParseTuple(args, "u", &alias))
    {
        PyErr_SetString(PyExc_RuntimeError, "[XFW_Fonts/RemoveAlias] Cannot parse tuple\n");
        return NULL;
    }

    std::wstring fontName(alias);
    std::transform(fontName.begin(), fontName.end(), fontName.begin(), towlower);
    if (fontMap.erase(fontName) > 0)
        Py_RETURN_TRUE;

    Py_RETURN_FALSE;
}


PyMethodDef XFWFontManagerMethods[] = {
    { "init_hooks", Py_InitHooks, METH_VARARGS, "Init windows functions hooks for aliases."},
    { "deinit_hooks", Py_DeinitHooks, METH_VARARGS, "Init windows functions hooks for aliases."},

    { "register_font", Py_RegisterFont, METH_VARARGS, "Register font in system or process."},
    { "unregister_font", Py_UnregisterFont, METH_VARARGS, "Unregister font in system or process."},

    { "add_alias", Py_AddAlias, METH_VARARGS, "Register font name alias." },
    { "remove_alias", Py_RemoveAlias, METH_VARARGS, "Unregister font name alias." },

    { NULL, NULL, 0, NULL}
};

PyMODINIT_FUNC initXFW_Fonts(void)
{
    Py_InitModule("XFW_Fonts", XFWFontManagerMethods);
}
