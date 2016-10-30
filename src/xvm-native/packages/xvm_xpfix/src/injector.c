/**
 * XVM Native XPFix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include "injector.h"
#include "PythonWrapper.h"

#include <Windows.h>

void injector(void)
{

	HMODULE dllHandle;
	DWORD OriginFunctionAddress;
	DWORD ReplaceFunctionAddress;

	dllHandle = GetModuleHandle(TEXT("XVMNativeXPFix.pyd"));

	//1. find_init_module
	OriginFunctionAddress = WRAPPER_GetFunctionRealAddress("find_init_module");
	ReplaceFunctionAddress = (DWORD)GetProcAddress(dllHandle, "find_init_module_replacement");
	if (OriginFunctionAddress > 0 && ReplaceFunctionAddress > 0)
	{
		WRAPPER_ReplaceFunction(OriginFunctionAddress, ReplaceFunctionAddress);
	}

	//1. loa_source_module
	OriginFunctionAddress = WRAPPER_GetFunctionRealAddress("load_source_module");
	ReplaceFunctionAddress = (DWORD)GetProcAddress(dllHandle, "load_source_module_replacement");
	if (OriginFunctionAddress > 0 && ReplaceFunctionAddress > 0)
	{
		WRAPPER_ReplaceFunction(OriginFunctionAddress, ReplaceFunctionAddress);
	}
}