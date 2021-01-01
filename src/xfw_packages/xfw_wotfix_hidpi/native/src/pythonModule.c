/**
 * This file is part of the XVM Framework project.
 * Copyright (c) 2016-2021 XVM Team.
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

#include "Python.h"

#include <Windows.h>
#include <Shlwapi.h>

BOOL IsWindowsVistaOrGreater()
{
    OSVERSIONINFOEX osvi;
    DWORDLONG dwlConditionMask = 0;
    int op = VER_GREATER_EQUAL;

    // Initialize the OSVERSIONINFOEX structure.
    ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
    osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
    osvi.dwMajorVersion = 6;
    osvi.dwMinorVersion = 0;
    osvi.wServicePackMajor = 0;
    osvi.wServicePackMinor = 0;

    // Initialize the condition mask.
    VER_SET_CONDITION(dwlConditionMask, VER_MAJORVERSION, op);
    VER_SET_CONDITION(dwlConditionMask, VER_MINORVERSION, op);
    VER_SET_CONDITION(dwlConditionMask, VER_SERVICEPACKMAJOR, op);
    VER_SET_CONDITION(dwlConditionMask, VER_SERVICEPACKMINOR, op);

    // Perform the test.

    return VerifyVersionInfo(
        &osvi,
        VER_MAJORVERSION | VER_MINORVERSION | VER_SERVICEPACKMAJOR | VER_SERVICEPACKMINOR,
        dwlConditionMask);
}

typedef BOOL(*GetProcAddress_typedef)(void);
PyObject* Py_Fix_DPI(PyObject* self, PyObject* args)
{
    if (!IsWindowsVistaOrGreater())
        Py_RETURN_FALSE;

    //Do not use SetProccessDPIAware directly because of Windows XP
    GetProcAddress_typedef SetProcessDPIAware = (GetProcAddress_typedef)GetProcAddress(GetModuleHandleA("user32.dll"), "SetProcessDPIAware");

    //write to registry
    HKEY key = NULL;
    if (RegCreateKeyExW(HKEY_CURRENT_USER, L"Software\\Microsoft\\Windows NT\\CurrentVersion\\AppCompatFlags\\Layers",
        0, NULL, REG_OPTION_NON_VOLATILE, KEY_ALL_ACCESS, NULL, &key, NULL) == ERROR_SUCCESS)
    {
        wchar_t* wotlauncher = _wpgmptr;
        PathRemoveFileSpecW(wotlauncher);
        wcscat(wotlauncher, L"\\WoTLauncher.exe");
        RegSetValueExW(key, wotlauncher, 0, REG_SZ, (LPBYTE)L"~ HIGHDPIAWARE", (lstrlenW(L"~ HIGHDPIAWARE") + 1) * sizeof(wchar_t));

        wchar_t* wotexe = _wpgmptr;
        PathRemoveFileSpecW(wotexe);
        wcscat(wotexe, L"\\WorldOfTanks.exe");
        RegSetValueExW(key, wotexe, 0, REG_SZ, (LPBYTE)L"~ HIGHDPIAWARE", (lstrlenW(L"~ HIGHDPIAWARE") + 1) * sizeof(wchar_t));

        RegCloseKey(key);
    }

    if (SetProcessDPIAware())
        Py_RETURN_TRUE;
    else
        Py_RETURN_FALSE;
}

PyMethodDef XFWHiDPIMethods[] = {
    { "fix_dpi"      , Py_Fix_DPI    , METH_VARARGS, "Set DPI Aware for World of Tanks."},
    { NULL           , NULL          ,            0, NULL}
};

PyMODINIT_FUNC initXFW_HiDPI(void)
{
    Py_InitModule("XFW_HiDPI", XFWHiDPIMethods);
}