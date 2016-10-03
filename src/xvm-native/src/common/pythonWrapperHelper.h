#pragma once

#include <Windows.h>

long GetModuleSize(const char* lpFilename);
BOOL DataCompare(const char* pData, const char* bMask, const char * szMask);
DWORD FindFunction(DWORD startpos, DWORD endpos, DWORD* curpos, const char* pattern, const char* mask);
DWORD FindStructure(DWORD address, DWORD offset);
BOOL ReplaceFunction(DWORD originAddress, DWORD replacementAddress);