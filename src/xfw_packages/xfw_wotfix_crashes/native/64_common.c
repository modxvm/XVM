/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2018-2020 XVM Team.
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

#include "64_common.h"

BOOL make_jmp(PVOID originAddress, PVOID replacementAddress)
{
    char* originFunction = NULL;
    DWORD dwProtect = 0;

    originFunction = originAddress;
    VirtualProtect(originFunction, 12, PAGE_EXECUTE_READWRITE, &dwProtect);

    //mov rax, ADDR
    originFunction[0] = 0x48;
    originFunction[1] = 0xB8;
    memcpy(originFunction + 2, &replacementAddress, 8);
    
    //push rax
    originFunction[10] = 0x50;

    //retn
    originFunction[11] = 0xC3;

    VirtualProtect(originFunction, 12, dwProtect, &dwProtect);

    return TRUE;
}
