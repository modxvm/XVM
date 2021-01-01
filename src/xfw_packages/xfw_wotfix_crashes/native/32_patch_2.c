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

//Search string: 56 8B F1 83 7E 48 00 75 3A 8B 4E 4C 85 C9 74 07

static const char* function_signature = "\x56\x8B\xF1\x83\x7E\x48\x00\x75\x3A\x8B\x4E\x4C\x85\xC9\x74\x07";
static const char* function_signature_mask = "xxxxxxxxxxxxxxxx";

static const DWORD replace_addr_offset = 0x0;
static const char replace_addr_test = 0x56;
static DWORD* replace_addr = NULL;

static const DWORD return_addr_offset = 0x7;
static const char return_addr_test = 0x75;
static DWORD* return_addr = NULL;

_declspec(naked)
static void bugfix_asm()
{
    __asm
    {
        test    ecx, ecx
        jz      this_is_nullptr

        push    esi
        mov     esi, ecx
        cmp     dword ptr[esi + 48h], 0 // CRASH, ESI = 0x0

        jmp     return_addr

        this_is_nullptr:
        mov eax, 0
        retn
    }
}


int bugfix2_apply()
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
