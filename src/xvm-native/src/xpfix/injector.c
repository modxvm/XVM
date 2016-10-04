/**
 * XVM Native XPFix module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include "injector.h"
#include "pythonWrapper.h"
#include "pythonWrapperHelper.h"

#include <Windows.h>

void injector(void)
{

    HMODULE dllHandle;
    FARPROC functionAddr;

    dllHandle = GetModuleHandle(TEXT("XVMNativeXPFix.dll"));
    
    //1. find_init_module
    functionAddr = GetProcAddress(dllHandle, "find_init_module_replacement");
    ReplaceFunction(find_init_module, functionAddr);

    //1. loa_source_module
    functionAddr = GetProcAddress(dllHandle, "load_source_module_replacement");
    ReplaceFunction(load_source_module, functionAddr);
}