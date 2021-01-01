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

#include "wine.h"

#include <Windows.h>
#include <iostream>

WineStatus Wine::GetStatus()
{
    typedef char *(__cdecl *t_wine_get_build_id)(void);
    typedef void (__cdecl *t_wine_get_host_version)(const char **sysname, const char **release );

    WineStatus st;

    HMODULE ntdll = GetModuleHandleA("ntdll.dll");
    if(ntdll != NULL)
    {
        if(GetProcAddress(ntdll,"wine_server_call") != NULL)
            st.running_on = true;

        const t_wine_get_build_id wine_get_build_id = t_wine_get_build_id(GetProcAddress(ntdll, "wine_get_version"));
        if (wine_get_build_id != NULL)
        {
            char* build = wine_get_build_id();
            st.build = new wchar_t[strlen(build) + 1]{};
            mbstowcs(st.build, build, strlen(build));
        }

        const t_wine_get_host_version wine_get_host_version = t_wine_get_host_version(GetProcAddress(ntdll, "wine_get_host_version"));
        if (wine_get_host_version != NULL)
        {
            const char* sys = nullptr;
            const char* rel = nullptr;
            wine_get_host_version(&sys, &rel);

            st.system = new wchar_t[strlen(sys) + 1]{};
            if (sys!=nullptr)
                mbstowcs(st.system, sys, strlen(sys));

            st.release = new wchar_t[strlen(rel) + 1]{};
            if (rel!=nullptr)
                mbstowcs(st.release, rel, strlen(rel));
        }
    }

    return st;
}
