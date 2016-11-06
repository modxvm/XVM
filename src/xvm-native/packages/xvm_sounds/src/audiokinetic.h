/**
 * XVM Native Sounds module
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 */

#pragma once

//Windows/AkTypes.h
typedef long             AkInt32;
typedef unsigned long    AkUInt32;

//Common/AkTypes.h
typedef AkInt32          AkMemPoolId;
typedef AkUInt32         AkBankID;

static const AkMemPoolId AK_DEFAULT_POOL_ID = -1;

enum AKRESULT
{
	AK_NotImplemented = 0,
	AK_Success = 1,
	AK_Fail = 2,
	AK_PartialSuccess = 3,
	AK_NotCompatible = 4,
	AK_AlreadyConnected = 5,
	AK_NameNotSet = 6,
	AK_InvalidFile = 7,
	AK_AudioFileHeaderTooLarge = 8,
	AK_MaxReached = 9,
	AK_InputsInUsed = 10,
	AK_OutputsInUsed = 11,
	AK_InvalidName = 12,
	AK_NameAlreadyInUse = 13,
	AK_InvalidID = 14,
	AK_IDNotFound = 15,
	AK_InvalidInstanceID = 16,
	AK_NoMoreData = 17,
	AK_NoSourceAvailable = 18,
	AK_StateGroupAlreadyExists = 19,
	AK_InvalidStateGroup = 20,
	AK_ChildAlreadyHasAParent = 21,
	AK_InvalidLanguage = 22,
	AK_CannotAddItseflAsAChild = 23,
	//AK_TransitionNotFound     = 24,   ///< The transition is not in the list.
	//AK_TransitionNotStartable = 25,   ///< Start allowed in the Running and Done states.
	//AK_TransitionNotRemovable = 26,   ///< Must not be in the Computing state.
	//AK_UsersListFull          = 27,   ///< No one can be added any more, could be AK_MaxReached.
	//AK_UserAlreadyInList      = 28,   ///< This user is already there.
	AK_UserNotInList = 29,
	AK_NoTransitionPoint = 30,
	AK_InvalidParameter = 31,
	AK_ParameterAdjusted = 32,
	AK_IsA3DSound = 33,
	AK_NotA3DSound = 34,
	AK_ElementAlreadyInList = 35,
	AK_PathNotFound = 36,
	AK_PathNoVertices = 37,
	AK_PathNotRunning = 38,
	AK_PathNotPaused = 39,
	AK_PathNodeAlreadyInList = 40,
	AK_PathNodeNotInList = 41,
	AK_VoiceNotFound = 42,
	AK_DataNeeded = 43,
	AK_NoDataNeeded = 44,
	AK_DataReady = 45,
	AK_NoDataReady = 46,
	AK_NoMoreSlotAvailable = 47,
	AK_SlotNotFound = 48,
	AK_ProcessingOnly = 49,
	AK_MemoryLeak = 50,
	AK_CorruptedBlockList = 51,
	AK_InsufficientMemory = 52,
	AK_Cancelled = 53,
	AK_UnknownBankID = 54,
	AK_IsProcessing = 55,
	AK_BankReadError = 56,
	AK_InvalidSwitchType = 57,
	AK_VoiceDone = 58,
	AK_UnknownEnvironment = 59,
	AK_EnvironmentInUse = 60,
	AK_UnknownObject = 61,
	AK_NoConversionNeeded = 62,
	AK_FormatNotReady = 63,
	AK_WrongBankVersion = 64,
	AK_DataReadyNoProcess = 65,
	AK_FileNotFound = 66,
	AK_DeviceNotReady = 67,
	AK_CouldNotCreateSecBuffer = 68,
	AK_BankAlreadyLoaded = 69,
	AK_RenderedFX = 71,
	AK_ProcessNeeded = 72,
	AK_ProcessDone = 73,
	AK_MemManagerNotInitialized = 74,
	AK_StreamMgrNotInitialized = 75,
	AK_SSEInstructionsNotSupported = 76,
	AK_Busy = 77,
	AK_UnsupportedChannelConfig = 78,
	AK_PluginMediaNotAvailable = 79,
	AK_MustBeVirtualized = 80,
	AK_CommandTooLarge = 81,
	AK_RejectedByFilter = 82,
	AK_InvalidCustomPlatformName = 83,
	AK_DLLCannotLoad = 84
};

//Load Bank
enum AKRESULT __cdecl AK_SoundEngine_LoadBank_ByFilename(const char * in_pszString, AkMemPoolId in_memPoolId, AkBankID* out_bankID);
typedef enum AKRESULT (__cdecl *AK_SoundEngine_LoadBank_ByFilename_typedef)(const char * in_pszString, AkMemPoolId in_memPoolId, AkBankID* out_bankID);

enum AKRESULT __cdecl AK_SoundEngine_LoadBank_ByMemory_InPlace(const void * in_pInMemoryBankPtr, AkUInt32 in_uInMemoryBankSize, AkBankID* out_bankID);
typedef enum AKRESULT (__cdecl *AK_SoundEngine_LoadBank_ByMemory_InPlace_typedef)(const void * in_pInMemoryBankPtr, AkUInt32 in_uInMemoryBankSize, AkBankID* out_bankID);

enum AKRESULT __cdecl AK_SoundEngine_LoadBank_ByMemory_OutOfPlace(const void * in_pInMemoryBankPtr, AkUInt32 in_uInMemoryBankSize, AkMemPoolId in_uPoolForBankMedia, AkBankID* out_bankID);
typedef enum AKRESULT(__cdecl *AK_SoundEngine_LoadBank_ByMemory_OutOfPlace_typedef)(const void * in_pInMemoryBankPtr, AkUInt32 in_uInMemoryBankSize, AkMemPoolId in_uPoolForBankMedia, AkBankID* out_bankID);

//Unload Bank
enum AKRESULT __cdecl AK_SoundEngine_UnloadBank_ByFilename(const char * in_pszString, const void * in_pInMemoryBankPtr, AkMemPoolId * out_pMemPoolId);
typedef enum AKRESULT(__cdecl *AK_SoundEngine_UnloadBank_ByFilename_typedef)(const char * in_pszString, const void * in_pInMemoryBankPtr, AkMemPoolId * out_pMemPoolId);

enum AKRESULT __cdecl AK_SoundEngine_UnloadBank_ByBankID(AkBankID in_bankID, const void * in_pInMemoryBankPtr, AkMemPoolId * out_pMemPoolId);
typedef enum AKRESULT(__cdecl *AK_SoundEngine_UnloadBank_ByBankID_typedef)(AkBankID in_bankID, const void * in_pInMemoryBankPtr, AkMemPoolId * out_pMemPoolId);