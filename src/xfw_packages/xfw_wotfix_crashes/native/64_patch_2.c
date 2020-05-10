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

#include <Python.h>

#include "all_common.h"
#include "64_common.h"

//IDA search: 48 85 D2 0F 84 E1 00 00 00 56 48 83 EC 20 48 8B
static const char* function_signature = "\x48\x85\xD2\x0F\x84\xE1\x00\x00\x00\x56\x48\x83\xEC\x20\x48\x8B";
static const char* function_signature_mask = "xxxxxxxxxxxxxxxx";

static const DWORD replace_addr_offset = 0x3A;
static const char replace_addr_test = 0x48;

static const DWORD return_addr_offset = 0x77;
static const char return_addr_test = 0x48;

//ASM
extern size_t patch_2_replaceaddr;
extern size_t patch_2_returnaddr;
extern void patch_2_asmfunc();

int patch_2_apply()
{
    //init search
    WCHAR lpFilename[2048];
    GetModuleFileNameW(NULL, lpFilename, 2048);
    size_t startpos = GetModuleHandleW(lpFilename);
    size_t endpos = startpos + GetModuleSize(lpFilename);

    char *test = NULL;

    size_t crashfunction_addr = FindFunction(startpos, endpos, function_signature, function_signature_mask);
    if (crashfunction_addr == 0) {
        return -1;
    }

    patch_2_replaceaddr = crashfunction_addr + replace_addr_offset;
    test = patch_2_replaceaddr;
    if (test[0] != replace_addr_test) {
        return -2;
    }

    patch_2_returnaddr = crashfunction_addr + return_addr_offset;
    test = patch_2_returnaddr;
    if (test[0] != return_addr_test) {
        return -3;
    }

    make_jmp(patch_2_replaceaddr, patch_2_asmfunc);
    return 0;
}
