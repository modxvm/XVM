/**
 * XVM Native ping module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 * @author Fecell
 */

#include "pythonWrapper.h"
#include "pythonWrapperHelper.h"

wrp_PyArg_ParseTuple_typedef* wrp_PyArg_ParseTuple_func;
wrp_Py_BuildValue_typedef* wrp_Py_BuildValue_func;
wrp_Py_InitModule4_typedef* wrp_Py_InitModule4_func;
wrp_PyEval_RestoreThread_typedef* wrp_PyEval_RestoreThread_func;
wrp_PyEval_SaveThread_typedef* wrp_PyEval_SaveThread_func;

void pythonWrapperInit(void)
{
    DWORD startpos;
    DWORD curpos;
    DWORD endpos;
    TCHAR lpFilename[2048];

    GetModuleFileName(NULL, lpFilename, 2048);
    startpos = (DWORD)GetModuleHandleA(lpFilename);
    endpos = (DWORD)GetModuleSize(lpFilename);
    curpos = startpos;

    wrp_PyArg_ParseTuple_func = (wrp_PyArg_ParseTuple_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x51\x8D\x45\x10\x89\x45\xFC\x8D\x45\xFC\x6A\x00","xxxxxxxxxxxxxxx"));
    wrp_Py_BuildValue_func = (wrp_Py_BuildValue_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x6A\x00\x8D\x45\x0C\x50\xFF\x75\x08\xE8","xxxxxxxxxxxxx"));
    wrp_Py_InitModule4_func = (wrp_Py_InitModule4_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x81\xEC\x14\x02\x00\x00\xA1\x00\x00\x00\x00\x33\xC5\x89\x45\xFC\x8B\x45\x10\x53\x8B\x5D\x0C\x89\x85\x00\xFD\xFF\xFF","xxxxxxxxxx????xxxxxxxxxxxxxx?xxx"));
    wrp_PyEval_RestoreThread_func = (wrp_PyEval_RestoreThread_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x83\x7D\x08\x00\x75\x0D\x68\x00\x00\x00\x00\xE8\x00\x00\x00\x00\x83\xC4\x04\x83\x3D","xxxxxxxxxx????x????xxxxx"));
    wrp_PyEval_SaveThread_func = (wrp_PyEval_SaveThread_typedef*)(FindFunction(startpos, endpos, &curpos, "\x56\x6A\x00\xE8\x00\x00\x00\x00\x8B\xF0\x83\xC4\x04\x85\xF6\x75\x0D","xxxx????xxxxxxxxx"));
}