/**
 * XVM Native Sounds module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include "audiokinetic.h"
#include "PythonWrapper.h"

#include <Windows.h>

enum AKRESULT AK_SoundEngine_LoadBank(const char * in_pszString, AkMemPoolId in_memPoolId, AkBankID* out_bankID)
{
	AK_SoundEngine_LoadBank_Func func;

	func = (AK_SoundEngine_LoadBank_Func)GetProcAddress(GetModuleHandle(NULL), "?LoadBank@SoundEngine@AK@@YA?AW4AKRESULT@@PBDJAAK@Z");
	if (func != NULL)
	{
		return func(in_pszString, in_memPoolId, out_bankID);
	}
	return AK_Fail;
}

enum AKRESULT __cdecl AK_SoundEngine_UnloadBank(const char * in_pszString, const void * in_pInMemoryBankPtr, AkMemPoolId * out_pMemPoolId)
{
	AK_SoundEngine_UnloadBank_Func func;

	func = (AK_SoundEngine_UnloadBank_Func)GetProcAddress(GetModuleHandle(NULL), "?UnloadBank@SoundEngine@AK@@YA?AW4AKRESULT@@PBDPBXPAJ@Z");
	if (func != NULL)
	{
		return func(in_pszString, in_pInMemoryBankPtr, out_pMemPoolId);
	}
	return AK_Fail;
}