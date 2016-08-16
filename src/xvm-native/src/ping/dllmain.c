/**
 * XVM Native ping module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include "dllmain.h"
#include "pythonwrapper.h"

BOOL WINAPI DllMain(IN HINSTANCE hDllHandle, IN DWORD nReason, IN LPVOID Reserved) 
{
    switch ( nReason ) 
    {
        case DLL_PROCESS_ATTACH:
            pythonWrapperInit();
            break;
        default:
            break;
    }

    return TRUE;
}