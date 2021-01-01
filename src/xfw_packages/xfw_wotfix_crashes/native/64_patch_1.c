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

//IDA search: 48 89 5C 24 08 48 89 6C 24 10 48 89 74 24 18 57 41 54 41 55 41 56 41 57 48 83 EC 20 48 ? ? ? ? ? ? 4C 8B F1 48 89 01 48 8D 59 10
static const char* function_signature = "\x48\x89\x5C\x24\x08\x48\x89\x6C\x24\x10\x48\x89\x74\x24\x18\x57\x41\x54\x41\x55\x41\x56\x41\x57\x48\x83\xEC\x20\x48\xFF\xFF\xFF\xFF\xFF\xFF\x4C\x8B\xF1\x48\x89\x01\x48\x8D\x59\x10";
static const char* function_signature_mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx??????xxxxxxxxxx";

static const DWORD replace_addr_offset = 0x200;
static const char replace_addr_test = 0x49;

static const DWORD return_addr_offset = 0x219;
static const char return_addr_test = 0x45;

//ASM
extern size_t patch_1_replaceaddr;
extern size_t patch_1_returnaddr;
extern void patch_1_asmfunc();

int patch_1_apply()
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

    patch_1_replaceaddr = crashfunction_addr + replace_addr_offset;
    test = patch_1_replaceaddr;
    if (test[0] != replace_addr_test) {
        return -2;
    }

    patch_1_returnaddr = crashfunction_addr + return_addr_offset;
    test = patch_1_returnaddr;
    if (test[0] != return_addr_test) {
        return -3;
    }

    make_jmp(patch_1_replaceaddr, patch_1_asmfunc);
    return 0;
}
