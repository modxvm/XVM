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

#include "registry.h"

#include <Windows.h>

std::wstring Registry::GetStringValue(const wchar_t* subkey, const wchar_t* value)
{
    HKEY hKey = 0;
    wchar_t val[1024] { 0 };
    DWORD value_length = 1024;

    if (RegOpenKeyW(HKEY_CURRENT_USER, subkey, &hKey) != ERROR_SUCCESS)
    {
        if(RegOpenKeyW(HKEY_LOCAL_MACHINE, subkey, &hKey) != ERROR_SUCCESS)
        {
            return std::wstring();
        }
    }

    if (RegQueryValueExW(hKey, value, nullptr, nullptr, (LPBYTE)&val, &value_length) != ERROR_SUCCESS)
    {
        return std::wstring();
    }

    return std::wstring(val);
}
