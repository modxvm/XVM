/**
 * XVM Native Sounds module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#include "audiokinetic.h"
#include "PythonWrapper.h"

#include <Windows.h>

enum AKRESULT AK_SoundEngine_LoadBank_ByFilename(const char * in_pszString, AkMemPoolId in_memPoolId, AkBankID* out_bankID)
{
	AK_SoundEngine_LoadBank_ByFilename_typedef func;

	func = (AK_SoundEngine_LoadBank_ByFilename_typedef)GetProcAddress(GetModuleHandle(NULL), "?LoadBank@SoundEngine@AK@@YA?AW4AKRESULT@@PBDJAAK@Z");
	if (func != NULL)
	{
		return func(in_pszString, in_memPoolId, out_bankID);
	}
	return AK_Fail;
}

enum AKRESULT AK_SoundEngine_LoadBank_ByMemory_InPlace(const void * in_pInMemoryBankPtr, AkUInt32 in_uInMemoryBankSize, AkBankID* out_bankID)
{
	AK_SoundEngine_LoadBank_ByMemory_InPlace_typedef func;

	func = (AK_SoundEngine_LoadBank_ByMemory_InPlace_typedef)GetProcAddress(GetModuleHandle(NULL), "?LoadBank@SoundEngine@AK@@YA?AW4AKRESULT@@PBXKAAK@Z");
	if (func != NULL)
	{
		return func(in_pInMemoryBankPtr, in_uInMemoryBankSize, out_bankID);
	}
	return AK_Fail;
}

enum AKRESULT AK_SoundEngine_LoadBank_ByMemory_OutOfPlace(const void * in_pInMemoryBankPtr, AkUInt32 in_uInMemoryBankSize, AkMemPoolId in_uPoolForBankMedia, AkBankID* out_bankID)
{
	AK_SoundEngine_LoadBank_ByMemory_OutOfPlace_typedef func;

	func = (AK_SoundEngine_LoadBank_ByMemory_OutOfPlace_typedef)GetProcAddress(GetModuleHandle(NULL), "?LoadBank@SoundEngine@AK@@YA?AW4AKRESULT@@PBXKJAAK@Z");
	if (func != NULL)
	{
		return func(in_pInMemoryBankPtr, in_uInMemoryBankSize, in_uPoolForBankMedia, out_bankID);
	}
	return AK_Fail;
}

enum AKRESULT __cdecl AK_SoundEngine_UnloadBank_ByFilename(const char * in_pszString, const void * in_pInMemoryBankPtr, AkMemPoolId * out_pMemPoolId)
{
	AK_SoundEngine_UnloadBank_ByFilename_typedef func;

	func = (AK_SoundEngine_UnloadBank_ByFilename_typedef)GetProcAddress(GetModuleHandle(NULL), "?UnloadBank@SoundEngine@AK@@YA?AW4AKRESULT@@PBDPBXPAJ@Z");
	if (func != NULL)
	{
		return func(in_pszString, in_pInMemoryBankPtr, out_pMemPoolId);
	}
	return AK_Fail;
}

enum AKRESULT __cdecl AK_SoundEngine_UnloadBank_ByBankID(AkBankID in_bankID, const void * in_pInMemoryBankPtr, AkMemPoolId * out_pMemPoolId)
{
	AK_SoundEngine_UnloadBank_ByBankID_typedef func;

	func = (AK_SoundEngine_UnloadBank_ByBankID_typedef)GetProcAddress(GetModuleHandle(NULL), "?UnloadBank@SoundEngine@AK@@YA?AW4AKRESULT@@KPBXPAJ@Z");
	if (func != NULL)
	{
		return func(in_bankID, in_pInMemoryBankPtr, out_pMemPoolId);
	}
	return AK_Fail;
}