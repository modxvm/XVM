/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2018-2019 XVM Team.
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

#include "fix_suef.h"

#include <Windows.h>

bool Restore_SUEF()
{
    //load module
    HMODULE hmod = GetModuleHandleW(L"KernelBase.dll");
    if(hmod == nullptr)
        hmod = GetModuleHandleW(L"Kernel32.dll");

    if (hmod == nullptr)
        return false;

    //find suef
    char* function_addr =(char*)GetProcAddress(hmod, "SetUnhandledExceptionFilter");
    if (function_addr == nullptr)
        return false;

    //patch function
    DWORD dwProtect = 0;

    VirtualProtect(function_addr, 5, PAGE_EXECUTE_READWRITE, &dwProtect);
    //mov edi, edi
    function_addr[0] = 0x8B;
    function_addr[1] = 0xFF;
    //push ebp
    function_addr[2] = 0x55;
    // mov ebp, esp
    function_addr[3] = 0x8B;
    function_addr[4] = 0xEC;

    VirtualProtect(function_addr, 5, dwProtect, &dwProtect);

    return true;
}

PyObject* Py_Restore_SUEF(PyObject* self, PyObject* args)
{
    if(Restore_SUEF())
        Py_RETURN_TRUE;
    else
        Py_RETURN_FALSE;
}
