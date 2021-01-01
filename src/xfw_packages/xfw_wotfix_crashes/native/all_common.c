/**
* This file is part of the XVM project.
*
* Copyright (c) 2017-2021 XVM contributors.
*
* This file is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as
* published by the Free Software Foundation, version 3.
*
* This file is distributed in the hope that it will be useful, but
* WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
* Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include "all_common.h"

#include <Tlhelp32.h>
#include <process.h>


size_t GetModuleSize(const wchar_t* filename)
{
    MODULEENTRY32W moduleEntry;
    size_t moduleSize = 0;

    HANDLE hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, _getpid());
    if (hSnap)
    {
        moduleEntry.dwSize = sizeof(MODULEENTRY32W);
        BOOL Result = Module32FirstW(hSnap, &moduleEntry);

        while (Result)
        {
            if (wcsstr(filename, moduleEntry.szModule))
            {
                moduleSize = moduleEntry.modBaseSize;
                break;
            }
            Result = Module32NextW(hSnap, &moduleEntry);
        }
        CloseHandle(hSnap);
    }

    return moduleSize;
}

BOOL DataCompare(const char* pData, const char* bMask, const char* szMask)
{
    for (; *szMask; ++szMask, ++pData, ++bMask) {
        if (*szMask == 'x' && *pData != *bMask)    {
            return FALSE;
        }
    }

    return TRUE;
}

size_t FindFunction(size_t startpos, size_t endpos, const char* pattern, const char* mask)
{
    for (size_t pos = startpos; pos < endpos; pos++) {
        if (DataCompare((const char*)pos, pattern, mask) == TRUE) {
            return pos;
        }
    }

    return 0;
}
