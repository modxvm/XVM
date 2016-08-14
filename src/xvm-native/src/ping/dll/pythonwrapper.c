/**
 * XVM Native ping module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 * @author Fecell
 */

#include "pythonwrapper.h"

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
        if (*szMask == 'x' && *pData != *bMask)
            return FALSE;
    return TRUE;
}

DWORD FindPattern2(DWORD dwAddress, DWORD dwLen, const char *bMask, const char* szMask)
{
    DWORD i;
    for (i = 0; i < dwLen; i++)
        if (DataCompare((char*)(dwAddress + i), bMask, szMask))
            return (DWORD)(dwAddress + i);
    return 0;
}

DWORD FindPattern(const char* pattern, const char* mask)
{
    TCHAR lpFilename[2048];
    HMODULE hDll;
    GetModuleFileName(NULL, lpFilename, 2048);
    hDll = GetModuleHandleA(lpFilename);
    return FindPattern2((DWORD)hDll, GetModuleSize(lpFilename), pattern, mask);
}

wrp_Py_BuildValue_typedef* wrp_Py_BuildValue_func;
wrp_Py_InitModule4_typedef* wrp_Py_InitModule4_func;
wrp_PyArg_ParseTuple_typedef* wrp_PyArg_ParseTuple_func;
wrp_PyEval_RestoreThread_typedef* wrp_PyEval_RestoreThread_func;
wrp_PyEval_SaveThread_typedef* wrp_PyEval_SaveThread_func;

void pythonwrapper_init(void)
{
    char const* wrp_Py_BuildValue_pattern="\x55\x8B\xEC\x6A\x00\x8D\x45\x0C\x50\xFF\x75\x08\xE8";
    char const* wrp_Py_BuildValue_mask="xxxxxxxxxxxxx";

    char const* wrp_Py_InitModule4_pattern="\x55\x8B\xEC\x81\xEC\x14\x02\x00\x00\xA1\x00\x00\x00\x00\x33\xC5\x89\x45\xFC\x8B\x45\x10\x53\x8B\x5D\x0C\x89\x85\xF4\xFD\xFF\xFF";
    char const* wrp_Py_InitModule4_mask="xxxxxxxxxx????xxxxxxxxxxxxxxxxxx";

    char const* wrp_PyArg_ParseTuple_pattern="\x55\x8B\xEC\x51\x8D\x45\x10\x89\x45\xFC\x6A\x00\x8D\x45\xFC\x50";
    char const* wrp_PyArg_ParseTuple_mask="xxxxxxxxxxxxxxxx";

    char const* wrp_PyEval_RestoreThread_pattern = "\x55\x8B\xEC\x83\x7D\x08\x00\x75\x0D\x68\x00\x00\x00\x00\xE8\x00\x00\x00\x00\x83\xC4\x04\x83\x3D";
    char const* wrp_PyEval_RestoreThread_mask = "xxxxxxxxxx????x????xxxxx";

    char const* wrp_PyEval_SaveThread_pattern = "\x56\x6A\x00\xE8\x00\x00\x00\x00\x8B\xF0\x83\xC4\x04\x85\xF6\x75\x0D";
    char const* wrp_PyEval_SaveThread_mask = "xxxx????xxxxxxxxx";

    wrp_Py_BuildValue_func = (wrp_Py_BuildValue_typedef*)(FindPattern(wrp_Py_BuildValue_pattern,wrp_Py_BuildValue_mask));
    wrp_Py_InitModule4_func = (wrp_Py_InitModule4_typedef*)(FindPattern(wrp_Py_InitModule4_pattern,wrp_Py_InitModule4_mask));
    wrp_PyArg_ParseTuple_func = (wrp_PyArg_ParseTuple_typedef*)( FindPattern(wrp_PyArg_ParseTuple_pattern,wrp_PyArg_ParseTuple_mask));
    wrp_PyEval_RestoreThread_func = (wrp_PyEval_RestoreThread_typedef*)(FindPattern(wrp_PyEval_RestoreThread_pattern, wrp_PyEval_RestoreThread_mask));
    wrp_PyEval_SaveThread_func = (wrp_PyEval_SaveThread_typedef*)(FindPattern(wrp_PyEval_SaveThread_pattern, wrp_PyEval_SaveThread_mask));
}