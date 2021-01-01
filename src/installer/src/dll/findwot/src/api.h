/*
 * This file is part of the Findwot project.
 *
 * Copyright (c) 2016-2021 Findwot contributors.
 *
 * Findwot is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, version 3.
 *
 * Findwot is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#pragma once

#include  "wine.h"

#define WOTDETECTOR_API_VERSION 3

#ifdef BUILD_WOTDETECTOR
#define API_CALL __declspec(dllexport)
#else
#define API_CALL __declspec(dllimport)
#endif

//WINE
extern "C" API_CALL WineStatus __cdecl WINE_GetStatus();

//WGC
extern "C" API_CALL void __cdecl WGC_GetInstallPathA(char *buffer, int buffer_size);
extern "C" API_CALL void __cdecl WGC_GetInstallPathW(wchar_t *buffer, int buffer_size);
extern "C" API_CALL bool __cdecl WGC_IsInstalled();

//WOT
extern "C" API_CALL int __cdecl WOT_AddClientA(char *path);
extern "C" API_CALL int __cdecl WOT_AddClientW(wchar_t *path);


extern "C" API_CALL void __cdecl WOT_GetPreferredClientPathA(char *buffer, int buffer_size);
extern "C" API_CALL void __cdecl WOT_GetPreferredClientPathW(wchar_t *buffer, int buffer_size);

extern "C" API_CALL int  __cdecl WOT_GetClientsCount();

extern "C" API_CALL void __cdecl WOT_GetClientLocaleW(wchar_t *buffer, int buffer_size, unsigned int index);
extern "C" API_CALL void __cdecl WOT_GetClientLocaleA(char *buffer, int buffer_size, unsigned int index);

extern "C" API_CALL void __cdecl WOT_GetClientPathW(wchar_t *buffer, int size, unsigned int index);
extern "C" API_CALL void __cdecl WOT_GetClientPathA(char *buffer, int size, unsigned int index);

extern "C" API_CALL void __cdecl WOT_GetClientVersionW(wchar_t *buffer, int size, unsigned int index);
extern "C" API_CALL void __cdecl WOT_GetClientVersionA(char *buffer, int size, unsigned int index);

extern "C" API_CALL void __cdecl WOT_GetClientExeVersionW(wchar_t *buffer, int size, unsigned int index);
extern "C" API_CALL void __cdecl WOT_GetClientExeVersionA(char *buffer, int size, unsigned int index);

// -1- error, 0-unknown, 1-release , 2-ct, 3-st, 4-sandbox
extern "C" API_CALL int  __cdecl WOT_GetClientBranch(unsigned int index);

// -1- error, 0-unknown, 1-sd , 2-hd
extern "C" API_CALL int  __cdecl WOT_GetClientType(unsigned int index);


