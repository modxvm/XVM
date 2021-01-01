/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2009 wj32.
 * Copyright (c) 2018-2021 XVM Team.
 *
 * XVM Framework is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, version 3.
 *
 * XVM Framework is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Python.h"

#include <Windows.h>

#include <wchar.h>
#include <process.h>

#define NT_SUCCESS(x) ((x) >= 0)
#define STATUS_INFO_LENGTH_MISMATCH 0xc0000004

#define SystemHandleInformation 16
#define ObjectBasicInformation 0
#define ObjectNameInformation 1
#define ObjectTypeInformation 2

typedef NTSTATUS(NTAPI *_NtQuerySystemInformation)(
    ULONG SystemInformationClass,
    PVOID SystemInformation,
    ULONG SystemInformationLength,
    PULONG ReturnLength
    );

typedef NTSTATUS(NTAPI *_NtDuplicateObject)(
    HANDLE SourceProcessHandle,
    HANDLE SourceHandle,
    HANDLE TargetProcessHandle,
    PHANDLE TargetHandle,
    ACCESS_MASK DesiredAccess,
    ULONG Attributes,
    ULONG Options
    );

typedef NTSTATUS(NTAPI *_NtQueryObject)(
    HANDLE ObjectHandle,
    ULONG ObjectInformationClass,
    PVOID ObjectInformation,
    ULONG ObjectInformationLength,
    PULONG ReturnLength
    );

typedef struct _UNICODE_STRING
{
    USHORT Length;
    USHORT MaximumLength;
    PWSTR Buffer;
} UNICODE_STRING, *PUNICODE_STRING;

typedef struct _SYSTEM_HANDLE
{
    ULONG ProcessId;
    BYTE ObjectTypeNumber;
    BYTE Flags;
    USHORT Handle;
    PVOID Object;
    ACCESS_MASK GrantedAccess;
} SYSTEM_HANDLE, *PSYSTEM_HANDLE;

typedef struct _SYSTEM_HANDLE_INFORMATION
{
    ULONG HandleCount;
    SYSTEM_HANDLE Handles[1];
} SYSTEM_HANDLE_INFORMATION, *PSYSTEM_HANDLE_INFORMATION;

typedef enum _POOL_TYPE
{
    NonPagedPool,
    PagedPool,
    NonPagedPoolMustSucceed,
    DontUseThisType,
    NonPagedPoolCacheAligned,
    PagedPoolCacheAligned,
    NonPagedPoolCacheAlignedMustS
} POOL_TYPE, *PPOOL_TYPE;

typedef struct _OBJECT_TYPE_INFORMATION
{
    UNICODE_STRING Name;
    ULONG TotalNumberOfObjects;
    ULONG TotalNumberOfHandles;
    ULONG TotalPagedPoolUsage;
    ULONG TotalNonPagedPoolUsage;
    ULONG TotalNamePoolUsage;
    ULONG TotalHandleTableUsage;
    ULONG HighWaterNumberOfObjects;
    ULONG HighWaterNumberOfHandles;
    ULONG HighWaterPagedPoolUsage;
    ULONG HighWaterNonPagedPoolUsage;
    ULONG HighWaterNamePoolUsage;
    ULONG HighWaterHandleTableUsage;
    ULONG InvalidAttributes;
    GENERIC_MAPPING GenericMapping;
    ULONG ValidAccess;
    BOOLEAN SecurityRequired;
    BOOLEAN MaintainHandleCount;
    USHORT MaintainTypeList;
    POOL_TYPE PoolType;
    ULONG PagedPoolUsage;
    ULONG NonPagedPoolUsage;
} OBJECT_TYPE_INFORMATION, *POBJECT_TYPE_INFORMATION;

PVOID GetLibraryProcAddress(PSTR LibraryName, PSTR ProcName)
{
    return GetProcAddress(GetModuleHandleA(LibraryName), ProcName);
}

