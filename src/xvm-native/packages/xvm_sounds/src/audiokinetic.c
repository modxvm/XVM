/**
 * XVM Native Sounds module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include "audiokinetic.h"
#include "PythonWrapper.h"

#include <Windows.h>

enum AKRESULT AK_SoundEngine_LoadBank(const void * in_pInMemoryBankPtr, AkUInt32 in_uInMemoryBankSize, AkMemPoolId in_uPoolForBankMedia, AkBankID* out_bankID)
{
	AK_SoundEngine_LoadBank_typedef func;

	func = (AK_SoundEngine_LoadBank_typedef)GetProcAddress(GetModuleHandle(NULL), "?LoadBank@SoundEngine@AK@@YA?AW4AKRESULT@@PBXKJAAK@Z");
	if (func != NULL)
	{
		return func(in_pInMemoryBankPtr, in_uInMemoryBankSize, in_uPoolForBankMedia, out_bankID);
	}
	return AK_DLLCannotLoad;
}

enum AKRESULT __cdecl AK_SoundEngine_UnloadBank(AkBankID in_bankID, const void * in_pInMemoryBankPtr, AkMemPoolId * out_pMemPoolId)
{
	AK_SoundEngine_UnloadBank_typedef func;

	func = (AK_SoundEngine_UnloadBank_typedef)GetProcAddress(GetModuleHandle(NULL), "?UnloadBank@SoundEngine@AK@@YA?AW4AKRESULT@@KPBXPAJ@Z");
	if (func != NULL)
	{
		return func(in_bankID, in_pInMemoryBankPtr, out_pMemPoolId);
	}
	return AK_DLLCannotLoad;
}