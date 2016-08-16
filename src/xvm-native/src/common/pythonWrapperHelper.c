#include "pythonWrapperHelper.h"

#include <Tlhelp32.h>
#include <process.h>

long GetModuleSize(const char* lpFilename)
{
    MODULEENTRY32 lpme;
    long Result = 0;
    long modsize = 0;

    HANDLE hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, _getpid());

    if (hSnap)
    {
        lpme.dwSize = sizeof(MODULEENTRY32);
        Result = Module32First(hSnap, &lpme);
        
        while (Result)
        {
            if (strstr(lpFilename, lpme.szModule))
            {
                modsize = lpme.modBaseSize;
                break;
            }
            Result = Module32Next(hSnap, &lpme);
        }
        CloseHandle(hSnap);
    }
    return modsize;
}

BOOL DataCompare(const char* pData, const char* bMask, const char * szMask)
{
    for (; *szMask; ++szMask, ++pData, ++bMask)
    {
        if (*szMask == 'x' && *pData != *bMask)
        {
            return FALSE;
        }
    }
    return TRUE;
}

DWORD FindFunction(DWORD startpos, DWORD endpos, DWORD* curpos, const char* pattern, const char* mask)
{
    DWORD pos;

    for (pos=(*curpos); pos < endpos; pos++)
    {
        if (DataCompare((char*)pos, pattern, mask))
        {
            (*curpos) = pos;
            return pos;
        }
    }

    for (pos = startpos; pos < (*curpos); pos++)
    {
        if (DataCompare((char*)pos, pattern, mask))
        {
            (*curpos) = pos;
            return pos;
        }
    }

    (*curpos) = startpos;
    return 0;
}

DWORD FindStructure(DWORD address, DWORD offset)
{
    char* b = (DWORD)(address+offset);
    return MAKELONG(MAKEWORD(b[0],b[1]), MAKEWORD(b[2],b[3]));
}