PyObject* Py_AllowMultiWot(PyObject* self, PyObject* args)
{
    _NtQuerySystemInformation NtQuerySystemInformation = GetLibraryProcAddress("ntdll.dll", "NtQuerySystemInformation");
    _NtDuplicateObject NtDuplicateObject = GetLibraryProcAddress("ntdll.dll", "NtDuplicateObject");
    _NtQueryObject NtQueryObject = GetLibraryProcAddress("ntdll.dll", "NtQueryObject");

    NTSTATUS status;
    PSYSTEM_HANDLE_INFORMATION handleInfo;
    ULONG handleInfoSize = 0x10000;
    HANDLE processHandle;
    ULONG i;
    BOOL flag = FALSE;

    processHandle = GetCurrentProcess();
    handleInfo = (PSYSTEM_HANDLE_INFORMATION)malloc(handleInfoSize);

    /* NtQuerySystemInformation won't give us the correct buffer size, so we guess by doubling the buffer size. */
    while ((status = NtQuerySystemInformation(SystemHandleInformation, handleInfo, handleInfoSize, NULL)) == STATUS_INFO_LENGTH_MISMATCH)
    {
        handleInfo = (PSYSTEM_HANDLE_INFORMATION)realloc(handleInfo, handleInfoSize *= 2);
    }

    /* NtQuerySystemInformation stopped giving us STATUS_INFO_LENGTH_MISMATCH. */
    if (!NT_SUCCESS(status))
    {
        PyErr_SetString(PyExc_RuntimeError,"NtQuerySystemInformation failed!\n");
        return NULL;
    }

    for (i = 0; i < handleInfo->HandleCount; i++)
    {
        SYSTEM_HANDLE handle = handleInfo->Handles[i];
        POBJECT_TYPE_INFORMATION objectTypeInfo;
        PVOID objectNameInfo;
        UNICODE_STRING objectName;
        ULONG returnLength;

        /* Query the object type. */
        objectTypeInfo = (POBJECT_TYPE_INFORMATION)malloc(0x1000);
        if (!NT_SUCCESS(NtQueryObject(handle.Handle, ObjectTypeInformation, objectTypeInfo, 0x1000, NULL)))
        {
            continue;
        }

        /* Query the object name (unless it has an access of 0x0012019f, on which NtQueryObject could hang. */
        if (handle.GrantedAccess == 0x0012019f)
        {
            free(objectTypeInfo);
            continue;
        }

        /* Fix crash on Wine */
        if (objectTypeInfo->Name.Buffer == NULL)
        {
            free(objectTypeInfo);
            continue;
        }

        if (wcscmp(objectTypeInfo->Name.Buffer, L"Mutant") == 0)
        {
            objectNameInfo = malloc(0x1000);
            if (!NT_SUCCESS(NtQueryObject(handle.Handle, ObjectNameInformation, objectNameInfo, 0x1000, &returnLength)))
            {
                /* Reallocate the buffer and try again. */
                objectNameInfo = realloc(objectNameInfo, returnLength);
                if (!NT_SUCCESS(NtQueryObject(handle.Handle, ObjectNameInformation, objectNameInfo, returnLength, NULL)))
                {
                    free(objectTypeInfo);
                    free(objectNameInfo);
                    continue;
                }
            }

            /* Cast our buffer into an UNICODE_STRING. */
            objectName = *(PUNICODE_STRING)objectNameInfo;

            if (objectName.Length)
            {
                if (wcsstr(objectName.Buffer, L"wot_client_mutex") ||
                    wcsstr(objectName.Buffer, L"wgc_game_mtx_") ||
                    wcsstr(objectName.Buffer, L"wgc_running_games_mtx"))
                {
                    CloseHandle(handle.Handle);
                    flag = TRUE;
                }
            }
            free(objectNameInfo);
        }
        free(objectTypeInfo);
    }

    free(handleInfo);
    CloseHandle(processHandle);

    if (flag == TRUE)
        Py_RETURN_TRUE;

    Py_RETURN_FALSE;
}

PyObject* Py_RestartWithoutMods(PyObject* self, PyObject* args)
{
    int argc;
    wchar_t** argv;
    wchar_t* cmdline = GetCommandLineW();

    if (wcsstr(cmdline,L" -safe") == NULL)
        wcscat(cmdline,L" -safe");

    if (wcsstr(cmdline,L"-wot_wait_for_mutex") == NULL)
        wcscat(cmdline,L" -wot_wait_for_mutex");

    argv = CommandLineToArgvW(cmdline,&argc);
    _wexecv(argv[0],argv);
    exit(0);
}


PyMethodDef XFWMutexMethods[] = {
    { "allow_multiple_wot", Py_AllowMultiWot, METH_VARARGS, "Allow to run another World of Tanks instance."},
    { "restart_without_mods", Py_RestartWithoutMods, METH_VARARGS, "Restart World of Tanks without mods"},
    { NULL, NULL, 0, NULL}
};

PyMODINIT_FUNC initXFW_Mutex(void)
{
    Py_InitModule("XFW_Mutex", XFWMutexMethods);
}