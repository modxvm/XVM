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

#include "32_common.h"

BOOL __stdcall IsBadReadPtrVQ(PVOID p)
{
    MEMORY_BASIC_INFORMATION mbi = { 0 };
    if (VirtualQuery(p, &mbi, sizeof(mbi)))
    {
        DWORD mask = (PAGE_READONLY | PAGE_READWRITE | PAGE_WRITECOPY | PAGE_EXECUTE_READ | PAGE_EXECUTE_READWRITE | PAGE_EXECUTE_WRITECOPY);
        BOOL b = !(mbi.Protect & mask);

        if (mbi.Protect & (PAGE_GUARD | PAGE_NOACCESS))
            b = TRUE;

        return b;
    }
    return TRUE;
}

BOOL make_jmp(PVOID originAddress, PVOID replacementAddress)
{
    char* originFunction;
    DWORD dwProtect;

    originFunction = originAddress;
    VirtualProtect(originFunction, 6, PAGE_EXECUTE_READWRITE, &dwProtect);

    //push ADDR
    originFunction[0] = 0x68;
    memcpy(originFunction + 1, &replacementAddress, sizeof(int));
    //jmp eax
    originFunction[5] = 0xC3;

    VirtualProtect(originFunction, 6, dwProtect, &dwProtect);

    return TRUE;
}
