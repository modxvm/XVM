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

#include "64_common.h"

//requires 13 bytes in the original function
//requires pop rax at the beggining of your replacement code
BOOL make_jmp(PVOID originAddress, PVOID replacementAddress)
{
    char* originFunction = NULL;
    DWORD dwProtect = 0;

    originFunction = originAddress;
    VirtualProtect(originFunction, 13, PAGE_EXECUTE_READWRITE, &dwProtect);

    //push rax
    originFunction[0] = 0x50;

    //mov rax, QWORD
    originFunction[1] = 0x48;
    originFunction[2] = 0xB8;
    memcpy(originFunction + 3, &replacementAddress, 8);

    //jmp rax
    originFunction[11] = 0xFF;
    originFunction[12] = 0xE0;

    VirtualProtect(originFunction, 13, dwProtect, &dwProtect);

    return TRUE;
}
