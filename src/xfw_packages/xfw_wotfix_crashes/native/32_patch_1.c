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

#include <Python.h>

#include "all_common.h"
#include "32_common.h"

//search string: 55 8B EC 83 EC 18 53 8B D9 56 57 8D 7B 08 89 5D
static const char* function_signature = "\x55\x8B\xEC\x83\xEC\x18\x53\x8B\xD9\x56\x57\x8D\x7B\x08\x89\x5D";
static const char* function_signature_mask = "xxxxxxxxxxxxxxxx";

static const DWORD replace_addr_offset = 0x1A0;
static const char replace_addr_test = 0x8B;
static DWORD* replace_addr = NULL;

static const DWORD return_addr_offset = 0x1AE;
static const char return_addr_test = 0x47;
static DWORD* return_addr = NULL;


_declspec(naked)
static void bugfix_asm()
{
    __asm
    {
        mov     eax, [ebx+4B20h]
        mov     ecx, [eax+edi*4]

        //Crashfix: ECX = 0x0
        test ecx, ecx
        jz aftercall
        mov     eax, [ecx]

        call    dword ptr [eax+10h]

        aftercall:
            jmp     return_addr
    }
}


int bugfix1_apply()
{
    //init search
    WCHAR lpFilename[2048];
    GetModuleFileNameW(NULL, lpFilename, 2048);
    DWORD startpos = (DWORD)GetModuleHandleW(lpFilename);
    DWORD endpos = startpos + GetModuleSize(lpFilename);

    char *test = NULL;

    DWORD crashfunction_addr = FindFunction(startpos, endpos, function_signature, function_signature_mask);
    if (crashfunction_addr == 0) {
        return -1;
    }

    replace_addr = crashfunction_addr + replace_addr_offset;
    test = replace_addr;
    if (test[0] != replace_addr_test) {
        return -2;
    }

    return_addr = crashfunction_addr + return_addr_offset;
    test = return_addr;
    if (test[0] != return_addr_test) {
        return -3;
    }

    make_jmp(replace_addr, bugfix_asm);
    return 0;
}
