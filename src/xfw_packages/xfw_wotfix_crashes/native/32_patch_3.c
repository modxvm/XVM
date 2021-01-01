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

//IDA Search string: 55 8B EC 51 53 8B D9 57 33 FF 8B 83 24 4B 00 00
static const char* function_signature = "\x55\x8B\xEC\x51\x53\x8B\xD9\x57\x33\xFF\x8B\x83\x24\x4B\x00\x00";
static const char* function_signature_mask = "xxxxxxxxxxxxxxxx";

static const DWORD replace_addr_offset = 0x20;
static const char replace_addr_test = 0x8B;
static DWORD* replace_addr = NULL;

static const DWORD return_addr_offset = 0x3F;
static const char return_addr_test = 0x8B;
static DWORD* return_addr = NULL;

static const DWORD return2_addr_offset = 0x5F;
static const char return2_addr_test = 0x47;
static DWORD* return2_addr = NULL;

_declspec(naked)
static void bugfix_asm()
{
    __asm
    {
        mov     eax, [ebx+4B20h]
        lea     ecx, ds:0[edi*4]
        push    dword ptr[ebp + 8]
        push    ebx
        mov     ecx, [ecx+eax]

        //crashfix-6
        test    ecx, ecx
        jz      check_failed
        mov     eax, [ecx]      // CRASH, ECX=0x0

        mov     eax, [eax+14h]
        call    eax
        test    al, al
        jz      check_failed

        jmp return_addr

        check_failed:
        jmp return2_addr
    }
}


int bugfix3_apply()
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

    return2_addr = crashfunction_addr + return2_addr_offset;
    test = return2_addr;
    if (test[0] != return2_addr_test) {
        return -4;
    }

    make_jmp(replace_addr, bugfix_asm);
    return 0;
}
