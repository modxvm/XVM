/**
 * XVM Native ping module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 * @author Fecell
 */

#include "pythonWrapper.h"
#include "pythonWrapperHelper.h"
#include "findmodule.h"

wrp_Py_InitModule4_typedef* wrp_Py_InitModule4_func;

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

    wrp_Py_InitModule4_func = (wrp_Py_InitModule4_typedef*)(FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x81\xEC\x14\x02\x00\x00\xA1\x00\x00\x00\x00\x33\xC5\x89\x45\xFC\x8B\x45\x10\x53\x8B\x5D\x0C\x89\x85\x00\xFD\xFF\xFF","xxxxxxxxxx????xxxxxxxxxxxxxx?xxx"));

	//lol
	curpos = startpos;
	int targetfunctionaddr = (FindFunction(startpos, endpos, &curpos, "\x55\x8B\xEC\x83\xEC\x34\xA1\x00\x00\x00\x00\x33\xC5\x89\x45\xFC\x56\x57\x8B\x7D\x08\x8B\xF7\x8D\x4E\x01\x66\x0F\x1F\x44\x00\x00", "xxxxxxx????xxxxxxxxxxxxxxxxxxxxx"));
		
	//write
	if (targetfunctionaddr > 0)
	{
		char* targetfunction = targetfunctionaddr;
		FARPROC procaddr = GetProcAddress(GetModuleHandle(TEXT("XVMNativeXPFix.dll")), "my_find_init_module");
		DWORD dwProtect;
		VirtualProtect(targetfunction, 6, PAGE_EXECUTE_READWRITE, &dwProtect);
		targetfunction[0] = 0x68;
		memcpy(targetfunction + 1, &procaddr, sizeof(int));
		targetfunction[5] = 0xC3;
		VirtualProtect(targetfunction, 6, dwProtect, NULL);
	}

	return;
}