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
#include "64_common.h"

//IDA search: 40 56 41 54 41 55 48 83 EC 30 4C 8B A1 E8 4C 00 00
static const char* function_signature = "\x40\x56\x41\x54\x41\x55\x48\x83\xEC\x30\x4C\x8B\xA1\xE8\x4C\x00\x00";
static const char* function_signature_mask = "xxxxxxxxxxxxxxxxx";

static const DWORD replace_addr_offset = 0x10E;
static const char replace_addr_test = 0x48;

static const DWORD return_addr_offset = 0x126;
static const char return_addr_test = 0x75;

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
