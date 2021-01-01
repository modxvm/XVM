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

#include "api.h"

#include "wotdetector.h"
#include "wgc.h"

#include <Windows.h>

#include <locale>
#include <codecvt>
#include <string>

WineStatus WINE_GetStatus()
{
    return Wine::GetStatus();
}

void WGC_GetInstallPathA(char * buffer, int buffer_size)
{
    if (buffer_size <= 0)
    {
        return;
    }

    wchar_t* wbuffer = (wchar_t*)malloc(buffer_size * sizeof(wchar_t));

    if (wbuffer != nullptr)
    {
        WGC_GetInstallPathW(wbuffer, buffer_size);

        WideCharToMultiByte(
            CP_ACP,
            0,
            wbuffer,
            buffer_size * sizeof(wchar_t),
            buffer,
            buffer_size * sizeof(char),
            NULL,
            NULL);

        free(wbuffer);
    }
}

void WGC_GetInstallPathW(wchar_t * buffer, int buffer_size)
{
    if (buffer_size <= 0)
    {
        return;
    }

    std::wstring wgcpath = WGC::GetWGCInstallPath();

    if (!wgcpath.empty())
    {
        wcscpy_s(buffer, buffer_size, wgcpath.c_str());
    }
    else
    {
        buffer[0] = '\0';
    }
}

bool WGC_IsInstalled()
{
    return !WGC::GetWGCInstallPath().empty();
}

API_CALL int WOT_AddClientA(char * path)
{
    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> converter;
    return WotDetector::AddClient(converter.from_bytes(path));
}

API_CALL int WOT_AddClientW(wchar_t * path)
{
    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    return WotDetector::AddClient(std::wstring(path));
}


void WOT_GetPreferredClientPathW(wchar_t *buffer, int buffer_size)
{
    if (buffer_size <= 0)
    {
        return;
    }

    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    if (WotDetector::clients.size() > 0)
    {
        wcscpy_s(buffer, buffer_size, WotDetector::clients[0].GetPath().c_str());
    }
    else
    {
        buffer[0] = '\0';
    }
}

void WOT_GetPreferredClientPathA(char *buffer, int buffer_size)
{
    if (buffer_size <= 0)
    {
        return;
    }

    wchar_t* wbuffer = (wchar_t*)malloc(buffer_size * sizeof(wchar_t));

    if (wbuffer != nullptr)
    {
        WOT_GetPreferredClientPathW(wbuffer, buffer_size);

        WideCharToMultiByte(
            CP_ACP,
            0,
            wbuffer,
            buffer_size * sizeof(wchar_t),
            buffer,
            buffer_size * sizeof(char),
            NULL,
            NULL);

        free(wbuffer);
    }
}

int  WOT_GetClientsCount()
{
    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    return WotDetector::clients.size();
}

API_CALL void WOT_GetClientLocaleW(wchar_t * buffer, int buffer_size, unsigned int index)
{
    if (buffer_size <= 0)
    {
        return;
    }

    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    if (WotDetector::clients.size() > index)
    {
        wcscpy_s(buffer, buffer_size, WotDetector::clients[index].GetClientLocale().c_str());
    }
    else
    {
        buffer[0] = '\0';
    }
}

API_CALL void WOT_GetClientLocaleA(char * buffer, int buffer_size, unsigned int index)
{
    if (buffer_size <= 0)
    {
        return;
    }

    wchar_t* wbuffer = (wchar_t*)malloc(buffer_size * sizeof(wchar_t));
    if (wbuffer != nullptr)
    {
        WOT_GetClientLocaleW(wbuffer, buffer_size, index);

        WideCharToMultiByte(
            CP_ACP,
            0,
            wbuffer,
            buffer_size * sizeof(wchar_t),
            buffer,
            buffer_size * sizeof(char),
            NULL,
            NULL);

        free(wbuffer);
    }
}

void WOT_GetClientPathW(wchar_t *buffer, int buffer_size, unsigned int index)
{
    if (buffer_size <= 0)
    {
        return;
    }

    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    if (WotDetector::clients.size() > index)
    {
        wcscpy_s(buffer, buffer_size, WotDetector::clients[index].GetPath().c_str());
    }
    else
    {
        buffer[0] = '\0';
    }
}

void WOT_GetClientPathA(char *buffer, int buffer_size, unsigned int index)
{
    if (buffer_size <= 0)
    {
        return;
    }

    wchar_t* wbuffer = (wchar_t*)malloc(buffer_size * sizeof(wchar_t));
    if (wbuffer != nullptr)
    {
        WOT_GetClientPathW(wbuffer, buffer_size, index);

        WideCharToMultiByte(
            CP_ACP,
            0,
            wbuffer,
            buffer_size * sizeof(wchar_t),
            buffer,
            buffer_size * sizeof(char),
            NULL,
            NULL);

        free(wbuffer);
    }
}

void WOT_GetClientVersionW(wchar_t *buffer, int buffer_size, unsigned int index)
{
    if (buffer_size <= 0)
    {
        return;
    }

    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    if (WotDetector::clients.size() > index)
    {
        wcscpy_s(buffer, buffer_size, WotDetector::clients[index].GetClientVersion().c_str());
    }
    else
    {
        buffer[0] = '\0';
    }
}

extern "C" void __cdecl WOT_GetClientVersionA(char *buffer, int buffer_size, unsigned int index)
{
    if (buffer_size <= 0)
    {
        return;
    }

    wchar_t* wbuffer = (wchar_t*)malloc(buffer_size * sizeof(wchar_t));
    if (wbuffer != nullptr)
    {
        WOT_GetClientVersionW(wbuffer, buffer_size, index);

        WideCharToMultiByte(
            CP_ACP,
            0,
            wbuffer,
            buffer_size * sizeof(wchar_t),
            buffer,
            buffer_size * sizeof(char),
            NULL,
            NULL);

        free(wbuffer);
    }
}

void WOT_GetClientExeVersionW(wchar_t *buffer, int buffer_size, unsigned int index)
{
    if (buffer_size <= 0)
    {
        return;
    }

    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    if (WotDetector::clients.size() > index)
    {
        wcscpy_s(buffer, buffer_size, WotDetector::clients[index].GetClientExeVersion().c_str());
    }
    else
    {
        buffer[0] = '\0';
    }
}

extern "C" void __cdecl WOT_GetClientExeVersionA(char *buffer, int buffer_size, unsigned int index)
{
    if (buffer_size <= 0)
    {
        return;
    }

    wchar_t* wbuffer = (wchar_t*)malloc(buffer_size * sizeof(wchar_t));
    if (wbuffer != nullptr)
    {
        WOT_GetClientExeVersionW(wbuffer, buffer_size, index);

        WideCharToMultiByte(
            CP_ACP,
            0,
            wbuffer,
            buffer_size * sizeof(wchar_t),
            buffer,
            buffer_size * sizeof(char),
            NULL,
            NULL);

        free(wbuffer);
    }
}

API_CALL int WOT_GetClientBranch(unsigned int index)
{
    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    if (WotDetector::clients.size() > index)
    {
        return WotDetector::clients[index].GetClientBranch();
    }
    else
    {
        return -1;
    }
}

API_CALL int WOT_GetClientType(unsigned int index)
{
    if (!WotDetector::IsInitialized())
    {
        WotDetector::FindClients();
    }

    if (WotDetector::clients.size() > index)
    {
        return WotDetector::clients[index].GetClientType();
    }
    else
    {
        return -1;
    }
}
