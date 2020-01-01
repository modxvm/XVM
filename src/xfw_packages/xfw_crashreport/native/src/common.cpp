/**
 * This file is part of the XVM Framework project.
 *
 * Copyright (c) 2018-2020 XVM Team.
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

#include <codecvt>
#include <vector>

#include <Shlwapi.h>

#include "common.h"

template<typename ... Args>
std::wstring string_format(const std::wstring& format, Args ... args)
{
    size_t size = std::swprintf(nullptr, 0, format.c_str(), args ...) + 1; // Extra space for '\0'
    std::unique_ptr<wchar_t[]> buf(new wchar_t[size]);
    std::swprintf(buf.get(), size, format.c_str(), args ...);
    return std::wstring(buf.get(), buf.get() + size - 1); // We don't want the '\0' inside
}

std::wstring string_to_wstring(const std::string& str)
{
    std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> converter;
    return converter.from_bytes(str);
}

std::wstring GetModuleVersion(HMODULE hModule)
{
    HRSRC res_src = FindResource(hModule, MAKEINTRESOURCE(VS_VERSION_INFO), RT_VERSION);
    if (res_src == nullptr)
        return std::wstring();

    HGLOBAL res = LoadResource(hModule, res_src);
    if (res == nullptr)
        return std::wstring();

    LPVOID data = LockResource(res);
    if (data == nullptr)
        return std::wstring();

    DWORD res_size = SizeofResource(hModule, res_src);
    std::vector<char> datavec;
    datavec.resize(res_size);
    memcpy(datavec.data(), data, res_size);

    UINT size = 0;
    VS_FIXEDFILEINFO *vsinfo = nullptr;
    if (!VerQueryValueA(reinterpret_cast<LPCVOID>(datavec.data()), "\\", reinterpret_cast<LPVOID*>(&vsinfo), &size))
        return std::wstring();

    if (size == 0)
        return std::wstring();

    if (vsinfo->dwSignature != 0xfeef04bd)
        return std::wstring();

    return string_format(L"%d.%d.%d.%d",
        (vsinfo->dwFileVersionMS >> 16) & 0xffff,
        (vsinfo->dwFileVersionMS >> 0) & 0xffff,
        (vsinfo->dwFileVersionLS >> 16) & 0xffff,
        (vsinfo->dwFileVersionLS >> 0) & 0xffff
    );
}

std::wstring GetModuleVersion(const wchar_t* moduleName)
{
   return GetModuleVersion(GetModuleHandleW(moduleName));
}

std::filesystem::path GetModuleDirectory(HMODULE hModule)
{
    WCHAR Path[MAX_PATH];
    GetModuleFileNameW(hModule, Path, MAX_PATH);
    PathRemoveFileSpecW(Path);

    return std::filesystem::path(Path);
}

std::filesystem::path GetModuleDirectory(const wchar_t* moduleName)
{
    return GetModuleDirectory(GetModuleHandleW(moduleName));
}
